
#  ----------------------------------------------------------------------------
#  "THE BEER-WARE LICENSE":
#  <ivan@sanchezortega.es> wrote this file. As long as you retain this notice you
#  can do whatever you want with this stuff. If we meet some day, and you think
#  this stuff is worth it, you can buy me a beer in return.
#  ----------------------------------------------------------------------------
# 
# De-shortification of URLs in tweets.
#
# This extension will go through each of the received tweets and try to unshorten 'em all. Not all urls shorteners and redirects are known, so some URLs will not be the final ones.
#
# Requirements: URI::Find and URI::Split and LWP::UserAgent. 
# For Arch: pacman -S perl-libwww and cower -d perl-uri-find
#
# Features:
#  * A non-comprehensive list of known URL shorteners
#  * Fancy ANSI underlining of URLs that will break if the URL contains a search term
#  * Lightweight, HEAD-only requests.
#  * Fancy custom user agent (Unlike main TTYtter), friendlier to website sysadmins.
#  * De-shortened URLs cache, in order to not request anything when you see the same URL time and time again (with RTs or TTs)
#  * Web stats trackeing queries de-crapifier. No more useless ?utm_medium=twitter littering your stream. And a tiny bit of better privacy for you.
#  * Replaces URL-encoded UTF-8 in the URL body for the corresponding character (i.e. "%C4%99" turns into "ę"). Hopefully this won't mess up non-UTF-8 systems.
#
# Bugs:
#  * Might fail to resolve a URL you just posted in stream mode: the t.co shortener needs a couple of seconds after the tweet was posted in order to be able to resolve the URLs.
#  * Might fail to maintain the integrity of a URL with lots of URL-encoded = and & and / and whatnot. Apply the trick commented in the code and report back to me, will you?
#
# Be advised: this extension will send HTTP HEAD requests to all the URLs to be resolved. Be warned of this if you're concerned about privacy.
#
# TODO: Add a redirect config value, so users can set "I don't care about making more useless requests that will take my precious time, just resolve the URL for good!"
# TODO: Prevent the URL cache from growing without control. Maybe flush every X thousand entries or so?
# TODO: Allow a screen width to be specified, and then don't de-shortify links if the width of the tweet would exceed that.



# Show when extension is being loaded
print "-- Don't like to see short URLs, do you?\n";





require URI::Find;

use URI::Split qw(uri_split uri_join);

use LWP::UserAgent;

use Data::Dumper qw{Dumper};



# Define UNDEROFF, to turn off just the underlining
$ESC = pack("C", 27);
$UNDEROFF = ($ansi) ? "${ESC}[24m" : '';


%deshortify_cache = ();


# Given a URL, will unshort it.
$unshort = sub{
	our $verbose;
	our $TTYtter_VERSION;
	our $deshortify_cache;
	my $url = shift;
	
	my $original_url = $url;
	
	# parse and break the url into components
	($scheme, $auth, $path, $query, $frag) = uri_split($url);

# 	print "scheme $scheme auth $auth path $path query $query frag $frag\n" if ($verbose);

	
	# Gathered a few shorteners. Should not be considered as a comprehensive list, but it'll do.
	if (($auth eq "t.co")	or	# twitter
	    ($auth eq "g.co")	or	# Google
	    ($auth eq "j.mp")	or
	    ($auth eq "q.gs")	or
	    ($auth eq "is.gd")	or
	    ($auth eq "tl.gd")	or	# Twitlonger
	    ($auth eq "es.pn")	or
	    ($auth eq "fb.me")	or
	    ($auth eq "tr.im")	or
	    ($auth eq "ow.ly")	or
	    ($auth eq "cl.ly")	or
	    ($auth eq "kl.am")	or
	    ($auth eq "wp.me")	or	# Wordpress
	    ($auth eq "ht.ly")	or
	    ($auth eq "su.pr")	or
	    ($auth eq "ds.io")	or
	    ($auth eq "gu.com")	or	# The Guardian
	    ($auth eq "goo.gl")	or	# Google
	    ($auth eq "owl.li")	or
	    ($auth eq "cli.gs")	or
	    ($auth eq "tpm.ly")	or
	    ($auth eq "htn.to")	or
	    ($auth eq "bbc.in")	or	# bbc.co.uk
	    ($auth eq "kcy.me")	or	# Karmacracy
	    ($auth eq "bit.ly")	or
	    ($auth eq "ur1.ca")	or
	    ($auth eq "dld.bz")	or
	    ($auth eq "rww.to")	or
	    ($auth eq "adf.ly")	or
	    ($auth eq "cos.as")	or
	    ($auth eq "ebz.by")	or
	    ($auth eq "cdb.io")	or
	    ($auth eq "tnw.to")	or	# TheNextWeb
#	    ($auth eq "adf.ly")	or	# Dammit, adf.ly needs some special treatment.
	    ($auth eq "sta.mn")	or	# Gotta love these guys' maps!
	    ($auth eq "vsb.ly")	or
	    ($auth eq "cot.ag")	or
	    ($auth eq "tpt.to")	or
	    ($auth eq "soc.li")	or
	    ($auth eq "smf.is")	or	# Summify
	    ($auth eq "see.sc")	or
	    ($auth eq "mbl.mx")	or
	    ($auth eq "vsb.li")	or
	    ($auth eq "ind.pn")	or	# The Independent.co.uk
	    ($auth eq "awe.sm")	or
	    ($auth eq "htl.li")	or
	    ($auth eq "mun.do")	or	# El Mundo
	    ($auth eq "mzl.la")	or	# Mozilla
	    ($auth eq "tgr.ph")	or	# The Telegraph
	    ($auth eq "nblo.gs")	or	# Networked Blogs
	    ($auth eq "tiny.cc")	or
	    ($auth eq "cort.as")	or
	    ($auth eq "dlvr.it")	or
	    ($auth eq "noti.ca")	or
	    ($auth eq "nyti.ms")	or	# New York Times
# 	    ($auth eq "flic.kr")	or	# Hhhmm, dunno is there's much use in de-shortening to flickr.com anyway.
	    ($auth eq "lnkd.in")	or	# Linkedin
	    ($auth eq "tcrn.ch")	or	# Techcrunch
	    ($auth eq "zite.to")	or
	    ($auth eq "shar.es")	or
	    ($auth eq "ppfr.it")	or
	    ($auth eq "post.ly")	or	# Posterous
	    ($auth eq "yhoo.it")	or	# Yahoo
	    ($auth eq "vrge.co")	or	# The Verge
	    ($auth eq "read.bi")	or	# Business Insider
	    ($auth eq "seod.co")	or
	    ($auth eq "6sen.se")	or
	    ($auth eq "neow.in")	or	# NeoWin
	    ($auth eq "econ.st")	or	# The Economist
	    ($auth eq "pear.ly")	or
	    ($auth eq "huff.to")	or	# The Huffington Post
	    ($auth eq "hint.fm")	or
	    ($auth eq "amba.to")	or	# Ameba.jp
	    ($auth eq "trib.al")	or
	    ($auth eq "ymlp.com")	or
	    ($auth eq "twurl.nl")	or
	    ($auth eq "short.to")	or
	    ($auth eq "pulse.me")	or	($auth eq "www.pulse.me")	or
	    ($auth eq "tmblr.co")	or
	    ($auth eq "oreil.ly")	or
	    ($auth eq "short.ie")	or
	    ($auth eq "menea.me")	or	# Menéame
	    ($auth eq "flpbd.it")	or	# Flipboard
	    ($auth eq "refer.ly")	or
	    ($auth eq "egent.me")	or
	    ($auth eq "mcmgz.in")	or	# Mac Magazine
	    ($auth eq "nokia.ly")	or
	    ($auth eq "s.vfs.ro")	or
	    ($auth eq "on.fb.me")	or
#	    ($auth eq "youtu.be")	or	# This one is actually useful: no information is gained by de-shortening.
	    ($auth eq "keruff.it")	or
	    ($auth eq "on.rt.com")	or	# RT
	    ($auth eq "on.mash.to")	or	# Mashable
	    ($auth eq "feedly.com")	or
	    ($auth eq "on.wsj.com")	or	# Wall Street Journal
	    ($auth eq "tinyurl.com")	or
	    ($auth eq "www.tumblr.com")	or
	    ($auth eq "feeds.gawker.com")	or
	    ($auth eq "feeds.feedburner.com")	or
	    ($auth eq "feedproxy.google.com")	or
	    ($auth eq "www.pheedcontent.com")	or	# Oh, look, Imma l337 h4xx0r. Geez.
	    ($auth =~ m/^news.google.[a-z]{2,3}/)	or	# Hah! You thought you were going to pollute my links, did you, google news?
	    ($auth eq "www.linkedin.com" and $path eq "/slink")	or	# A tricky one. lnkd.in redirects to www.linkedin.com/slink?foo, which redirects again.
	    ($auth =~ m/^feeds\./)	or	# OK, I've had enough of you, feeds.whatever.whatever!
	    ($auth =~ m/feedsportal\.com/)	or	# Gaaaaaaaaaaaaaaaah!
	    ($auth =~ m/^rss\./)	or	# Will this never end?
	    ($auth =~ m/^rd.yahoo\./)	or	# Yahoo feeds... *sigh*
	    ($auth eq "www.google.com" and $path eq "/url")	# I hate it when people paste URLs from the stupid google url tracker.
	    )
	{
		print $stdout "-- Yo, deshortening $url ($auth)\n" if ($verbose);
		
		# Check the cache first.
		if ($deshortify_cache{$original_url})
		{
			print $stdout "-- Deshortify cache hit: $url -> " . $deshortify_cache{$original_url} . "\n" if ($verbose);
			return &$unshort($deshortify_cache{$original_url});
		}
		
		
		# Visit the link with a HEAD request, see if there's a redirect header. If redirected -> that's the URL we want.
		my $ua = LWP::UserAgent->new;
		$ua->max_redirect( 0 );	# Don't redirect, just return the headers and look for a "Location:" one manually.
		$ua->agent( "TTYtter $TTYtter_VERSION URL de-shortifier (" . $ua->agent() . ") (+http://www.floodgap.com/software/ttytter/)" ); # Be good net citizens and say how nerdy we are and that we're a bot
		
		my $request  = HTTP::Request->new( HEAD => "$url" );
		my $response = $ua->request($request);
		
# 		if ( $response->previous ) {
# 		if ( $response->is_success and $response->previous ) {
		if ($response->header( "Location" )) {
# 			$url = $response->request->uri;
			$url = $response->header( "Location" );
			print "-- New: $url\n" if ($verbose);
			
			# Add to cache
			$deshortify_cache{$original_url} = $url;


			# Let's run the URL again - maybe this is another short link!
			return &$unshort($url);
		}
	}
	# TODO: treat adf.ly links. Pull off the entire page, then run a regexp searching for var url = 'http://adf.ly/go/whatever';	
	else
	{
		print $stdout "-- That URL doesn't seem like it's a URL shortener, it must be the real one.\n" if ($verbose);
		
		# Do some heuristics and try to stave off stupid, spurious crap out of URLs. Like "?utm_source=twitterfeed&utm_medium=twitter
		# This crap is used for advertisers to track link visits. Screw that!
		
		# Stuff to cut out: utm_source utm_medium utm_term utm_content utm_campaign (from google's ad campaigns)
		# Stuff to cut out: spref=tw (from blogger)
		
# 		print "-- scheme $scheme auth $auth path $path query $query frag $frag\n" if ($verbose);
		if ($query)
		{
			@pairs = split(/&/, $query);
			foreach $pair (@pairs){
				($name, $value) = split(/=/, $pair);
				
				if ($name eq "utm_source" or $name eq "utm_medium" or $name eq "utm_term" or $name eq "utm_content" or $name eq "utm_campaign" 
					or ( $name eq "tag" and $value eq "as.rss" ) 
					or ( $name eq "ref" and $value eq "rss" ) 
					or ( $name eq "newsfeed" and $value eq "true" ) 
					or ( $name eq "spref" and $value eq "tw" ) 
					or ( $name eq "spref" and $value eq "fb" ) 
					or ( $name eq "spref" and $value eq "gr" ) )
				{
					my $expr = quotemeta("$name=$value");	# This prevents strings with "+" to be interpreted as part of the regexp
					$query =~ s/($expr)&//;
					$query =~ s/&($expr)//;
					$query =~ s/($expr)//;
					print $stdout "---- Trimming spammy URL parameters: $name = $value - now $query\n" if ($verbose);
				}
			}
			$url = uri_join($scheme, $auth, $path, $query, $frag);
		}
		
# 		# Dirty trick to prevent escaped = and & and # to be unescaped (and mess up the query string part) - escape them again!
# 		$url =~ s/%24/%2524/i;	# $
# 		$url =~ s/%26/%2526/i;	# &
# 		$url =~ s/%2B/%252B/i;	# +
# 		$url =~ s/%2C/%252C/i;	# ,
# 		$url =~ s/%2F/%252F/i;	# /
# 		$url =~ s/%3A/%253A/i;	# :
# 		$url =~ s/%3B/%253B/i;	# ;
# 		$url =~ s/%3D/%252B/i;	# =
# 		$url =~ s/%3F/%252B/i;	# ?
# 		$url =~ s/%40/%252B/i;	# @
		
		# Replace %XX for the corresponding character - makes URLs more compact and legible. Hopefully won't mess anything up.
		$url =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
		# Waaaait a second, did we just replace "%20" for " "? That'll just mess up things...
		$url =~ s/ /+/g;
	}
	
# 	print $stdout "-- $original_url de-shortened into $url\n" if ($verbose && $url != $original_url) ;

	
	# Hey, let's underline URLs!
    #return ${UNDER} . $url . ${UNDEROFF};
	return $url ;
};



$handle = sub {
	our $verbose;
	my $tweet = shift;

	my $text = $tweet->{'text'};

	# Why the hell are there backslashes messing up the forward slashes in the URLs?
	# Will this break something???
	$text =~ s/\\\//\//g;

	# Yeah, a \n just before a http:// will mess things up.
	$text =~ s/\\nhttp:\/\//\\n http:\/\//g;

	# Any URIs you find, run them through unshort()...
	my $finder = URI::Find->new(sub { &$unshort($_[0]) });

	$how_many_found = $finder->find(\$text);		

	print $stdout "-- $how_many_found URLs de-shortened\n" if ($verbose);

	$tweet->{'text'} = $text;
	
	&defaulthandle($tweet);
	return 1;

# 	return $text;
};




