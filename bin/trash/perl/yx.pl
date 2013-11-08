#!/usr/bin/perl
# Youtube streamer / downloader
# 
# Common-Deps: URI::Escape, LWP::Simple
# Streaming-Deps: mplayer
# Download-Deps: HTML::Entities, curl, wget
#
# Copyright 2011, Olof Johansson <olof@ethup.se>
#
# Copying and distribution of this file, with or without 
# modification, are permitted in any medium without royalty 
# provided the copyright notice are preserved. This file is 
# offered as-is, without any warranty.

our $VERSION = 3.14159;
use warnings;
use strict;
use LWP::Simple qw/get/;
use URI::Escape;
use Data::Dumper;
use Getopt::Long;

sub get_filename {
	require HTML::Entities;
	HTML::Entities->import;
	my $hash = shift;
	my $htmlr = shift;
	my ($_) = $$htmlr =~ /<title>\s*(.*?)\s*-\s*YouTube\s*<\/title>/s;

	$_ = decode_entities($_);
	s/(?<=\s)&(?=\s)/and/g;
	s/ +/_/g;
	s/[^\w_]//g;
	
	return lc $_ . '.' . $hash->{ext};
}

my @pref = qw/45 44 43 18/;
my $opts = {};
GetOptions($opts, 
	'itag=i', 
	'stream', 
	'out=s',
	'download|d', 
	'curl', 
	'wget',  
	'dumper'
);

$opts->{curl} = 1 if $opts->{download};
$opts->{stream} = 1 unless $opts->{curl} || $opts->{wget};

@ARGV > 0 || die('needs an uri as argument');
my $html = get($ARGV[0]);
my ($map) = $html =~ /url_encoded_fmt_stream_map=(.*?);/;
my %map = map { 
	my $tmp = {
		map { 
			my @kv=split /=/, $_; $kv[1]='null' if @kv==1; @kv 
		} split /&/, $_
	}; 
	$tmp->{url} = uri_unescape($tmp->{url});
	$tmp->{type} = uri_unescape($tmp->{type});
	my $_ = shift @{[split /;/, $tmp->{type}]};
	s;.*/(?:x-)?;;;
	$tmp->{ext} = $_;
	($tmp->{itag} => $tmp)
} split/,/,uri_unescape($map);

$opts->{dumper} && do { print Dumper(\%map); exit 0 };

my $itag;
$itag = $opts->{itag} if $opts->{itag} and $map{$opts->{itag}}->{uri};
$itag = $map{$_}->{url} ? $_ : undef while(!$itag && ($_ = shift @pref));
die("couldn't find uri...") unless $itag;

my $uri = $map{$itag}->{url};
exec("mplayer -fs '$uri'") if $opts->{stream};

my $fname = $opts->{out} // get_filename($map{$itag}, \$html);
die("$fname already exists in .") if -e $fname;
print "Downloading to $fname\n";
exec("curl -Lo $fname '$uri'\n") if $opts->{curl};
exec("wget -O $fname '$uri'") if $opts->{wget};

