#!/usr/bin/perl
use strict;
use warnings;

# Author: Liu hualin
# Date: April 25, 2022

my $EXE = "run_pilercr.pl";

my(@Options, $help, $scaf_suffix, $minarray, $mincons, $minrepeat, $maxrepeat, $minspacer, $maxspacer, $minrepeatratio, $minspacerratio);
setOptions();

# Option setting routines
sub setOptions {
  use Getopt::Long;
  @Options = (
    {OPT=>"help",       VAR=>\&usage,                                   DESC=>"This help"},
    {OPT=>"scaf_suffix=s",   VAR=>\$scaf_suffix, DEFAULT=>'.fa',        DESC=>"Specify the suffix of Genome/Scaffolds/Contigs files"},
    {OPT=>"minarray=i",   VAR=>\$minarray, DEFAULT=>"3",                DESC=>"Must be at least <minarray> repeats in array"},
    {OPT=>"mincons=f",   VAR=>\$mincons, DEFAULT=>"0.9",                DESC=>"Minimum conservation. At least <minarray> repeats must have identity >= <mincons> with the consensus sequence. Value is in range 0 .. 1.0 (< 1.0 is recommended)"},
    {OPT=>"minrepeat=i",   VAR=>\$minrepeat, DEFAULT=>"16",             DESC=>"Minimum repeat length"},
    {OPT=>"maxrepeat=i",   VAR=>\$maxrepeat, DEFAULT=>'64',             DESC=>"Maximum repeat length"},
    {OPT=>"minspacer=i",   VAR=>\$minspacer, DEFAULT=>'8',              DESC=>"Minimum spacer length"},
    {OPT=>"maxspacer=i",   VAR=>\$maxspacer, DEFAULT=>'64',             DESC=>"Maximum spacer length"},
    {OPT=>"minrepeatratio=f",   VAR=>\$minrepeatratio, DEFAULT=>'0.9',  DESC=>"Minimum repeat ratio"},
    {OPT=>"minspacerratio=f",   VAR=>\$minspacerratio, DEFAULT=>'0.75', DESC=>"Minimum repeat ratio"},
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
  print "SYNOPSIS\n  Detection of CRISPR repeats in bacterial genomes\n";
  print "AUTHOR\n  Hualin Liu\n";
  print "USAGE\n";
  print "    $EXE --scaf_suffix <suffix of input files> --minarray <3> --mincons <0.9> --minrepeat <16> --maxrepeat <64> --minspacer <8> --maxspacer <64> -minrepeatratio <0.9> -minspacerratio <0.75>\n";

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
  print "\t'Ratios' are defined as minlength / maxlength, thus a value close to 1.0 requires lengths to be similar, 1.0 means identical lengths. Spacer lengths sometimes vary significantly, so the default ratio is smaller. As with --mincons, using 1.0 is not recommended.\n";
  exit($exitcode);
}


my @scaf = glob("*$scaf_suffix");
foreach  (@scaf) {
	$_=~/(.+)$scaf_suffix/;
	my $out = $1 . "_crispr.txt";
	my $seq = $1 . "_crispr.seq";
	system("pilercr -in $_ -out $out -seq $seq -noinfo -minarray $minarray -mincons $mincons -minrepeat $minrepeat -maxrepeat $maxrepeat -minspacer $minspacer -maxspacer $maxspacer -minrepeatratio $minrepeatratio -minspacerratio $minspacerratio");
}
