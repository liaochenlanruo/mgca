#!/usr/bin/env perl
use strict;
use warnings;
use Bio::SeqIO;
# Author: Liu hualin
# Date: Oct 8, 2021

my $EXE = "run_islandpath.pl";
my(@Options, $help, $gbk_suffix);
setOptions();

# Option setting routines
sub setOptions {
  use Getopt::Long;
  @Options = (
    "GENERAL",
    {OPT=>"help",       VAR=>\&usage,               DESC=>"This help"},
    {OPT=>"gbk_suffix=s",   VAR=>\$gbk_suffix, DEFAULT=>'.gbk',              DESC=>"Specify the suffix of GenBank files"},
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
  print "SYNOPSIS\n  Predict genomic island from GenBank files\n";
  print "AUTHOR\n  Hualin Liu\n";
  print "USAGE\n";
  print "    $EXE --gbk_suffix <suffix of input files>\n";

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


# Split GenBank files
my @gbk = glob("*$gbk_suffix");# 批处理所有后缀为.gbk的文件
foreach  (@gbk) {
	$_=~/(.+)$gbk_suffix/;
	my $str = $1;
	open IN, "$_" || die;
	local $/ = "LOCUS";
	<IN>;
	while (<IN>) {
		chomp;
		$_=~/\s+(\S+)/;
		my $scaf = $1;
		my $out = $str . "_" . $scaf . ".gb";
		my $assession = $str . "_" . $scaf;
		$_=~s/ACCESSION.+/ACCESSION   $assession/g;# 添加ACCESSION number
		open OUT, ">$out" || die;
		print OUT "LOCUS$_";
		close OUT;
	}
	close IN;
}


# predict Gene Islands
$/ = "\n";
my @gb = glob("*.gb");
foreach  (@gb) {
	$_=~/(.+).gb/;
	my $out = $1 . ".island";
	system("islandpath $_ $out");
}

# Get features from GenBank files
foreach my $gb (@gb) {
	$gb=~/(.+).gb/;
	my $str = $1;
	my $out = $str . ".list";
	my $seqin = Bio::SeqIO->new( -format => 'genbank', -file => "$gb");
	open OUT, ">$out" || die;
	while( (my $seq = $seqin->next_seq) ) {
		foreach my $sf ( $seq->get_SeqFeatures ) {
			if( $sf->primary_tag eq 'CDS' ) {
				my @tags = $sf ->get_all_tags();
				#print join("\t", @tags) . "\n";
				print OUT $sf->get_tag_values('locus_tag'), "\t", $sf->start, "\t", $sf->end, "\t", $sf->strand, "\t", $sf->get_tag_values('product'), "\t", $sf->get_tag_values('translation'),"\n";
			}
		}
	}
}

# Parser the results
my (%hash, %gi, %list, %gif);
open OUT, ">All_island.txt" || die;
print OUT "Sequence IDs	Predictor	Category	GI Start	GI End	.	Strand	.	Island IDs	Gene IDs	Gene Start	Gene End	Strand	Products	Protein Sequences\n";
open LIST, ">All_island.list" || die;
print LIST "Island IDs\tGI Start\tGI End\tGI Length\tGene Number\tGene IDs\n";
my @GI = glob("*.island");
foreach  (@GI) {
	$_=~/(.+).island/;
	my $list = $1 . ".list";
	open IN, "$_" || die;
	<IN>;
	while (<IN>) {
		chomp;
		$_=~s/[\r\n]+//g;
		my @lines = split /\t/;
		my $start = $lines[3];
		my $end = $lines[4];
		my $id = $lines[-1];
		my $gilen = $end - $start + 1;
		$hash{$id} = $start . "-" . $end . "-" . $id;
		$gi{$id} = $_;
		$gif{$id} = $start . "\t" . $end . "\t" . $gilen;
	}
	close IN;
	open GB, "$list" || die;
	while (<GB>) {
		chomp;
		my @line = split /\t/;
		foreach my $ids (sort keys %hash) {
			my ($start2, $end2, $gi) = split /\-/, $hash{$ids};
			if (($line[1] >= $start2) && ($line[2] <= $end2)) {
				print OUT $gi{$gi} . "\t" . $_ . "\n";
				push @{$list{$gi}}, $line[0];
			}
		}
	}
	close GB;
}
close OUT;

foreach  (sort keys %list) {
	print LIST $_ . "\t" . $gif{$_} . "\t" . @{$list{$_}} . "\t" . join (" ", @{$list{$_}}) . "\n";
}
close LIST;
