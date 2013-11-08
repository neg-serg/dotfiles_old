#!/usr/bin/ruby -w
# $Id: uu2mime.rb 3660 2009-09-10 03:01:18Z agriffis $
# 
# This script takes an email message on standard input that might
# contain uuencoded and/or PGP signed sections.  It converts the
# uuencoded sections to application/octet-stream MIME attachments,
# converts the PGP signed sections to multipart/signed, and otherwise
# maintains the MIME structure of the original email.
#
# Copyright 2003 Aron Griffis
# Distributed under the terms of the GNU General Public License v2

# Require some modules from the RMail distribution.  See
#       http://www.lickey.com/rubymail/rubymail/doc/
# These allows us to parse and create RFC2822 MIME messages.
require 'rmail/parser.rb'
require 'rmail/serialize.rb'
require 'rmail/message.rb'

# Regex to match uuencoded sections
UU_RE = %r{
  ^begin[^\S\n]+[0-9]+[^\S\n]+(\S[^\n]*)\n      # first line
  ( .*? )                                       # data
  \n`\nend                                      # end marker
}mx

# Regex to match PGP signed sections
PGP_SIGNED_RE = %r{
  ^-----BEGIN\sPGP\sSIGNED\sMESSAGE-----\n      # first line
  Hash:\s ( \S+ ) \n\n                          # hash identification
  ( .* ) \n                                     # signed data
  ( ^-----BEGIN\sPGP\sSIGNATURE-----\n .*?      # start signature
    ^-----END\sPGP\sSIGNATURE----- )            # end signature
}mx

# Regex to match PGP encrypted sections
PGP_ENCRYPTED_RE = %r{
  ^-----BEGIN\sPGP\sMESSAGE-----\n              # first line
  .*                                            # data
  ^-----END\sPGP\sMESSAGE-----                  # end enrypted
}mx

# Debugging globals
$indent = ''

# Convert uuencoded sections in a text/plain message
def convert_uu(msg)
  nmsg = nil

  nbody = msg.decode.gsub(UU_RE) { |s|
    filename, data = $1, $2.unpack('u')

    $stderr.puts "%sFound a uuencoded section!\n" % [ $indent ] if $DEBUG

    unless nmsg
      # Now that we know there's a uuencoded section, build up a
      # multipart message
      nmsg = RMail::Message.new
      nmsg.header.replace(msg.header.dup)
      nmsg.header.delete('Content-Transfer-Encoding')
      nmsg.header.delete('Content-Length')
      nmsg.header.delete('Lines')
      nmsg.header.set('Content-Type', 'multipart/mixed', 
        'boundary' => '=-=-=-=-uu2mime-boundary-'+nmsg.object_id.to_s)
      nmsg.header.set('Content-Disposition', 'inline')
      nmsg.preamble = "This is a multipart message converted by uu2mime\n"
      nmsg.epilogue = ''

      # This will eventually be the text/plain portion
      nmsg.add_part(RMail::Message.new)
    end

    # Convert this uuencoded section to an attachment
    npart = RMail::Message.new
    npart.header.set('Content-Type', 'application/octet-stream')
    npart.header.set('Content-Disposition', 'attachment', 
      'filename' => filename)
    npart.header.set('Content-Transfer-Encoding', 'base64')
    npart.body = data.pack('m')
    nmsg.add_part(npart)

    # Replace the uuencoded section with a note
    '[-- uu2mime snipped ' + filename + ' --]'
  }

  if nmsg
    # Tack the text/plain portion on the front.
    # Remove the old Content-Transfer-Encoding header since we've
    # decoded the section (is this the best?)
    nmsg.part(0).header.set('Content-Type', 'text/plain',
      'charset' => 'us-ascii')
    nmsg.part(0).header.set('Content-Disposition', 'inline')
    nmsg.part(0).body = nbody
  end

  return nmsg
end

# Convert PGP signed/encrypted sections in a text/plain message.
# In reality this just changes the Content-Type of the part since
# conversion to OpenPGP would insert headers into the signed part,
# causing the signature to be invalid.
def convert_pgp(msg)
  nmsg = nil
  x_action = nil

  if msg.decode =~ PGP_ENCRYPTED_RE
    $stderr.puts "%sFound an encrypted section" % [ $indent ] if $DEBUG
    x_action = 'encrypted'
  elsif msg.decode =~ PGP_SIGNED_RE
    $stderr.puts "%sFound a signed section" % [ $indent ] if $DEBUG
    x_action = 'signed'
  end

  if x_action
    # Duplicate the message
    nmsg = RMail::Message.new
    nmsg.header.replace(msg.header)
    nmsg.body = msg.body

    # Fix the Content-Type according to
    # http://www.tldp.org/HOWTO/Mutt-GnuPG-PGP-HOWTO-8.html#ss8.2
    nmsg.header.set('Content-Type', 'application/pgp',
      'format' => 'text', 'x-action' => x_action)
  end

  return nmsg
end

# Recursive function to convert uuencoded sections to MIME parts
# Returns the new message
def convert_message(msg)

  $stderr.puts "%sConverting message:\n%s" % 
    [ $indent, msg.header.to_s.gsub(/^/, $indent+'  ') ] if $DEBUG

  # Text/plain messages are subject to conversion
  case msg.header.content_type
  when nil, %r{^text/plain}, %r{^message/rfc822}
    $stderr.puts "%sThis is a text/plain message" % [ $indent ] if $DEBUG

    # Start by doing PGP ... if this matches then we don't want to
    # mess with uuencoded stuff because that would break the signature
    nmsg = convert_pgp(msg)
    nmsg = convert_uu(msg) unless nmsg
    msg = nmsg if nmsg
  end

  # Multi-part messages are converted part by part, depth-first.
  # Note this could be acting on a converted text/plain message from
  # above, which is good, because it means we'll fix the
  # Content-Length and Lines headers (as well as convert embedded
  # message, but what are the chances of that?)
  if msg.multipart?

    # Convert each part
    unless msg.header.content_type =~ %r{^multipart/signed}
      # Create the new message.  Start by duplicating the headers. 
      nmsg = RMail::Message.new
      nmsg.header.replace(msg.header.dup)
      nmsg.preamble, nmsg.epilogue = msg.preamble, msg.epilogue

      $indent << '  '     # for $DEBUG
      msg.each_part { |part| nmsg.add_part(convert_message(part)) }
      $indent[0,2] = ''   # for $DEBUG

      # This is now the message
      msg = nmsg
    end

    # Add length headers; requires serializing at this point
    s = msg.to_s # this is the full serialized message
    h = msg.header.to_s
    content_length = s.length - h.length - 1
    if content_length > 0
      msg.header.set('Content-Length', content_length.to_s)
      lines = s.count("\n") - h.count("\n") - 1
      msg.header.set('Lines', lines.to_s)
    end
  end

  return msg
end

# Parse the message from stdin
msg = RMail::Parser.read($stdin)

# Convert the message
msg = convert_message(msg)

# Serialize the message to stdout
RMail::Serialize.write($stdout, msg)

# vim:sw=2
