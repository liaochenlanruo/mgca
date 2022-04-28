---
sort: 1
---

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


# License
-------

MGCA is free software, licensed under GPLv3.

# Feedback and Issues
-------------------

Please report any issues to the [issues page](https://github.com/liaochenlanruo/mgca/issues?_blank) or email us at <liaochenlanruo@webmail.hzau.edu.cn>.

# Citation
--------

If you use this software please cite: Hualin Liu. MGCA: microbial genome component and annotation pipeline. Avaliable at GitHub [https://github.com/liaochenlanruo/mgca](https://github.com/liaochenlanruo/mgca)


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
