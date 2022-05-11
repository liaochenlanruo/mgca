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

