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

- artemis
- [bakta](https://github.com/oschwengers/bakta)
- [eggnog-mapper](https://github.com/eggnogdb/eggnog-mapper)
- [emboss](http://emboss.open-bio.org/)
- gtdbtk
- interproscan (include emboss openjdk)
- [islandpath](http://www.pathogenomics.sfu.ca/islandpath/)
- kakscalculator2
- [lastz](http://www.bx.psu.edu/~rsharris/lastz/)
- [mummer4](https://mummer4.github.io/)
- [opfi](https://github.com/wilkelab/Opfi)
- [Perl](http://www.perl.org/get.html) & the modules
  - [perl-bioperl](http://metacpan.org/pod/BioPerl)
- [phispy](https://github.com/linsalrob/PhiSpy)
- [R](https://www.r-project.org/) & the packages
  - [ggplot2](https://cran.r-project.org/web/packages/ggplot2/)
- [repeatmasker](http://www.repeatmasker.org)
- saspector (include trf progressivemauve prokka)

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

  ![CRISPR array](https://cdn.jsdelivr.net/gh/liaochenlanruo/cdn@master/images/post/85d7_2.jpg)

## IS

- **Results/IS/All_island.list**: A list file containing genomic island information.

 **Island IDs** | **GI Start** | **GI End** | **GI Length** | **Gene Number** | **Gene IDs** 
---|---|---|---|---|---
 ID=LHL010_Scaffold2_gi1 | 404015 | 531251 | 127237 | 288 | LHL010_01513 LHL010_01514 LHL010_01515 LHL010_01516 LHL010_01517 LHL010_01518 LHL010_01519 LHL010_01520 LHL010_01521 LHL010_01522 LHL010_01523 LHL010_01524 LHL010_01525 LHL010_01526 LHL010_01527 LHL010_01528 LHL010_01529 LHL010_01530 LHL010_01531 LHL010_01532 LHL010_01533 LHL010_01534 LHL010_01535 LHL010_01536 LHL010_01537 LHL010_01538 LHL010_01539 LHL010_01540 LHL010_01541 LHL010_01542 LHL010_01543 LHL010_01544 LHL010_01545 LHL010_01546 LHL010_01547 LHL010_01548 LHL010_01549 LHL010_01550 LHL010_01551 LHL010_01552 LHL010_01553 LHL010_01554 LHL010_01555 LHL010_01556 LHL010_01557 LHL010_01558 LHL010_01559 LHL010_01560 LHL010_01561 LHL010_01562 LHL010_01563 LHL010_01564 LHL010_01565 LHL010_01566 LHL010_01567 LHL010_01568 LHL010_01569 LHL010_01570 LHL010_01571 LHL010_01572 LHL010_01573 LHL010_01574 LHL010_01575 LHL010_01576 LHL010_01577 LHL010_01578 LHL010_01579 LHL010_01580 LHL010_01581 LHL010_01582 LHL010_01583 LHL010_01584 LHL010_01585 LHL010_01586 LHL010_01587 LHL010_01588 LHL010_01589 LHL010_01590 LHL010_01591 LHL010_01592 LHL010_01593 LHL010_01594 LHL010_01595 LHL010_01596 LHL010_01597 LHL010_01598 LHL010_01599 LHL010_01600 LHL010_01601 LHL010_01602 LHL010_01603 LHL010_01604 LHL010_01605 LHL010_01606 LHL010_01607 LHL010_01608 LHL010_01609 LHL010_01610 LHL010_01611 LHL010_01612 LHL010_01613 LHL010_01614 LHL010_01615 LHL010_01616 LHL010_01617 LHL010_01618 LHL010_01619 LHL010_01620 LHL010_01621 LHL010_01622 LHL010_01623 LHL010_01624 LHL010_01625 LHL010_01626 LHL010_01627 LHL010_01628 LHL010_01629 LHL010_01630 LHL010_01631 LHL010_01632 LHL010_01633 LHL010_01634 LHL010_01635 LHL010_01636 LHL010_01637 LHL010_01638 LHL010_01639 LHL010_01640 LHL010_01641 LHL010_01642 LHL010_01643 LHL010_01644 LHL010_01645 LHL010_01646 LHL010_01647 LHL010_01648 LHL010_01649 LHL010_01650 LHL010_01651 LHL010_01652 LHL010_01653 LHL010_01654 LHL010_01655 LHL010_01656 LHL010_01657 LHL010_01658 LHL010_01659 LHL010_01660 LHL010_01661 LHL010_01662 LHL010_01663 LHL010_01664 LHL010_02694 LHL010_02695 LHL010_02696 LHL010_02697 LHL010_02698 LHL010_02699 LHL010_02700 LHL010_02701 LHL010_02702 LHL010_02703 LHL010_02704 LHL010_02705 LHL010_02706 LHL010_02707 LHL010_02708 LHL010_02709 LHL010_02710 LHL010_02711 LHL010_02712 LHL010_02713 LHL010_02714 LHL010_02715 LHL010_02716 LHL010_02717 LHL010_02718 LHL010_02719 LHL010_02720 LHL010_02721 LHL010_02722 LHL010_02723 LHL010_02724 LHL010_02725 LHL010_02726 LHL010_02727 LHL010_02728 LHL010_02729 LHL010_02730 LHL010_02731 LHL010_02732 LHL010_02733 LHL010_02734 LHL010_02735 LHL010_02736 LHL010_02737 LHL010_02738 LHL010_02739 LHL010_02740 LHL010_02741 LHL010_02742 LHL010_02743 LHL010_02744 LHL010_02745 LHL010_02746 LHL010_02747 LHL010_02748 LHL010_02749 LHL010_02750 LHL010_02751 LHL010_02752 LHL010_02753 LHL010_02754 LHL010_02755 LHL010_02756 LHL010_02757 LHL010_02758 LHL010_02759 LHL010_02760 LHL010_02761 LHL010_02762 LHL010_02763 LHL010_02764 LHL010_02765 LHL010_02766 LHL010_02767 LHL010_02768 LHL010_02769 LHL010_02770 LHL010_02771 LHL010_02772 LHL010_02773 LHL010_02774 LHL010_02775 LHL010_02776 LHL010_02777 LHL010_02778 LHL010_02779 LHL010_02780 LHL010_02781 LHL010_02782 LHL010_02783 LHL010_02784 LHL010_02785 LHL010_02786 LHL010_02787 LHL010_02788 LHL010_02789 LHL010_02790 LHL010_02791 LHL010_02792 LHL010_02793 LHL010_02794 LHL010_02795 LHL010_02796 LHL010_02797 LHL010_02798 LHL010_02799 LHL010_02800 LHL010_02801 LHL010_02802 LHL010_02803 LHL010_02804 LHL010_02805 LHL010_02806 LHL010_02807 LHL010_02808 LHL010_02809 LHL010_02810 LHL010_02811 LHL010_02812 LHL010_02813 LHL010_02814 LHL010_02815 LHL010_02816 LHL010_02817 LHL010_02818 LHL010_02819 LHL010_02820 LHL010_02821 LHL010_02822 LHL010_02823 LHL010_02824 LHL010_02825 LHL010_02826 LHL010_02827 LHL010_02828 LHL010_02829 
 ID=LHL010_Scaffold2_gi2 | 965322 | 993880 | 28559 | 65 | LHL010_02163 LHL010_02164 LHL010_02165 LHL010_02166 LHL010_02167 LHL010_02168 LHL010_02169 LHL010_02170 LHL010_02171 LHL010_02172 LHL010_02173 LHL010_02174 LHL010_02175 LHL010_02176 LHL010_02177 LHL010_02178 LHL010_02179 LHL010_02180 LHL010_02181 LHL010_02182 LHL010_02183 LHL010_02184 LHL010_02185 LHL010_02186 LHL010_02187 LHL010_02188 LHL010_02189 LHL010_02190 LHL010_02191 LHL010_02192 LHL010_02193 LHL010_02194 LHL010_02195 LHL010_02196 LHL010_03213 LHL010_03214 LHL010_03215 LHL010_03216 LHL010_03217 LHL010_03218 LHL010_03219 LHL010_03220 LHL010_03221 LHL010_03222 LHL010_03223 LHL010_03224 LHL010_03225 LHL010_03226 LHL010_03227 LHL010_03228 LHL010_03229 LHL010_03230 LHL010_03231 LHL010_03232 LHL010_03233 LHL010_03234 LHL010_03235 LHL010_03236 LHL010_03237 LHL010_03238 LHL010_03239 LHL010_03240 LHL010_03241 LHL010_03242 LHL010_03243 
 ID=LHL010_Scaffold3_gi1 | 371817 | 389128 | 17312 | 22 | LHL010_02659 LHL010_02660 LHL010_02661 LHL010_02662 LHL010_02663 LHL010_02664 LHL010_02665 LHL010_02666 LHL010_02667 LHL010_02668 LHL010_02669 LHL010_02670 LHL010_02671 LHL010_02672 LHL010_02673 LHL010_02674 LHL010_02675 LHL010_02676 LHL010_02677 LHL010_02678 LHL010_02679 LHL010_02680 


- **Results/IS/All_island.txt**: A file contains information and sequence of genes in the genomic island.

| Sequence IDs | Predictor | Category | GI Start | GI End | . | Strand | . | Island IDs | Gene IDs | Gene Start | Gene End | Strand | Products | Protein Sequences |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| LHL010_Scaffold2 | islandpath | genomic_island | 404015 | 531251 | . | - | . | ID=LHL010_Scaffold2_gi1 | LHL010_01513 | 404015 | 404314 | -1 | hypothetical protein | MNPIIEYLTGMNVLTDQIIAMDLLISAKNGVRNYAMAATEAGTPEVKEVLIRHLEEALDMHEQLSSYMMEKGWYHPWNTDEQVKLHLKNIDTAIQLPTL |
| LHL010_Scaffold2 | islandpath | genomic_island | 404015 | 531251 | . | - | . | ID=LHL010_Scaffold2_gi1 | LHL010_01514 | 404311 | 404526 | -1 | hypothetical protein | MEYALHELLEVQEMTAFKTLCLTKSKTMKALVSDPKLKEIMQQDVDITTRQLQEFASILSNAKQVEEMSEK |
| LHL010_Scaffold2 | islandpath | genomic_island | 404015 | 531251 | . | - | . | ID=LHL010_Scaffold2_gi1 | LHL010_01515 | 404545 | 405681 | -1 | putative zinc-binding alcohol dehydrogenase | MKAVTYQGIKNVVVKDVPDPKIEKSDDMIIKVTSTAICGSDLHLIHGFIPNLQEDYVIGHEPMGIVEEVGPGVTKVKKGDRVIIPFTIACGECFFCKNQLESQCDQSNENGEMGAYFGYSGQTGGYPGGQAEYLRVPFANFTHFKIPESCEEPDEKLSVIADAMTTGFWSVDNAGVKEGDTVIVLGCGPVGLFAQKFCWLKGAKRVIAVDYVNYRLQHAKRTNKVEIVNFEDHENTGNYLKEITKGGADVVIDAVGMDGKMSDLEFLASGLKLHGGTMSALVIASQAVRKGGTIQITGVYGGRYNGFPLGDIMQRNINIRSGQAPVIHYMPYMFELVSTGKIDPGDVVSHVLPLSEAKHGYDIFDAKMDDCIKVVLKP |


## PROPHAGE

- **Results/PROPHAGE/\*_prophage**: Result for each genome.
- **Results/PROPHAGE/All.prophages.txt**: The summary results (for all genomes) include information of prophage on the host genome.

| **Strain** | **Phage ID** | **Contig ID** | **Start location of the prophage** | **Stop location of the prophage** | **Start of attL** | **End of attL** | **Start of attR** | **End of attR** | **sequence of attL** | **Sequence of attR** | **Why this att site was chosen for this prophage** |
|---|---|---|---|---|---|---|---|---|---|---|---|
| F06_bin.1 | pp1 | NODE_1250 | 268 | 6260 | 552 | 565 | 3084 | 3097 | CTTCTTCGGCTGG | CCAGCCGAAGAAG | Longest Repeat flanking phage and within 2000 bp |
| LHL010 | pp1 | Scaffold2 | 478039 | 506323 | 476381 | 476394 | 507152 | 507165 | AAAAACAACATCC | GGATGTTGTTTTT | Longest Repeat flanking phage and within 2000 bp |
| LHL010 | pp2 | Scaffold3 | 364543 | 381309 | 364452 | 364464 | 378016 | 378028 | ACGGAAAGCCTG | CAGGCTTTCCGT | Longest Repeat flanking phage and within 2000 bp |

- **Results/PROPHAGE/All.prophages.seq**: The summary results (for all genomes) include information of prophage genes and sequences.

| **Strain** | **Phage ID** | **Contig ID** | **Gene Start** | **Gene End** | **Strand** | **Annotation** | **Protein sequences** |
|---|---|---|---|---|---|---|---|
| F06_bin.1 | pp1 | NODE_1250 | 268 | 1167 | 1 | Tyrosine recombinase XerC | MSVEQLPLFSLIRESPLSAAISGFHEHMIRKGFTENTIKAFLNDLRILTRYLGDDRALSQIGTSELKDFMTYLRHYRGVPCNPKSYARRMTTLKVFFGWLAEEGIIPSDPAAPLIHQRASTPLPQILYAGQVEKLLQATEGLMHAEKPDARPHLLVTFLLQTGIKKGECMALQLNDIDTSEPKAPVLYIRYSNPKMKHKERKLRLSVDFVPILRQYLAEYQPQERLFECTARNLEYVLDNAARLAGLETISFEILRWTCAVRDYKAKMPSDKLRQKLGLSRITWQEASEKLKKLASPPL |
| F06_bin.1 | pp1 | NODE_1250 | 1297 | 1923 | -1 | hypothetical protein | MGIRDLFKPREDKFMRLLVEQAAKTVEGMKLLEEFMEVTDREVAKRLVQVEKEADEVRRILIDELNRSFITPIDREDIFALSLTIDDILDYGYSTVDEMVILEVESNSYLRRMVSLVREAANEIYMGVLRLQDHPNVANDHAVRAKALENRVETVYREALAELFHGPTDIDHIMEMLKLREIYRHLSNAADRGDQAANVIGDIVVKMT |
| F06_bin.1 | pp1 | NODE_1250 | 1947 | 2936 | -1 | hypothetical protein | MNLPSVGIAIIGVALFSDFINGFHGSSNVVATMISSRAMSARNALALSAVAHFCGPFLFGVAVATTIGHEVVDPKAITIVVIFAALLAAIIWNIITWAFGIPSSSFHALVGGLIGAVSVDFGFAMIQMRGLLKVIIALFISPILGLVAGYLLMRLVLFLARGASPRINWFFKRAQIITSLALALGHGTNDAQKTMGIIAMALVTIGYSSEFSVPWWVVALCAGAMSLGTAFGGWRIIRTLGGKFYKIRPVHGFTAQVASAFVILGAALLGGPVSTTQVVSSAILGVGSAKRVSRVRWNVVGNIVAAWVLTIPASALLAALLHLLMRSLL |
| F06_bin.1 | pp1 | NODE_1250 | 2933 | 3109 | -1 | hypothetical protein | MWEEASSAGLRLLTGDALCVKVGTTWGQSQVIEAYANLREDERFTPGVENRSTSEGES |
| F06_bin.1 | pp1 | NODE_1250 | 3122 | 4144 | -1 | hypothetical protein | MSTEVIVAIGGGSNIDAAKAAGVLAILGGPISNYFGTGRVTAFLARGFGLEGLSPKARKSLTPLVAVQTASSSGAHLTKYSNVTDLKTGQKKLIVDEAIIPPRAVFQYDVTTSMPPGFTADGALDGIAHLVEVLLGAVGKGFYQRVEEVARVGIRLIVNHLEQAVAEPTNLEAREAVGLGTDLGGYAIMIGGTSGGHLTSFSLVDILSHGRACAIMNPYYIVFFAPAIEEPLKLIGKIYQEAGLTEASIEALSGRGLGTAVAEAMIALSERIGLPTTLGEVQGFTDGHIERALRAAKDPQLKMKLQNMPIPLTAEMVDEYMRPLLEAARDGDLTLIKNVV |
| F06_bin.1 | pp1 | NODE_1250 | 4141 | 4428 | -1 | hypothetical protein | MEFNVFERARDLLREFKGDSYAFGAGALARTGELASQLGQRAAIIVPSHPGSEGISSQVERSLESAGVVVVGEIQGARPNAPREDVSGWQASFKS |
| F06_bin.1 | pp1 | NODE_1250 | 4436 | 4807 | -1 | hypothetical protein | MPRIKITAGDVVAFAELNETATAEAIWNALPIEARVNTWGDEIYFSIPVYLEEENAQAIVEKGDLGYWPSGNAFCIFFGRTPASRGDEIRPASPVNVFGHLEGDPTIFKSVRSGEKVMLERVE |
| F06_bin.1 | pp1 | NODE_1250 | 4800 | 5174 | -1 | 5-keto-L-gluconate epimerase | MRLALEPINRYETTLINNVAQGLELVERAAADNMGLLLDTFHMNIEEPSIEESIRAAGERLFHFHVADSNRWYPGAGHLDFARILAVLREIGYEGYLSAEILSLPDADTCARRTIEFLKGVFDA |
| F06_bin.1 | pp1 | NODE_1250 | 5205 | 5636 | -1 | 5-keto-L-gluconate epimerase | MKLSIVLSTQPAQFEAIAFKGGFERNVARIAELGYDGVELAIRDPNLVDANGMLRVVSAHGLEVPAIGTGQAWGEEGLSFTDPDRAIRAAAIERTKSHIPFATRTGAACGEHGRTVIIIGLLRGIVKPGVDHAQAMDWLVDAL |
| F06_bin.1 | pp1 | NODE_1250 | 5709 | 6260 | -1 | hypothetical protein | MVLETGKGQGVDQALAEATGGCLQLKVSGIYQEILWRVLAESPDPAERALFEKAWAHTYRIAETLSRVYVALIAGRDQAEAQALLADESRVGKVAGREAIALVKQTLGYGLHQAALAHDLLGVADSSHRHPADDFFRHLSYLAFRPLRAELYRTITPDGWQHYADAVTRYTRMRIAGLGMTED |

## CRISPR

- **Results/CRISPR/\*_intially**: Results obtained by permissive BLAST parameters (In most cases, it can be ignored).
- **Results/CRISPR/\*_filtered**: The results obtained after `*_intially` quality control (The final result).
- **Results/CRISPR/\*_filtered/\*.csv**: The file contains information of `CRISPR array`, as shown below:

 **Contig**  | **Loc_coordinates** | **Name** | **Coordinates** | **ORFID**                          | **Strand** | **Accession** | **E_val** | **Description** | **Sequence** | **Bitscore** | **Rawscore** | **Aln_len** | **Pident** | **Nident** | **Mismatch** | **Positive** | **Gapopen** | **Gaps** | **Ppos** | **Qcovhsp** | **Contig_filename**                   
:-----------:|:-------------------:|:------------:|:---------------:|:----------------------------------:|:----------:|:----:|:---------:|:-----:|:------:|:------:|:-----------:|:----------:|:----------:|:------------:|:------------:|:-----------:|:--------:|:--------:|:-----------:|:-------------------------------------:
 NC_013161.1 | 503817..525707      | cas1         | 514110..513817  | lcl|514110|513817|2|-1             | -1         | UniRef50_A0A179D3U4                   | 1.24E-07  | UniRef50_A0A179D3U4 cas1 CRISPR-associated endoribonuclease Cas2 n=2 Tax=Thermosulfurimonas dismutans TaxID=999894 RepID=A0A179D3U4_9BACT | MNTLFYLIIYDLPATKAGNKRRKRLYEMLCGYGNWTQFSVFECFLTAVQFANLQSKLENLIQPNEDSVRIYILDAGSVRKTLTYGSEKPRQVDTLIL | 42.4         | 98           | 51          | 43.137     | 22         | 29           | 31           | 0           | 0        | 60.78    | 53          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas1         | 515084..514107  | lcl|515084|514107|3|-1             | -1         | UniRef50_A0A1Z3HN48                   | 4.00E-177 | UniRef50_A0A1Z3HN48 cas1 CRISPR-associated endonuclease Cas1 n=83 Tax=Cyanobacteria TaxID=1117 RepID=A0A1Z3HN48_9CYAN                     | MSILYLTQPDAVLSKKQEAFHVALKQEDGSWKKQLIPAQTVEQIVLIGYPSITGEALCYALELGIPVHYLSCFGKYLGSALPGYSRNGQLRLAQYHVHDNEEQRLALVKTVVTGKIHNQYHVLYRYQQKDNPLKEHKQLVKSKTTLEQVRGVEGLAAKDYFNGFKLILDSQWNFNGRNRRPPTDPVNALLSFAYGLLRVQVTAAVHIAGLDPYIGYLHETTRGQPAMVLDLMEEFRPLIADSLVLSVISHKEIKPTDFNESLGAYLLSDSGRKTFLQAFERKLNTEFKHPVFGYQCSYRRSIELQARLFSRYLQENIPYKSLSLR | 489          | 1260         | 325         | 69.538     | 226        | 99           | 276          | 0           | 0        | 84.92    | 100         | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas1         | 515707..515117  | lcl|515707|515117|1|-1             | -1         | UniRef50_A0A2I8A541                   | 1.64E-100 | UniRef50_A0A2I8A541 cas1 CRISPR-associated exonuclease Cas4 n=83 Tax=Cyanobacteria TaxID=1117 RepID=A0A2I8A541_9NOSO                      | MIDNYLPLAYLNAFEYCTRRFYWEYVLGEMANNEHIIIGRHLHRNINQEGIIKEEDTIIHRQQWVWSDRLQIKGIIDAVEEKESSLVPVEYKKGRMSQHLNDHFQLCAAALCLEEKTGKIITYGEIFYHANRRRQRVDFSDRLRCSTEQAIHHAHELVNQKMPSPINNSKKCRDCSLKTMCLPKEVKQLRNSLISD | 285          | 729          | 195         | 66.154     | 129        | 66           | 162          | 0           | 0        | 83.08    | 99          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas2         | 514110..513817  | lcl|514110|513817|2|-1             | -1         | UniRef50_A0A1Z3HN55                   | 7.36E-46  | UniRef50_A0A1Z3HN55 cas2 CRISPR-associated endoribonuclease Cas2 n=68 Tax=Cyanobacteria TaxID=1117 RepID=A0A1Z3HN55_9CYAN                 | MNTLFYLIIYDLPATKAGNKRRKRLYEMLCGYGNWTQFSVFECFLTAVQFANLQSKLENLIQPNEDSVRIYILDAGSVRKTLTYGSEKPRQVDTLIL | 142          | 357          | 94          | 67.021     | 63         | 31           | 77           | 0           | 0        | 81.91    | 97          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas4         | 515084..514107  | lcl|515084|514107|3|-1             | -1         | UniRef50_A0A1E5G3J0                   | 1.01E-72  | UniRef50_A0A1E5G3J0 cas4 CRISPR-associated endonuclease Cas1 n=4 Tax=Firmicutes TaxID=1239 RepID=A0A1E5G3J0_9BACL                         | MSILYLTQPDAVLSKKQEAFHVALKQEDGSWKKQLIPAQTVEQIVLIGYPSITGEALCYALELGIPVHYLSCFGKYLGSALPGYSRNGQLRLAQYHVHDNEEQRLALVKTVVTGKIHNQYHVLYRYQQKDNPLKEHKQLVKSKTTLEQVRGVEGLAAKDYFNGFKLILDSQWNFNGRNRRPPTDPVNALLSFAYGLLRVQVTAAVHIAGLDPYIGYLHETTRGQPAMVLDLMEEFRPLIADSLVLSVISHKEIKPTDFNESLGAYLLSDSGRKTFLQAFERKLNTEFKHPVFGYQCSYRRSIELQARLFSRYLQENIPYKSLSLR | 233          | 595          | 333         | 39.94      | 133        | 179          | 191          | 6           | 21       | 57.36    | 98          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas4         | 515707..515117  | lcl|515707|515117|1|-1             | -1         | UniRef50_A0A2I8A541                   | 1.92E-99  | UniRef50_A0A2I8A541 cas4 CRISPR-associated exonuclease Cas4 n=83 Tax=Cyanobacteria TaxID=1117 RepID=A0A2I8A541_9NOSO                      | MIDNYLPLAYLNAFEYCTRRFYWEYVLGEMANNEHIIIGRHLHRNINQEGIIKEEDTIIHRQQWVWSDRLQIKGIIDAVEEKESSLVPVEYKKGRMSQHLNDHFQLCAAALCLEEKTGKIITYGEIFYHANRRRQRVDFSDRLRCSTEQAIHHAHELVNQKMPSPINNSKKCRDCSLKTMCLPKEVKQLRNSLISD | 285          | 729          | 195         | 66.154     | 129        | 66           | 162          | 0           | 0        | 83.08    | 99          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas6         | 516642..515833  | lcl|516642|515833|2|-1             | -1         | UniRef50_A0A654SHL3                   | 2.64E-108 | UniRef50_A0A654SHL3 cas6 CRISPR_Cas6 domain-containing protein n=30 Tax=Cyanobacteria TaxID=1117 RepID=A0A654SHL3_9CYAN                   | MVQDILPQLHKYQLQSLVIELGVAKQGKLPATLSRAIHACVLNWLSLADSQLANQIHDSQISPLCLSGLIGNRRQPYSLLGDYFLLRIGVLQPSLIKPLLKGIEAQETQTLELGKFPFIIRQVYSMPQSHKLSQLTDYYSLALYSPTMTEIQLKFLSPTSFKQIQGVQPFPLPELVFNSLLRKWNHFAPQELKFPEIQWQSFVSAFELKTHALKMEGGAQIGSQGWAKYCFKDTEQARIASILSHFAFYAGVGRKTTMGMGQTQLLVNT | 314          | 804          | 270         | 55.926     | 151        | 118          | 195          | 1           | 1        | 72.22    | 100         | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas5         | 517387..516611  | lcl|517387|516611|1|-1             | -1         | UniRef50_A0A2I8AFZ3                   | 1.43E-118 | UniRef50_A0A2I8AFZ3 cas5 Type I-D CRISPR-associated protein Cas5/Csc1 n=62 Tax=Cyanobacteria TaxID=1117 RepID=A0A2I8AFZ3_9NOSO            | MNIYYCQLTLHDNIFFATREMGLLYETEKYLHNWALSYAFFKGTYIPHPYRLQGKSAQKPDYLDSTGEQSLAHLNRLKIYVFPAKPLRWSYQINTFKAAQTTYYGKSQQFGDKGANRNYPINYGRAKELAVGSEYHTFLISSQELNIPHWIRVGKWSAKVEVTSYLIPQKAISQHSGIYLCDHPLNPIDLPFDQELLLYNRIVMPPVSLVSQAQLQGNYCKINKNNWNDCPSNLTDLPQQICLPLGVNYGAGYIASAS | 338          | 866          | 252         | 65.079     | 164        | 71           | 194          | 3           | 17       | 76.98    | 98          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas7         | 518600..517530  | lcl|518600|517530|3|-1             | -1         | UniRef50_B7JVM8                       | 0.00E+00  | UniRef50_B7JVM8 cas7 CRISPR-associated protein Csc2 n=52 Tax=Cyanobacteria TaxID=1117 RepID=B7JVM8_RIPO1                                  | MSILETLKPQFQSAFPRLASANYVHFIMLRHSQSFPVFQTDGVLNTVRTQAGLMAKDSLSRLVMFKRKQTTPERLTGRELLRSLNITTADKNDKEKGCEYNGEGSCKKCPDCIIYGFAIGDSGSERSKVYSDSTFSLSAYEQSHRTFTFNAPFEGGTMSEQGVMRSAINELDHILPEITFPNIETLRDSTYEGFIYVLGNILRTKRYGAQESRTGTMKNHLVGIAFCDGEIFSNLRFTQALYDGLEGDVNKPIDEICYQASQIVQTLLSDEPVRKIKTIFGEELNHLINEVSGIYQNDALLTETLNMLYQQTKTYSENHGSLAKSKPPKAEGNKSKGRTKKKGDDEQTSLDLNIEE | 733          | 1891         | 356         | 98.876     | 352        | 4            | 354          | 0           | 0        | 99.44    | 100         | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas10        | 521597..518673  | lcl|521597|518673|3|-1             | -1         | UniRef50_B7KB38                       | 0.00E+00  | UniRef50_B7KB38 cas10 CRISPR-associated protein Csc3 n=52 Tax=Cyanobacteria TaxID=1117 RepID=B7KB38_GLOC7                                 | MTLLQILLLETISQDTDPILISYLETVLPAMEPEFALIPALGGSQQIHYQNLIAIGNRYAQENAKRFSDKADQNLLVHVLNALLTAWNLVDHLTKPLSDIEKYLLCLGLTLHDYNKYCLGHGEESPKVSNINEIINICQELGKKLNFQAFWSDWEQYLPEIVYLAQNTQFKAGTNAIPANYPLFTLADSRRLDLPLRRLLAFGDIAVHLQDPADIISKTGGDRLREHLRFLGIKKALVYHRLRDTLGILSNGIHNATLRFAKDLNWQPLLFFAQGVIYLAPIDYTSPEKMELQGFIWQEISQLLASSMLKGEIGFKRDGKGLKVAPQTLELFTPVQLIRNLADVINVKVANAKVPATPKRLEKLELTDIERQLLEKGADLRADRIAELIILAQREFLADSPEFIDWTLQFWGLEKQITAEQTQEQSGGVNYGWYRVAANYIANHSTLSLEDVSGKLVDFCQQLADWATSNQLLSSHSSSTFEVFNSYLEQYLEIQGWQSSTPNFSQELSTYIMAKTQSSKQPICSLSSGEFISEDQMDSVVLFKPQQYSNKNPLGGGKIKRGISKIWALEMLLRQALWTVPSGKFEDQQPVFLYIFPAYVYSPQIAAAIRSLVNDMKRINLWDVRKHWLHEDMNLDSLRSLQWRKEEAEVGRFKDKYSRADIPFMGTVYTTTRGKTLTEAWIDPAFLTLALPILLGVKVIATSSSVPLYNSDNDFLDSVILDAPAGFWQLLKLSTSLRIQELSVALKRLLTIYTIHLDNRSNPPDARWQALNSTVREVITDVLNVFSIADEKLREDQREASPQEVQRYWKFAEIFAQGDTIMTEKLKLTKELVRQYRTFYQVKWSESSHTILLPLTKALEEILSTPEHWDDEELILQGAGILNDALDRQEVYKRPLLQDKSIPYEIRKQQELQAIHQFMTTCVKELFGQMCKGDRALLQEYRNRIKSGAESAYKLLAFEEKSNSSQQQKSSEDQ | 1073         | 2775         | 978         | 56.544     | 553        | 399          | 710          | 12          | 26       | 72.6     | 99          | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | cas3         | 523760..521655  | lcl|523760|521655|3|-1             | -1         | UniRef50_A0A168SWH5                   | 0.00E+00  | UniRef50_A0A168SWH5 cas3 Type I-D CRISPR-associated helicase Cas3 n=2 Tax=Phormidium TaxID=1198 RepID=A0A168SWH5_9CYAN                    | MKINLKPLYSKLNAGVGNCPLGCQEMCRVQQQAPQFKAPSGCNCPLYQHQAESYPYLTKGDTDIIFITAPTAGGKSLLASLPSLLDPNFRMMGLYPTIELVEDQTEQQNNYHNLFGLNSEERIDKLFGVELTQRIKEFNSNRFQQLWLAIETKEVILTNPDIFHLMTHFRYRDNAYGTDELPLALAKFPDLWVFDEFHIFGAHQETAVLNSMMLIRRTQQQKKRFLFTSATVKTDFVEQLKQTGLKIKEIAGEYKSEAQQGYRQILQAVELSIINLKEEDGFSWLINNAAKIRKILKAEDKGRGLIILNSVVMVRRISQELQSLLPEIVVREISGRIDRKERSQTQQLLQEEEKPVLVVATSAVDVGVDFRIHLLITESSDSATVIQRLGRLGRHSGFSNYQAFLLLSGRTPWVINRLQEKLESKQDVTREELIEAIQYAFDPPKEYQEYRNRWGAIQVQGMFSQMMGSNAKVMQSIKERISEDLKRIYGNTLDNKAWYAMGHNCLGKAIQSELLRFRGGSTLQAAVWDEQRFYTYDLLRLLPYATVDILDRETFLKAATKAGHIEEAFPSQYLQVYLRIEQWLDKRLNLNLFCNRESDELLVGKLFLITRLKLDGHPQSDVISCLSRCNLLTFLVPVDRSRTQSHWEVSYCLHLNPLFGLYRLKDASEQAYACAFNQDALLLEALNWKLTKFYRERSLIF                                                                                                                                                                                                                                                                                  | 671          | 1731         | 720         | 49.028     | 353        | 341          | 479          | 10          | 26       | 66.53    | 100         | GCF_000024045.1_ASM2404v1_genomic.fna 
 NC_013161.1 | 503817..525707      | CRISPR array | 512560..513624  | Copies: 15, Repeat: 37, Spacer: 36 | #NAME?     | GCF_000024045.1_ASM2404v1_genomic.fna |           |  |              |              |             |            |            |              |              |             |          |          |             |                                       


Descriptions of each output field are provided below:

 **Field name**  | **Description**                                                                                                                                    
-----------------|----------------------------------------------------------------------------------------------------------------------------------------------------
 Contig          | ID/accession for the parent contig/genome sequence.                                                                                                
 Loc_coordinates | Start and end position of the candidate locus (relative to the parent sequence).                                                                   
 Name            | Feature name/label. This is will be identical to "Description" (index 8) if parse_descriptions is True.                                            
 Coordinates     | Start and end position of this feature, relative to the parent sequence.                                                                           
 ORFID           | A unique ID given to this feature, primarily for internal use. Only applies to features that are genes.                                            
 Strand          | Specifies if the feature was found in the forward (1) or backward (-1) direction. Only applied to features that are genes.                         
 Accession       | ID/accession for the reference sequence that had the best alignment (by e-value) with this feature's translated sequence.                          
 E_val           | The e-value score for the best alignment for this feature.                                                                                         
 Description     | A description of this putative feature, parsed from the defline of best aligned reference sequence.                                                
 Sequence        | The (translated) amino acid sequence for this feature.                                                                                             
 Bitscore        | The bitscore for the best alignment for this feature.                                                                                              
 Rawscore        | The raw score for the best alignment for this feature.                                                                                             
 Aln_len         | The length of the best scoring alignment, in base pairs.                                                                                           
 Pident          | The fraction of identical positions in the best alignment.                                                                                         
 Nident          | The number of identical positions in the best alignment.                                                                                           
 Mismatch        | The number of mismatched positions in the best alignment.                                                                                          
 Positive        | The number of positive-scoring matches in the best alignment.                                                                                      
 Gapopen         | The number of gap openings.                                                                                                                        
 Gaps            | Total number of gaps in the alignment.                                                                                                             
 Ppos            | Percentage of positive scoring matches.                                                                                                            
 Qcovhsp         | Query coverage per HSP. That is, the fraction of the query (this feature's translated amino acid sequence) that was covered in the best alignment. 
 Contig_filename | The input data (genomic sequence(s)) file path.                                                                                                    


- **Results/CRISPR/\*_filtered/\*.png**: The visualizations of all predicted `CRISPR array`, as shown below:

  ![CRISPR array](https://cdn.jsdelivr.net/gh/liaochenlanruo/cdn@master/images/post/mgca_1.png)


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
