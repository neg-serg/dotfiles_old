#!/usr/bin/env perl -w
# print current directory (file names with size and time) tab delimited
# so content can be parsed aunlike ls -l which does not put delimiter
# http://perldoc.perl.org/functions/stat.html
# http://stackoverflow.com/questions/509576/how-do-i-get-a-files-last-modified-time-in-perl
# This prints filename at end so one can still use tabs and get a decent printout
#
use File::stat;
use POSIX;
use Getopt::Long;
my $formatted = ''; # space out
my $type = '';      # show directory and link with a mark
my $classify = '';  # same as type but show executables also

GetOptions ('formatted' => \$formatted, 'file-type' => \$type , 'classify' => \$classify);

# options
# formatted : gives a padded output suitable for viewing
# classify  : adds */= for executable, dir and link
# file-type  : adds /= for dir and link (same as classify except for executable
	
# TODO args could be directory names, then we should explode it
# that's dangerous sine oftence its the result of a glob
my $dir = ".";
if ($#ARGV < 0) {
    opendir DIR,$dir;
    @dir = readdir(DIR);
    close DIR;
}
else 
{
    @dir = @ARGV;
}
foreach(@dir){
    next if $_ eq '.';
    next if $_ eq '..';
    $sb = stat($_);
    next unless defined($sb);
    # next happens on broken links, and files in temp folders
    printf STDERR "Error mtime on file: %s, undefined sb (stat)\n", $_ unless defined($sb);
    $filename = $_;
    my $timestamp = POSIX::strftime( 
             "%Y-%m-%d %H:%M:%S", 
             localtime( 
                 $sb->mtime
                 )
             ) ;
    my $typeflag = '';
    if ($type || $classify) {
        if(-d $dir . "/" . $_){
            $typeflag = '/';
        }elsif(-x $dir . "/" . $_){
            if ($classify) {
                $typeflag = '*';
            }
        }elsif(-l $dir . "/" . $_){
            $typeflag = '=';
        }elsif (-f $dir . "/" . $_ ){
            #$typeflag = ' ';
        }else{
            #$typeflag = "";
        }
        $filename = $filename . $typeflag;
    }
     if($formatted) {
         printf "%10s  %-20s  %-35s\n", $sb->size, $timestamp, $filename;
     }
     else
     {
         # 2013-02-12 - 01:11 trying to pad size so display not too ugly
         printf "%10d\t%s\t%s\n", $sb->size, $timestamp, $filename;
         #printf "%s\t%d\t%s\t%s\n", $filename, $sb->size, $timestamp, $type;
     }
}
