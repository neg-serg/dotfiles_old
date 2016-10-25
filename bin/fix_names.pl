#!/bin/perl
# Original taken from wicked cool perl scripts 2006

foreach my $file_name (@ARGV) {
    # Compute the new name
    my $new_name = $file_name;

    $new_name =~ s/[ \t]/./g;
    $new_name =~ s/\.-\./-/g;
    $new_name =~ s/\,\././g;
    $new_name =~ s/-\./-/g;
    $new_name =~ s/\.-/-/g;
    $new_name =~ s/_/-/g;
    $new_name =~ s/[\(\)\[\]<>\\]//g;
    $new_name =~ s/[\'\`]/=/g;
    $new_name =~ s/\&/.and./g;
    $new_name =~ s/\$/.dol./g;
    $new_name =~ s/;/:/g;

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
        print "$file_name -> $new_name\n";
        rename($file_name, $new_name);
    }
}

