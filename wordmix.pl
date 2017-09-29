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

my $num_args = $#ARGV + 1;
die "Usage: $0 <characters>" if ($num_args != 1);

my $wordcount = 10;
my $allowed_characters = $ARGV[0];
my $wordmaxlength = 7;
my @words = ();
my @unfiltered = ();

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

while (<STDIN>) {
    my @split_words = split (/\s+/, $_);
    foreach my $word (@split_words) {
        next if (not $word =~ /^[$allowed_characters]+$/);
        next if length $word > $wordmaxlength;
        push @unfiltered, $word;
    }
}

@words = uniq(@unfiltered);

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
