#!/usr/bin/perl
use strict;
use warnings;
use Bio::SeqIO;
# Author: Liu hualin
# Date: Oct 12, 2021

my $EXE = "run_PhiSpy.pl";

# ======================== Get bin PATH ==========
my $mgca_dir;
my $bin = `which mgca`;
if ($bin=~/(.+)\/mgca/) {
	$mgca_dir = $1;
}


my(@Options, $help, $gbk_suffix, $phmms, $min_contig_size, $phage_genes, $threads);
setOptions();

# Option setting routines
sub setOptions {
  use Getopt::Long;
  @Options = (
    "GENERAL",
    {OPT=>"help",       VAR=>\&usage,               DESC=>"This help"},
    {OPT=>"gbk_suffix=s",   VAR=>\$gbk_suffix, DEFAULT=>'.gbk',              DESC=>"Specify the suffix of GenBank files"},
    {OPT=>"phmms=s",   VAR=>\$phmms, DEFAULT=>"$mgca_dir/pVOGs.hmm",              DESC=>"Specify the path of pVOG.hmm"},
    {OPT=>"min_contig_size=i",   VAR=>\$min_contig_size, DEFAULT=>"5000",              DESC=>"Minimum contig size (in bp) to be included in the analysis. Smaller contigs will be dropped"},
    {OPT=>"phage_genes=i",   VAR=>\$phage_genes, DEFAULT=>"1",              DESC=>"The minimum number of genes that must be identified as belonging to a phage for the region to be included"},
    {OPT=>"threads=i",   VAR=>\$threads, DEFAULT=>'6',              DESC=>"Number of threads to use"},
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
  print "SYNOPSIS\n  Predict prophage sequences from GenBank files\n";
  print "AUTHOR\n  Hualin Liu\n";
  print "USAGE\n";
  print "    $EXE --gbk_suffix <suffix of input files> --phage_genes <1> --min_contig_size <5000> --phmms <PATH> --threads <6>\n";

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

my @gbk = glob("*$gbk_suffix");
foreach  (@gbk) {
	$_=~/(.+)$gbk_suffix/;
	my $out = $1 . "_prophage";
	system("PhiSpy.py $_ -o $out --phage_genes $phage_genes --min_contig_size $min_contig_size --output_choice 1 --color --phmms $phmms --threads $threads");
}

open OUT, ">All.prophages.txt" || die;# print prophages informations
print OUT "Strain\tPhage ID\tContig ID\tStart location of the prophage\tStop location of the prophage\tStart of attL\tEnd of attL\tStart of attR\tEnd of attR\tsequence of attL\tSequence of attR\tWhy this att site was chosen for this prophage\n";
# attachment (att) sites
open SEQ, ">All.prophages.seq" || die;# print prophages sequences
print SEQ "Strain\tPhage ID\tContig ID\tGene Start\tGene End\tStrand\tAnnotation\tProtein sequences\n";
my @result = glob("*_prophage");
foreach  (@result) {
	$_=~/(.+)_prophage/;
	my $str = $1;
	my $prophage = $_ . "/prophage_coordinates.tsv";
	if (! -z $prophage) {
		open IN, "$prophage" || die;
		while (<IN>) {
			chomp;
			my @lines = split /\t/;
			my $contig = $lines[1];
			my $gbk = $str . ".gbk";
			my $seqin = Bio::SeqIO->new( -format => 'genbank', -file => "$gbk");#需要在gbk文件所在的目录中运行命令!
			while( (my $seq = $seqin->next_seq) ) {
				foreach my $sf ( $seq->get_SeqFeatures ) {
					if ($seq->display_name eq $contig) {
						if( $sf->primary_tag eq 'CDS' ) {
							#print SEQ $str, "\t", $lines[0], "\t", $seq->display_name, "\t", $sf->start, "\t", $sf->end, "\t", $sf->strand, "\t", $sf->get_tag_values('product'), "\t", $sf->get_tag_values('translation'), $seq->seq,"\n";# Also print contig sequences
							print SEQ $str, "\t", $lines[0], "\t", $seq->display_name, "\t", $sf->start, "\t", $sf->end, "\t", $sf->strand, "\t", $sf->get_tag_values('product'), "\t", $sf->get_tag_values('translation'),"\n";# Only print Protein sequences
						}
					}
				}
			}
			print OUT $str . "\t" . $_ . "\n";
		}
		close IN;
	}
}
close OUT;
close SEQ;
