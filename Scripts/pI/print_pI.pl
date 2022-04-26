#!/usr/bin/env perl
use strict;
use warnings;
# name: print_pI.pl
# Author: Liu Hualin
# Date: 2022.01.03

my $EXE = "print_pI.pl";
my(@Options, $help, $aa_suffix);
setOptions();

# Option setting routines
sub setOptions {
  use Getopt::Long;
  @Options = (
    "GENERAL",
    {OPT=>"help",       VAR=>\&usage,               DESC=>"This help"},
    {OPT=>"aa_suffix=s",   VAR=>\$aa_suffix, DEFAULT=>'.faa',              DESC=>"Specify the suffix of input files"},
  );

  @ARGV or usage(1);

  &GetOptions(map {$_->{OPT}, $_->{VAR}} (grep { ref } @Options)) || usage(1);

# Now setup default values.
  foreach (grep { ref } @Options) {
    if (defined($_->{DEFAULT}) && !defined(${$_->{VAR}})) {
      ${$_->{VAR}} = $_->{DEFAULT};
    }
  }
}

sub usage {
  my($exitcode) = @_;
  $exitcode = 0 if $exitcode eq 'help'; # what gets passed by getopt func ref
  $exitcode ||= 0;
  select STDERR if $exitcode; # write to STDERR if exitcode is error
  print "VERSION\n  V1.0\n";
  print "SYNOPSIS\n  Calculate statistics of protein properties and print pI of all protein sequences.\n";
  print "AUTHOR\n  Hualin Liu\n";
  print "USAGE\n";
  print "    $EXE --aa_suffix <suffix of input files>\n";

  foreach (@Options) {
    if (!ref $_) { print $_,"\n"; next }  # print text lines
    my $opt = $_->{OPT};
    $opt =~ s/!$//;
    $opt =~ s/=s$/ [X]/;
    $opt =~ s/=i$/ [N]/;
    $opt =~ s/=f$/ [n.n]/;
    printf "  --%-13s %s%s.\n",$opt,$_->{DESC},
           defined($_->{DEFAULT}) ? " [$_->{DEFAULT}]" : "";
  }

  exit($exitcode);
}

my @genome = glob("*$aa_suffix");
foreach  (@genome) {
	$_=~/(\S+)$aa_suffix/;
	my $out = $1 . ".pepstats";
	my $pi = $1 . ".pI";
	system("pepstats -sequence $_ -outfile $out");

	my %hash;
	my $seqnum = 0;
	open IN, "$out" || die;
	while (<IN>) {
		chomp;
		if (/^(Isoelectric Point = )(\S+)/) {
			my $pi = sprintf "%.1f", $2;
			$hash{$pi}++;
			$seqnum++;
		}
	}
	close IN;


	open OUT, ">$pi" || die;
	print OUT "Isoelectric point\tRelative frequency\n";
	foreach  (keys %hash) {
		my $frequency = sprintf "%.2f", $hash{$_}/$seqnum;
		print OUT "$_\t$frequency\n";
	}
	close OUT;
}