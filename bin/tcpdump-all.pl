#!/usr/bin/perl
# $Id: tcpdump_all.pl,v 1.1 2008/08/20 22:53:56 jcs Exp $
# vim:ts=4
#
# run tcpdump (with any args passed) on all interfaces at once and aggregate
# the output to a single screen; most useful on a router/bridge to monitor
# traffic in one interface and out another
#
# Copyright (c) 2008 joshua stein <jcs@jcs.org>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products
# derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

use IO::Select;
use strict;

# interfaces to ignore
my $ignoreints = '^lo\d+$';

# clean up nicely
$SIG{"TERM"} = $SIG{"KILL"} = $SIG{"INT"} = "bail";

# args passed to us that we pass through to tcpdump
my $args = join(" ", @ARGV);

# find interfaces
my @ifs;
my $maxiflen = 0;
open(IF, "ifconfig |");
while (chop(my $line = <IF>)) {
if ($line =~ /^([a-z]+[0-9]+): /) {
my $int = $1;
if ($int !~ /$ignoreints/) {
push(@ifs, $int);

if (length($int) > $maxiflen) {
$maxiflen = length($int);
}
}
}
}
close(IF);

# fire up tcpdump processes and remember their interface->(pid,handle) mappings
my $set = new IO::Select();
my(%handles, %pids, %revhandles);
foreach my $if (@ifs) {
$pids{$if} = open($handles{$if}, "tcpdump -l -i " . $if . " " . $args
. "|");
$set->add($handles{$if});
$revhandles{$handles{$if}} = $if;
}

# wait for input from any of the tcpdumps and print it with the interface name
while () {
my ($readable) = IO::Select->select($set, undef, undef, undef);
foreach my $h (@$readable) {
sysread($h, my $line, 2048);
my @lines = split("\n", $line);
foreach (@lines) {
print "[" . sprintf("%-" . $maxiflen . "s", $revhandles{$h}) . "] "
. $_ . "\n";
}
}
}

&bail;

sub bail {
foreach my $if (keys(%handles)) {
if ($pids{$if} > 1) {
print "killing pid " . $pids{$if} . "\n";
kill(9, $pids{$if});
close($handles{$if});
}
}

exit;
}
