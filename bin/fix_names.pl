#!/bin/perl
# Original taken from wicked cool perl scripts 2006

use strict;
use warnings;

use Getopt::Std;
use Term::ANSIColor;

getopts('is');
our($opt_i, $opt_s);

sub wrp_{
    my ($str) = @_;
    return color('blue') . 
           "[" .
           color('white') .
           $str  .
           color('blue') .
           "]" .
           color('reset'); 
}

sub fancy_string {
    my ($old_name, $new_name) = @_;
    return 
        wrp_(">>") .
        " " .
        color('white') .
        $old_name .
        color('green') .
        " -> " . 
        color('white') .
        " $new_name\n" .
        color('reset');
}

foreach my $file_name (@ARGV) {
    # Compute the new name
    my $new_name = $file_name;

    $new_name =~ tr/ /./;
    $new_name =~ tr/\t/./;
    $new_name =~ tr/;/:/;
    if ($opt_s){
        $new_name =~ tr/_/./;
    } else {
        $new_name =~ tr/_/-/;
    }
    $new_name =~ s/\.-\./-/g;
    $new_name =~ s/\,[_-]/-/g;
    $new_name =~ s/[,.]\././g;
    $new_name =~ s/-\./-/g;
    $new_name =~ s/\.-/-/g;
    $new_name =~ s/[\(\)\[\]<>\\]//g;
    $new_name =~ s/[\'\`]/=/g;
    $new_name =~ s/^[--]//g;
    $new_name =~ s/\&/.and./g;
    $new_name =~ s/\$/.dol./g;

    # Make sure the names are different
    if ($file_name ne $new_name){
        # If a file already exists by that name
        # compute a new name.
        if (-f $new_name){
            my $ext = 0;

            while (-f $new_name.".".$ext){
                $ext++;
            }
            $new_name = $new_name.".".$ext;
        }
        print fancy_string($file_name, $new_name);
        if ($opt_i){
            rename($file_name, $new_name);
        }
    }
}
