#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;

my $EXE = "setupDB.pl";

# ======================== Get bin PATH ==========
my $mgca_dir;
my $bin = `which mgca`;
if ($bin=~/(.+)\/mgca/) {
	$mgca_dir = $1;
}

my(@Options, $help, $all, $pVOG, $DBpath);
setOptions();

# Option setting routines
sub setOptions {
  use Getopt::Long;
  @Options = (
    "GENERAL",
    {OPT=>"help",       VAR=>\&usage,               DESC=>"This help"},
    {OPT=>"all",   VAR=>\$all,              DESC=>"Setup all databases for MGCA"},
    {OPT=>"pVOG",   VAR=>\$pVOG,              DESC=>"Setup pCOG database for prophage mining"},
    {OPT=>"DBpath=s",   VAR=>\$DBpath, DEFAULT=>$mgca_dir,              DESC=>"The path to put databases"},
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
  print "SYNOPSIS\n  Set up databases for MGCA\n";
  print "AUTHOR\n  Hualin Liu\n";
  print "USAGE\n";
  print "    $EXE --<all|pVOG|> --DBpath <PATH>\n";

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


# Setup database for prophage
if ($all or $pVOG) {
	system("wget -c https://ftp.ncbi.nlm.nih.gov/pub/kristensen/pVOGs/downloads/All/AllvogHMMprofiles.tar.gz");
	system("tar -zxvf AllvogHMMprofiles.tar.gz");
	system("cat AllvogHMMprofiles/* > pVOGs.hmm");
	if ($DBpath) {
		system("mv pVOGs.hmm $DBpath");
		system("hmmpress -f $DBpath/pVOGs.hmm");
		system("chmod a+x $DBpath/pVOGs.*");
	}else {
		system("mv pVOGs.hmm $mgca_dir");
		system("hmmpress -f $mgca_dir/pVOGs.hmm");
		system("chmod a+x $mgca_dir/pVOGs.*");
	}
	system("rm -rf AllvogHMMprofiles AllvogHMMprofiles.tar.gz");
}

# Example 1: Finding CRISPR-Cas systems in a cyanobacteria genome

## Use the makeblastdb utility to convert a Cas protein database to BLAST format
tar zxvf cas_database.tar.gz
cat cas1.fasta | makeblastdb -dbtype prot -title cas1 -hash_index -out cas1_db
cat cas[2-9].fasta cas1[0-2].fasta casphi.fasta | makeblastdb -dbtype prot -title cas_all -hash_index -out cas_all_but_1_db

# Use Gene Finder to search for CRISPR-Cas loci
mkdir example_1_output

## uses Opfi's gene_finder.pipeline module to search for CRISPR-Cas systems
python run_genefinder.py

## Visualize annotated CRISPR-Cas gene clusters with Operon Analyzer
python run_OperonAnalyzer.py

# Example 2: Filter and classify CRISPR-Cas systems based on genomic composition

## Make another temporary directory for output
mkdir example_2_output

## Filter Gene Finder output and extract high-confidence CRISPR-Cas systems
python run_FilterGeneFinder.py

