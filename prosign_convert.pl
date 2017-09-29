#!/usr/bin/env perl

use strict;
use warnings;

my $num_args = $#ARGV + 1;
die "Usage: $0 <file_to_convert> ...\n" if ($num_args < 1);

sub convert_file {
    my ($filename) = @_;
    open(my $file, '<:encoding(UTF-8)', $filename)
        or die "Could not open file '$filename' $!";

    print "converting file: $filename\n";
    my @content = <$file>;
    close($file);

    foreach my $line (@content) {
        $line =~ s/\^bt/=/g; # -...-
            $line =~ s/\^sk/%/g; # ...-.-
            $line =~ s/\^ar/+/g; # .-.-.
            $line =~ s/\^ka/#/g; # -.-.-
            print $line;
    }
}

while (my $filename = shift @ARGV) {
    convert_file($filename);
}
