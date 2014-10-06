#!/usr/bin/perl -w
##
## Extracts links from a HTML page
## Copyright (c) 2005 by Berislav Kovacki (beca/AT/sezampro.yu)
## Copyright (c) 2005,2006 by Michal Nazarewicz (mina86/AT/mina86.com)
##
## This software is OSI Certified Open Source Software.
## OSI Certified is a certification mark of the Open Source Initiative.
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, see <http://www.gnu.org/licenses/>.
##
## This is part of Tiny Applications Collection
##   -> http://tinyapps.sourceforge.net/
##

#
# Documentation at the end of file.
#

use strict;
use warnings;

use English;
use Getopt::Long;
use Pod::Usage;

use URI::URL;
use URI::file;
use LWP::UserAgent;
use HTML::LinkExtor;


my $VERSION = '1.07';


my $url = '';
my @tags = ();
my $noabs = 0;
my $base_uri;


pod2usage() unless GetOptions(
    'tag|tags|t=s' => \@tags,
    'relative|r'   => \$noabs,
    'base|b=s'     => \$base_uri,
    'help|h|?'     => sub { pod2usage(-verbose => 1); });
@tags = split(/,/, join ',', @tags);


my $error = 0;
my $parser = HTML::LinkExtor->new(\&linkcallback);
my $ua = LWP::UserAgent->new;
my @links;


@ARGV = ('-') unless (@ARGV);
while (@ARGV) {
  $url = shift(@ARGV);
  @links = ();
  my $base;

  if ($url eq '-') {
    $parser->parse( sub { <STDIN> } );
    $base = defined $base_uri ? $base_uri : URI::file->cwd;
    @links = map { $_ = url($_, $base)->abs; } @links unless ($noabs);

  } else {
    $url = URI->new($url)->abs(URI::file->cwd);

    my $res = $ua->request(HTTP::Request->new(GET => $url),
                           sub { $parser->parse($_[0]) });

    if (!$res->is_success) {
      print('Parse failed: ');
      print($res->status_line);
      print("\n");
      $error = 1;
    } elsif (!$noabs) {
      $base = defined $base_uri ? $base_uri : $res->base;
      @links = map { $_ = url($_, $base)->abs; } @links;
    }
  }

  print(join("\n", @links), "\n") if (@links);
}

exit($error);


sub linkcallback {
  my ($tag, %links) = @_;
  push @links, values %links if (!@tags || grep { $_ eq $tag } @tags);
}


__END__

=head1 NAME

extractlinks - Extracts links from a HTML page

=head1 DESCRIPTION

The extractlinks utility shall search the HTML file specified by the
url parameter and extract all contained links.  The url must be
specified as absolute URL.

=head1 SYNOPSIS

extractlinks [ -t tags ] [ -r | -b base ] [ -- ] [ url ... ]

=head1 OPTIONS

=over 8

=item B<-h --help>

Displays help screen.

=item B<-r --relative>

Won't make links absolute.

=item B<-b --base=>I<base>

Uses I<base> as relative links base address instead of base address of
input file.

=item B<-t --tag=>I<tags>

A comma separated list of HTML tags to search for links.  This option
may be specified several times.  If not give, links from all HTML rags
are extracted.

=item I<url>

Can be a URI (eg. I<http://mina86.com/>), a file name
(eg. I<index.html>) or a minus sign which will cause the script to
read HTML page from standard input.  If no URLs are given, - is
assumed.  Beware that I<www.google.com> will cause script to open a
B<file> of a given name and not a Google page.

=back

=head1 AUTHOR

Berislav Kovacki <beca@sezampro.yu>,
Michal Nazarewicz <mina86@mina86.com>

=cut
