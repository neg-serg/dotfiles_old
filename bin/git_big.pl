#!/usr/bin/perl
use 5.10.0;
use strict;
use warnings;

use File::Temp qw(tempdir);
END { chdir( $ENV{HOME} ); }
my $tempdir = tempdir( "git-files_tempdir.XXXXXXXXXX", TMPDIR => 1, CLEANUP => 1 );

my $min = shift;
$min =~ /^\d+$/ or die "need a number";

# ----------------------------------------------------------------------

my @refs =qw(HEAD);
@refs = @ARGV if @ARGV;

# first, find blob SHAs and names (no sizes here)
open( my $objects, "-|", "git", "rev-list", "--objects", @refs) or die "rev-list: $!";
open( my $blobfile, ">", "$tempdir/blobs" ) or die "blobs out: $!";

my ( $blob, $name );
my %name;
my %size;
while (<$objects>) {
    next unless / ./;    # no commits or top level trees
    ( $blob, $name ) = split;
    $name{$blob} = $name;
    say $blobfile $blob;
}
close($blobfile);

# next, use cat-file --batch-check on the blob SHAs to get sizes
open( my $sizes, "-|", "< $tempdir/blobs git cat-file --batch-check | grep blob" ) or die "cat-file: $!";

my ( $dummy, $size );
while (<$sizes>) {
    ( $blob, $dummy, $size ) = split;
    next if $size < $min;
    $size{ $name{$blob} } = $size if ( $size{ $name{$blob} } || 0 ) < $size;
}

my @names_by_size = sort { $size{$b} <=> $size{$a} } keys %size;

say "
The size shown is the largest that file has ever attained.  But note
that it may not be that big at the commit shown, which is merely the
most recent commit affecting that file.
";

# finally, for each name being printed, find when it was last updated on each
# branch that we're concerned about and print stuff out
for my $name (@names_by_size) {
    say "$size{$name}\t$name";

    for my $r (@refs) {
        system("git --no-pager log -1 --format='%x09%h%x09%x09%ar%x09$r' $r -- $name");
    }
    print "\n";
}
print "\n";
