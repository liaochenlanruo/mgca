![Platform](https://img.shields.io/badge/Platform-WSL%2FLinux%2FmacOS-green) [![License](https://img.shields.io/github/license/liaochenlanruo/mgca)](https://github.com/liaochenlanruo/mgca/blob/master/LICENSE) [![GitHubversion](https://anaconda.org/bioconda/mgca/badges/version.svg)](https://anaconda.org/bioconda/mgca) ![Downloads conda](https://img.shields.io/conda/dn/bioconda/mgca.svg?style=flat) [![install with bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat)](http://bioconda.github.io/recipes/mgca/README.html) [![BIOINFORMATICS](https://pub.idqqimg.com/wpa/images/group.png "945751012")](//shang.qq.com/wpa/qunwpa?idkey=fd4637eecd73bf0a5a8caa274843a07afdf1fbbc40a86630df5d4b029749cc7b)

# MGCA

Microbial genome component and annotation pipeline

-------------

<p><center>
<div style="display:inline-block;width:200px;"><script type="text/javascript" src="//rf.revolvermaps.com/0/0/7.js?i=57lw18tyu78&amp;m=7&amp;c=ff0000&amp;cr1=ffffff&amp;sx=0" async="async"></script></div>
&nbsp;&nbsp;&nbsp;&nbsp;
<script type="text/javascript" src="//rf.revolvermaps.com/0/0/0.js?i=5yz1k9xmfb5&amp;d=3&amp;p=1&amp;b=0&amp;w=293&amp;g=2&amp;f=arial&amp;fs=12&amp;r=0&amp;c0=362b05&amp;c1=375363&amp;c2=000000&amp;ic0=0&amp;ic1=0" async="async"></script>
</center></p>
-------------

# Introduction
----

The software under designing dedicates to perform the following analysis:

- **Genomic Component**
  - HGT
    - Genomic Island
    - Prophage
    - CRISPR-Cas
  - Non-coding RNA
    - rRNA
    - tRNA
    - sRNA
  - Repeat Sequences
    - Tandem Repeats
    - Interspersed Repeats

- **Genomic Attributes**
  - Genome Survey
  - Protein Properties
  - WGS-based Species Identify

- **Function Annotation**
  - General Annotation
    - SwissProt
    - Pfam
    - GO
    - KEGG
  - Target Gene Mining
    - Effectors
      - T3SS
      - T4SS
      - Secretory/Membrane/Intracellular Protein
      - Secondary Metabolite Biosynthetic Gene Clusters
    - Virulence/Pathogenicity/Resistance Gene
      - Antibiotic Resistance Genes (ARGs)
      - Pathogen Host Interactions (PHI)
      - Comprehensive Antibiotic Resistance Database (CARD)
    - Element Cycle
      - CAZyme
      - Nitrogen
      - Sulfur
      - Methane
    - Membrane Transport Protein (TCDB)

- **Comparative Genomics**
  - Collinearity
  - Positive Selection
  - SNP

**NOTICE**: It will take a long time to complete the development!

# Installation
----
The software was tested successfully on Windows WSL, Linux x64 platform, and macOS. Because this software relies on a large number of other software, so it is recommended to install with **[Bioconda](https://bioconda.github.io/index.html)**.

### **Step1: Install MGCA**

- Method 1: use mamba to install MGCA ([![GitHubversion](https://anaconda.org/bioconda/mgca/badges/version.svg)](https://anaconda.org/bioconda/mgca) is now avaliable)
	
	```bash
	# Install mamba first
	conda install mamba
	
	# Usually specify the latest version of PGCGAP
	mamba create -n mgca mgca=0.0.0
	```

### **Step2: Setup database** (Users should execute this after the first installation of mgca)

```bash
conda activate mgca
setupDB --all
conda deactivate
```

**Notice**: there is a little bug, users can edit the "setupDB" file located at the mgca installation path to resolve the problem. Just remove the lines after line no. 83.

# Required dependencies
----
- [emboss](http://emboss.open-bio.org/)
- [islandpath](http://www.pathogenomics.sfu.ca/islandpath/)
- [opfi](https://github.com/wilkelab/Opfi)
- [Perl](http://www.perl.org/get.html) & the modules
  - [perl-bioperl](http://metacpan.org/pod/BioPerl)
- phispy 4.2.21
- [R](https://www.r-project.org/) & the packages
  - [ggplot2](https://cran.r-project.org/web/packages/ggplot2/)
- [wget](https://www.gnu.org/software/wget/)

- In the future:

```tex
    #- gtdbtk
    #- bakta (include trnascan-se infernal piler-cr)
    #- repeatmasker (include trf)
    #- mummer4
    #- artemis (include openjdk)
    #- saspector (include trf progressivemauve prokka)
    #- lastz
    #- kakscalculator2
    #- interproscan (include emboss openjdk)
    #- eggnog-mapper (include wget)
```

# Usage
-----

- **Print the help messages:**
	
	```bash
	mgca --help
	```

- **General usage:**
	
	```bash
	mgca [modules] [options]
	```

- **Modules:**

  - **\[\--PI\]** Calculate statistics of protein properties and print pI of all protein sequences

  - **\[\--IS\]** Predict genomic island from GenBank files

  - **\[\--PROPHAGE\]** Predict prophage sequences from GenBank files

  - **\[\--CRISPR\]** Finding CRISPR-Cas systems in genomics or metagenomics datasets

# Examples
----

## **Example 1:** Calculate statistics of protein properties and print pI of all protein sequences

```bash
mgca --PI --AAsPath <PATH> --aa_suffix <.faa>
```

## **Example 2:** Predict genomic island from GenBank files

```bash
mgca --IS --gbkPath <PATH> --gbk_suffix <.gbk>
```

## **Example 3:** Predict prophage sequences from GenBank files

```bash
mgca --PROPHAGE --gbkPath <PATH> --gbk_suffix <.gbk> --phmms <Path of pVOG.hmm> --phage_genes <1> --min_contig_size <5000> --threads <6>
```

## **Example 4:** Finding CRISPR-Cas systems in genomics or metagenomics datasets

```bash
mgca --CRISPR --scafPath <PATH> --scaf_suffix <.fa> --casDBpath <db path> --threads <6>
```

# OUTPUT

## PI

- **Results/PI/\*.pepstats**: Peptide statistics for each protein sequence organized by the genome.
- **Results/PI/\*.pI**: Protein isoelectric point and its frequency.
- **Results/PI/\*.pI.tiff**: A plot drawing 'Relative frequency' vs. 'isoelectric point'.

## IS

- **Results/IS/All_island.list**: A list file containing genomic island information.
- **Results/IS/All_island.txt**: A file contains information and sequence of genes in the genomic island.

## PROPHAGE

- **Results/PROPHAGE/\*_prophage**: Result for each genome.
- **Results/PROPHAGE/All.prophages.txt**: The summary results (for all genomes) include information of prophage on the host genome.
- **Results/PROPHAGE/All.prophages.seq**: The summary results (for all genomes) include information of prophage genes and sequences.

## CRISPR

- **Results/CRISPR/\*_intially**: Results obtained by permissive BLAST parameters (In most cases, it can be ignored).
- **Results/CRISPR/\*_filtered**: The results obtained after `*_intially` quality control (The final result).
- **Results/CRISPR/\*_filtered/\*.csv**: The file contains information of `CRISPR array`
- **Results/CRISPR/\*_filtered/\*.png**: The visualizations of all predicted `CRISPR array`.

 **Contig**  | **Loc_coordinates** | **Name**     | **Coordinates** | **ORFID**                          | **Strand** | **Accession**                         | **E_val** | **Description**                                                                                                                           | **Sequence**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | **Bitscore** | **Rawscore** | **Aln_len** | **Pident** | **Nident** | **Mismatch** | **Positive** | **Gapopen** | **Gaps** | **Ppos** | **Qcovhsp** | **Contig_filename**                   
:-----------:|:-------------------:|:------------:|:---------------:|:----------------------------------:|:----------:|:-------------------------------------:|:---------:|:-----------------------------------------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:------------:|:------------:|:-----------:|:----------:|:----------:|:------------:|:------------:|:-----------:|:--------:|:--------:|:-----------:|:-------------------------------------:
 NC_013161.1 | 503817..525707      | cas1         | 514110..513817  | lcl|514110|513817|2|-1             | -1         | UniRef50_A0A179D3U4                   | 1.24E-07  | UniRef50_A0A179D3U4 cas1 CRISPR-associated endoribonuclease Cas2 n=2 Tax=Thermosulfurimonas dismutans TaxID=999894 RepID=A0A179D3U4_9BACT | MNTLFYLIIYDLPATKAGNKRRKRLYEMLCGYGNWTQFSVFECFLTAVQFANLQSKLENLIQPNEDSVRIYILDAGSVRKTLTYGSEKPRQVDTLIL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | 42.4         | 98           | 51          | 43.137     | 22         | 29           | 31           | 0           | 0        | 60.78    | 53          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas1         | 515084..514107  | lcl|515084|514107|3|-1             | -1         | UniRef50_A0A1Z3HN48                   | 4.00E-177 | UniRef50_A0A1Z3HN48 cas1 CRISPR-associated endonuclease Cas1 n=83 Tax=Cyanobacteria TaxID=1117 RepID=A0A1Z3HN48_9CYAN                     | MSILYLTQPDAVLSKKQEAFHVALKQEDGSWKKQLIPAQTVEQIVLIGYPSITGEALCYALELGIPVHYLSCFGKYLGSALPGYSRNGQLRLAQYHVHDNEEQRLALVKTVVTGKIHNQYHVLYRYQQKDNPLKEHKQLVKSKTTLEQVRGVEGLAAKDYFNGFKLILDSQWNFNGRNRRPPTDPVNALLSFAYGLLRVQVTAAVHIAGLDPYIGYLHETTRGQPAMVLDLMEEFRPLIADSLVLSVISHKEIKPTDFNESLGAYLLSDSGRKTFLQAFERKLNTEFKHPVFGYQCSYRRSIELQARLFSRYLQENIPYKSLSLR                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | 489          | 1260         | 325         | 69.538     | 226        | 99           | 276          | 0           | 0        | 84.92    | 100         | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas1         | 515707..515117  | lcl|515707|515117|1|-1             | -1         | UniRef50_A0A2I8A541                   | 1.64E-100 | UniRef50_A0A2I8A541 cas1 CRISPR-associated exonuclease Cas4 n=83 Tax=Cyanobacteria TaxID=1117 RepID=A0A2I8A541_9NOSO                      | MIDNYLPLAYLNAFEYCTRRFYWEYVLGEMANNEHIIIGRHLHRNINQEGIIKEEDTIIHRQQWVWSDRLQIKGIIDAVEEKESSLVPVEYKKGRMSQHLNDHFQLCAAALCLEEKTGKIITYGEIFYHANRRRQRVDFSDRLRCSTEQAIHHAHELVNQKMPSPINNSKKCRDCSLKTMCLPKEVKQLRNSLISD                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | 285          | 729          | 195         | 66.154     | 129        | 66           | 162          | 0           | 0        | 83.08    | 99          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas2         | 514110..513817  | lcl|514110|513817|2|-1             | -1         | UniRef50_A0A1Z3HN55                   | 7.36E-46  | UniRef50_A0A1Z3HN55 cas2 CRISPR-associated endoribonuclease Cas2 n=68 Tax=Cyanobacteria TaxID=1117 RepID=A0A1Z3HN55_9CYAN                 | MNTLFYLIIYDLPATKAGNKRRKRLYEMLCGYGNWTQFSVFECFLTAVQFANLQSKLENLIQPNEDSVRIYILDAGSVRKTLTYGSEKPRQVDTLIL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | 142          | 357          | 94          | 67.021     | 63         | 31           | 77           | 0           | 0        | 81.91    | 97          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas4         | 515084..514107  | lcl|515084|514107|3|-1             | -1         | UniRef50_A0A1E5G3J0                   | 1.01E-72  | UniRef50_A0A1E5G3J0 cas4 CRISPR-associated endonuclease Cas1 n=4 Tax=Firmicutes TaxID=1239 RepID=A0A1E5G3J0_9BACL                         | MSILYLTQPDAVLSKKQEAFHVALKQEDGSWKKQLIPAQTVEQIVLIGYPSITGEALCYALELGIPVHYLSCFGKYLGSALPGYSRNGQLRLAQYHVHDNEEQRLALVKTVVTGKIHNQYHVLYRYQQKDNPLKEHKQLVKSKTTLEQVRGVEGLAAKDYFNGFKLILDSQWNFNGRNRRPPTDPVNALLSFAYGLLRVQVTAAVHIAGLDPYIGYLHETTRGQPAMVLDLMEEFRPLIADSLVLSVISHKEIKPTDFNESLGAYLLSDSGRKTFLQAFERKLNTEFKHPVFGYQCSYRRSIELQARLFSRYLQENIPYKSLSLR                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | 233          | 595          | 333         | 39.94      | 133        | 179          | 191          | 6           | 21       | 57.36    | 98          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas4         | 515707..515117  | lcl|515707|515117|1|-1             | -1         | UniRef50_A0A2I8A541                   | 1.92E-99  | UniRef50_A0A2I8A541 cas4 CRISPR-associated exonuclease Cas4 n=83 Tax=Cyanobacteria TaxID=1117 RepID=A0A2I8A541_9NOSO                      | MIDNYLPLAYLNAFEYCTRRFYWEYVLGEMANNEHIIIGRHLHRNINQEGIIKEEDTIIHRQQWVWSDRLQIKGIIDAVEEKESSLVPVEYKKGRMSQHLNDHFQLCAAALCLEEKTGKIITYGEIFYHANRRRQRVDFSDRLRCSTEQAIHHAHELVNQKMPSPINNSKKCRDCSLKTMCLPKEVKQLRNSLISD                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | 285          | 729          | 195         | 66.154     | 129        | 66           | 162          | 0           | 0        | 83.08    | 99          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas6         | 516642..515833  | lcl|516642|515833|2|-1             | -1         | UniRef50_A0A654SHL3                   | 2.64E-108 | UniRef50_A0A654SHL3 cas6 CRISPR_Cas6 domain-containing protein n=30 Tax=Cyanobacteria TaxID=1117 RepID=A0A654SHL3_9CYAN                   | MVQDILPQLHKYQLQSLVIELGVAKQGKLPATLSRAIHACVLNWLSLADSQLANQIHDSQISPLCLSGLIGNRRQPYSLLGDYFLLRIGVLQPSLIKPLLKGIEAQETQTLELGKFPFIIRQVYSMPQSHKLSQLTDYYSLALYSPTMTEIQLKFLSPTSFKQIQGVQPFPLPELVFNSLLRKWNHFAPQELKFPEIQWQSFVSAFELKTHALKMEGGAQIGSQGWAKYCFKDTEQARIASILSHFAFYAGVGRKTTMGMGQTQLLVNT                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | 314          | 804          | 270         | 55.926     | 151        | 118          | 195          | 1           | 1        | 72.22    | 100         | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas5         | 517387..516611  | lcl|517387|516611|1|-1             | -1         | UniRef50_A0A2I8AFZ3                   | 1.43E-118 | UniRef50_A0A2I8AFZ3 cas5 Type I-D CRISPR-associated protein Cas5/Csc1 n=62 Tax=Cyanobacteria TaxID=1117 RepID=A0A2I8AFZ3_9NOSO            | MNIYYCQLTLHDNIFFATREMGLLYETEKYLHNWALSYAFFKGTYIPHPYRLQGKSAQKPDYLDSTGEQSLAHLNRLKIYVFPAKPLRWSYQINTFKAAQTTYYGKSQQFGDKGANRNYPINYGRAKELAVGSEYHTFLISSQELNIPHWIRVGKWSAKVEVTSYLIPQKAISQHSGIYLCDHPLNPIDLPFDQELLLYNRIVMPPVSLVSQAQLQGNYCKINKNNWNDCPSNLTDLPQQICLPLGVNYGAGYIASAS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | 338          | 866          | 252         | 65.079     | 164        | 71           | 194          | 3           | 17       | 76.98    | 98          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas7         | 518600..517530  | lcl|518600|517530|3|-1             | -1         | UniRef50_B7JVM8                       | 0.00E+00  | UniRef50_B7JVM8 cas7 CRISPR-associated protein Csc2 n=52 Tax=Cyanobacteria TaxID=1117 RepID=B7JVM8_RIPO1                                  | MSILETLKPQFQSAFPRLASANYVHFIMLRHSQSFPVFQTDGVLNTVRTQAGLMAKDSLSRLVMFKRKQTTPERLTGRELLRSLNITTADKNDKEKGCEYNGEGSCKKCPDCIIYGFAIGDSGSERSKVYSDSTFSLSAYEQSHRTFTFNAPFEGGTMSEQGVMRSAINELDHILPEITFPNIETLRDSTYEGFIYVLGNILRTKRYGAQESRTGTMKNHLVGIAFCDGEIFSNLRFTQALYDGLEGDVNKPIDEICYQASQIVQTLLSDEPVRKIKTIFGEELNHLINEVSGIYQNDALLTETLNMLYQQTKTYSENHGSLAKSKPPKAEGNKSKGRTKKKGDDEQTSLDLNIEE                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | 733          | 1891         | 356         | 98.876     | 352        | 4            | 354          | 0           | 0        | 99.44    | 100         | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas10        | 521597..518673  | lcl|521597|518673|3|-1             | -1         | UniRef50_B7KB38                       | 0.00E+00  | UniRef50_B7KB38 cas10 CRISPR-associated protein Csc3 n=52 Tax=Cyanobacteria TaxID=1117 RepID=B7KB38_GLOC7                                 | MTLLQILLLETISQDTDPILISYLETVLPAMEPEFALIPALGGSQQIHYQNLIAIGNRYAQENAKRFSDKADQNLLVHVLNALLTAWNLVDHLTKPLSDIEKYLLCLGLTLHDYNKYCLGHGEESPKVSNINEIINICQELGKKLNFQAFWSDWEQYLPEIVYLAQNTQFKAGTNAIPANYPLFTLADSRRLDLPLRRLLAFGDIAVHLQDPADIISKTGGDRLREHLRFLGIKKALVYHRLRDTLGILSNGIHNATLRFAKDLNWQPLLFFAQGVIYLAPIDYTSPEKMELQGFIWQEISQLLASSMLKGEIGFKRDGKGLKVAPQTLELFTPVQLIRNLADVINVKVANAKVPATPKRLEKLELTDIERQLLEKGADLRADRIAELIILAQREFLADSPEFIDWTLQFWGLEKQITAEQTQEQSGGVNYGWYRVAANYIANHSTLSLEDVSGKLVDFCQQLADWATSNQLLSSHSSSTFEVFNSYLEQYLEIQGWQSSTPNFSQELSTYIMAKTQSSKQPICSLSSGEFISEDQMDSVVLFKPQQYSNKNPLGGGKIKRGISKIWALEMLLRQALWTVPSGKFEDQQPVFLYIFPAYVYSPQIAAAIRSLVNDMKRINLWDVRKHWLHEDMNLDSLRSLQWRKEEAEVGRFKDKYSRADIPFMGTVYTTTRGKTLTEAWIDPAFLTLALPILLGVKVIATSSSVPLYNSDNDFLDSVILDAPAGFWQLLKLSTSLRIQELSVALKRLLTIYTIHLDNRSNPPDARWQALNSTVREVITDVLNVFSIADEKLREDQREASPQEVQRYWKFAEIFAQGDTIMTEKLKLTKELVRQYRTFYQVKWSESSHTILLPLTKALEEILSTPEHWDDEELILQGAGILNDALDRQEVYKRPLLQDKSIPYEIRKQQELQAIHQFMTTCVKELFGQMCKGDRALLQEYRNRIKSGAESAYKLLAFEEKSNSSQQQKSSEDQ | 1073         | 2775         | 978         | 56.544     | 553        | 399          | 710          | 12          | 26       | 72.6     | 99          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas3         | 523760..521655  | lcl|523760|521655|3|-1             | -1         | UniRef50_A0A168SWH5                   | 0.00E+00  | UniRef50_A0A168SWH5 cas3 Type I-D CRISPR-associated helicase Cas3 n=2 Tax=Phormidium TaxID=1198 RepID=A0A168SWH5_9CYAN                    | MKINLKPLYSKLNAGVGNCPLGCQEMCRVQQQAPQFKAPSGCNCPLYQHQAESYPYLTKGDTDIIFITAPTAGGKSLLASLPSLLDPNFRMMGLYPTIELVEDQTEQQNNYHNLFGLNSEERIDKLFGVELTQRIKEFNSNRFQQLWLAIETKEVILTNPDIFHLMTHFRYRDNAYGTDELPLALAKFPDLWVFDEFHIFGAHQETAVLNSMMLIRRTQQQKKRFLFTSATVKTDFVEQLKQTGLKIKEIAGEYKSEAQQGYRQILQAVELSIINLKEEDGFSWLINNAAKIRKILKAEDKGRGLIILNSVVMVRRISQELQSLLPEIVVREISGRIDRKERSQTQQLLQEEEKPVLVVATSAVDVGVDFRIHLLITESSDSATVIQRLGRLGRHSGFSNYQAFLLLSGRTPWVINRLQEKLESKQDVTREELIEAIQYAFDPPKEYQEYRNRWGAIQVQGMFSQMMGSNAKVMQSIKERISEDLKRIYGNTLDNKAWYAMGHNCLGKAIQSELLRFRGGSTLQAAVWDEQRFYTYDLLRLLPYATVDILDRETFLKAATKAGHIEEAFPSQYLQVYLRIEQWLDKRLNLNLFCNRESDELLVGKLFLITRLKLDGHPQSDVISCLSRCNLLTFLVPVDRSRTQSHWEVSYCLHLNPLFGLYRLKDASEQAYACAFNQDALLLEALNWKLTKFYRERSLIF                                                                                                                                                                                                                                                                                  | 671          | 1731         | 720         | 49.028     | 353        | 341          | 479          | 10          | 26       | 66.53    | 100         | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | CRISPR array | 512560..513624  | Copies: 15, Repeat: 37, Spacer: 36 | #NAME?     | GCF_000024045.1_ASM2404v1_genomic.fna |           |                                                                                                                                           |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |              |              |             |            |            |              |              |             |          |          |             |                                       


# License
-------

MGCA is free software, licensed under GPLv3.

# Feedback and Issues
-------------------

Please report any issues to the [issues page](https://github.com/liaochenlanruo/mgca/issues?_blank) or email us at <liaochenlanruo@webmail.hzau.edu.cn>.

# Citation
--------

If you use this software please cite: Hualin Liu. MGCA: microbial genome component and annotation pipeline. Avaliable at GitHub [https://github.com/liaochenlanruo/mgca](https://github.com/liaochenlanruo/mgca)

# Updates
-------

## V0.0.0

  - The MGCA was born.

------------------------------------------------------------------------

<p><center><strong>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

<script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
<span id="busuanzi_container_site_pv"><i class="fa fa-spinner fa-spin"></i>Total visits: <span id="busuanzi_value_site_pv"></span> times</span>

<span class="post-meta-divider">|</span>
<span id="busuanzi_container_site_uv"><i class="fa fa-spinner fa-spin"></i>Visitors: <span id="busuanzi_value_site_uv"></span> people</span>

<span class="post-meta-divider">|</span>
<span id="busuanzi_container_page_pv"><i class="fa fa-spinner fa-spin"></i>
This page: <span id="busuanzi_value_page_pv"></span> times
</span>
</strong></center></p>
