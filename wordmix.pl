#!/usr/bin/perl
#
# Small simple perl script that takes a wordlist (seperated by
# newline) on standart input and returns a random mix of words that
# only consist of certain characters.
#
# This is useful for learning CW or morse code when you still only
# know a limited amount of characters.
#
# You can use this in connection with ebook2cw to train listening with
# real words.
#
use strict;
use warnings;

my $wordcount = 10;
my $allowed_characters = "kmuresnaptlwi,jz=foy,v";
#my $allowed_characters = "kmuresnaptlwi,jz=foy,vg5/q92h38b?47c1d60x";
my $wordmaxlength = 7;
my @words = ();

while (<>) {
    next if not /^[$allowed_characters]+$/;
    next if length > $wordmaxlength;

    s/\s+$//;
    push @words, $_;
}

foreach my $i (0 .. $#words) {
    my $range = $#words - $i + 1;
    my $idx = (rand $range) + $i;
    my $tmp = $words[$i];
    $words[$i] = $words[$idx];
    $words[$idx] = $tmp;
}

my $words = 0;
foreach (@words) {
    print "$_ ";
    $words++;
    last if ($words >= $wordcount);
}

print "\n";
