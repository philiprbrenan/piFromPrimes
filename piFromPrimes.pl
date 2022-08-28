#!/usr/bin/perl -I/home/phil/perl/cpan/DataTableText/lib/
#-------------------------------------------------------------------------------
# Leonhard Euler's formula for pi using the prime numbers nicely illustrates the
# complete and utter uselessness of computers for doing real mathematics.
# Philip R Brenan at appaapps dot com, Appa Apps Ltd Inc., 2022
#-------------------------------------------------------------------------------
use v5.30;
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);
use utf8;

my $home   = currentDirectory;                                                  # Home folder

sub nearest4($)                                                                 # Given a number find the nearest multiple of 4
 {my ($n) = @_;                                                                 # Number
  my $r = $n % 4;
  $r < 2 ? $n - $r : $n + 4 - $r;
 }

my $N = 1e6;                                                                    # The number of primes we are going to multiply
my $primes = '00'.('1' x $N);

my @p;

for my $i(2..$N)                                                                # Sieve of Erastothenes
 {if (substr($primes, $i, 1))
   {push @p, $i;
    for my $j(1..$N/$i)                                                         # Strike
     {substr($primes, $i * $j, 1) = '0';
     }
   }
 }

shift @p;                                                                       # Remove the only even prime

my $p4 = 0;                                                                     # Product of primes make pi
for my $p(@p)
 {my $f = nearest4($p);
  $p4 += log($p) - log($f);
 }
say STDERR sprintf "Pi is approximately: %.12f after %.0e primes", 4*exp($p4), $N;

# Pi is approximately: 3.141599411558 after 1e+06 primes
# Pi is approximately: 3.141648570896 after 1e+07 primes
