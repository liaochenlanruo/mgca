#!/usr/bin/perl
use strict;
use warnings;
use Cwd;

my $VERSION = "0.0.0";
my $EXE = "mgca";

# ======================== Get bin PATH ==========
my $mgca_dir;
my $bin = `which mgca`;
if ($bin=~/(.+)\/mgca/) {
	$mgca_dir = $1;
}

# Command line options
my(@Options, $help, $PI, $PROPHAGE, $aa_suffix, $AAsPath, $IS, $gbkPath, $gbk_suffix, $phmms, $min_contig_size, $phage_genes, $scafPath, $scaf_suffix, $threads);
setOptions();

# Option setting routines
sub setOptions {
  use Getopt::Long;
  @Options = (
    "\nGENERAL",
    {OPT=>"help",           VAR=>\&usage,                                     DESC=>"This help"},
    {OPT=>"version",        VAR=>\&version,                                   DESC=>"Print version and exit"},
    {OPT=>"citation",       VAR=>\&show_citation,                             DESC=>"Print citation for referencing Prokka"},
    "\nMODULES",
    {OPT=>"PI",             VAR=>\$PI,                                        DESC=>"Calculate statistics of protein properties and print pI of all protein sequences"},
    {OPT=>"IS",             VAR=>\$IS,                                        DESC=>"Predict genomic island from GenBank files"},
    {OPT=>"PROPHAGE",       VAR=>\$PROPHAGE,                                  DESC=>"Predict prophage sequences from GenBank files"},
    "\nParameters of PI",
    {OPT=>"AAsPath=s",      VAR=>\$AAsPath, DEFAULT=>'',                      DESC=>"Amino acids of all strains as fasta file paths"},
    {OPT=>"aa_suffix=s",    VAR=>\$aa_suffix, DEFAULT=>'.faa',                DESC=>"Specify the suffix of Protein sequence files"},
    "\nParameters of IS",
    {OPT=>"gbkPath=s",      VAR=>\$gbkPath, DEFAULT=>'',                      DESC=>"GenBank file path"},
    {OPT=>"gbk_suffix=s",   VAR=>\$gbk_suffix, DEFAULT=>'.gbk',               DESC=>"Specify the suffix of GenBank files"},
    "\nParameters of PROPHAGE",
    {OPT=>"gbkPath=s",      VAR=>\$gbkPath, DEFAULT=>'',                      DESC=>"GenBank file path"},
    {OPT=>"gbk_suffix=s",   VAR=>\$gbk_suffix, DEFAULT=>'.gbk',               DESC=>"Specify the suffix of GenBank files"},
    {OPT=>"phmms=s",        VAR=>\$phmms, DEFAULT=>"$mgca_dir/pVOGs.hmm",     DESC=>"Specify the path of pVOG.hmm"},
    {OPT=>"min_contig_size=i",   VAR=>\$min_contig_size, DEFAULT=>"5000",     DESC=>"Minimum contig size (in bp) to be included in the analysis. Smaller contigs will be dropped"},
    {OPT=>"phage_genes=i",   VAR=>\$phage_genes, DEFAULT=>"1",                DESC=>"The minimum number of genes that must be identified as belonging to a phage for the region to be included"},
    {OPT=>"threads=i",      VAR=>\$threads, DEFAULT=>'6',                     DESC=>"Number of threads to use"},
    "\nParameters of CRISPR",
    {OPT=>"scafPath=s",      VAR=>\$scafPath, DEFAULT=>'',                    DESC=>"Genome/Scaffolds/Contigs file path"},
    {OPT=>"scaf_suffix=s",   VAR=>\$scaf_suffix, DEFAULT=>'.fa',              DESC=>"Specify the suffix of Genome/Scaffolds/Contigs files"},
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
  print "\nVERSION:   $VERSION\n";
  print "\nSYNOPSIS:  microbial genome component and annotation pipeline\n";
  print "\nAUTHOR:    Hualin Liu\n";
  print "\nUSAGE:     $EXE <MODULE> <OPTIONS>\n";

  foreach (@Options) {
    if (!ref $_) { print $_,"\n"; next }  # print text lines
    my $opt = $_->{OPT};
    $opt =~ s/!$//;
    $opt =~ s/=s$/ [X]/;
    $opt =~ s/=i$/ [N]/;
    $opt =~ s/=f$/ [n.n]/;
    printf "  --%-20s %s%s.\n",$opt,$_->{DESC},
           defined($_->{DEFAULT}) ? " [$_->{DEFAULT}]" : "";
  }
  print "\nCOMMANDS\n";
  print "\n# Module PI: Calculate statistics of protein properties and print pI of all protein sequences\n";
  print "  $EXE --PI --AAsPath <PATH> --aa_suffix <.faa>\n";
  print "\n# Module IS: Predict genomic island from GenBank files\n";
  print "  $EXE --IS --gbkPath <PATH> --gbk_suffix <.gbk>\n";
  print "\n# Module PROPHAGE: Predict prophage sequences from GenBank files\n";
  print "  $EXE --PROPHAGE --gbkPath <PATH> --gbk_suffix <.gbk> --phmms <Path of pVOG.hmm> --phage_genes <1> --min_contig_size <5000> --threads <6>\n";
  exit($exitcode);
}


my $working_dir = getcwd;


# ======================== Module PI =============
if ($PI) {
	system("mkdir -p $working_dir/Results/PI/");
	chdir $AAsPath;
	system("print_pI.pl --aa_suffix $aa_suffix");
	system("Rscript $mgca_dir/plot_pI.R");
	system("mv *.pepstats *.pI *.tiff $working_dir/Results/PI");
	chdir $working_dir;
}


# ======================== Module IS =============
if ($IS) {
	system("mkdir -p $working_dir/Results/IS/TEMP/");
	chdir $gbkPath;
	system("run_islandpath.pl --gbk_suffix $gbk_suffix");
	system("rm -rf dimob_tmp*");
	system("mv All_island.list All_island.txt Dimob.log $working_dir/Results/IS/");
	system("mv *.gb *.island *.list $working_dir/Results/IS/TEMP/");
	chdir $working_dir;
}

# ======================== Module prophage =============
if ($PROPHAGE) {
	system("mkdir -p $working_dir/Results/PROPHAGE/");
	chdir $gbkPath;
	system("run_PhiSpy.pl --gbk_suffix $gbk_suffix --phmms $phmms --phage_genes $phage_genes --min_contig_size $min_contig_size --threads $threads");
	system("mv *_prophage All.prophages.* $working_dir/Results/PROPHAGE/");
	chdir $working_dir;
}

# cp mgca.pl /home/liu/miniconda3/envs/mgca/bin/mgca
# cp Scripts/pI/print_pI.pl /home/liu/miniconda3/envs/mgca/bin/
# cp Scripts/pI/plot_pI.R /home/liu/miniconda3/envs/mgca/bin/
# cp Scripts/IS/run_islandpath.pl /home/liu/miniconda3/envs/mgca/bin/
# cp Scripts/PROPHAGE/run_PhiSpy.pl /home/liu/miniconda3/envs/mgca/bin/
# cp Scripts/CRISPR/run_opfi.py /home/liu/miniconda3/envs/mgca/bin/
# cp Scripts/CRISPR/db/cas_all_* /home/liu/miniconda3/envs/mgca/bin/
# cp Scripts/CRISPR/db/cas1_db.* /home/liu/miniconda3/envs/mgca/bin/


# chmod a+x /home/liu/miniconda3/envs/mgca/bin/mgca
# chmod a+x /home/liu/miniconda3/envs/mgca/bin/print_pI.pl
# chmod a+x /home/liu/miniconda3/envs/mgca/bin/plot_pI.R
# chmod a+x /home/liu/miniconda3/envs/mgca/bin/run_islandpath.pl
# chmod a+x /home/liu/miniconda3/envs/mgca/bin/run_PhiSpy.pl
# chmod a+x /home/liu/miniconda3/envs/mgca/bin/run_opfi.py
# chmod a+x /home/liu/miniconda3/envs/mgca/bin/cas_all_*
# chmod a+x /home/liu/miniconda3/envs/mgca/bin/cas1_db.*




# ======================== version =============
sub version {
  print STDERR "$EXE $VERSION\n";
  exit;
}


# ======================== citation =============
sub show_citation {
  print STDERR << "EOCITE";
  
If you use MGCA in your work, please cite:
  Hualin Liu, "MGCA: microbial genome component and annotation pipeline", 
  zazhi, year month day;volume(issue):page.
  PMID:
  doi:
  http://www.ncbi.nlm.nih.gov/pubmed/
    
Thank you.
EOCITE

  exit;
}
