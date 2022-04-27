![Platform](https://img.shields.io/badge/Platform-WSL%2FLinux%2FmacOS-green) [![License](https://img.shields.io/github/license/liaochenlanruo/mgca)](https://github.com/liaochenlanruo/mgca/blob/master/LICENSE) [![GitHubversion](https://anaconda.org/bioconda/mgca/badges/version.svg)](https://anaconda.org/bioconda/mgca) ![Downloads conda](https://img.shields.io/conda/dn/bioconda/mgca.svg?style=flat) [![install with bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat)](http://bioconda.github.io/recipes/mgca/README.html) [![BIOINFORMATICS](https://pub.idqqimg.com/wpa/images/group.png "945751012")](//shang.qq.com/wpa/qunwpa?idkey=fd4637eecd73bf0a5a8caa274843a07afdf1fbbc40a86630df5d4b029749cc7b)

# MGCA
Microbial genome component and annotation pipeline

<p><center>
<div style="display:inline-block;width:200px;"><script type="text/javascript" src="//rf.revolvermaps.com/0/0/7.js?i=57lw18tyu78&amp;m=7&amp;c=ff0000&amp;cr1=ffffff&amp;sx=0" async="async"></script></div>
&nbsp;&nbsp;&nbsp;&nbsp;
<script type="text/javascript" src="//rf.revolvermaps.com/0/0/0.js?i=5yz1k9xmfb5&amp;d=3&amp;p=1&amp;b=0&amp;w=293&amp;g=2&amp;f=arial&amp;fs=12&amp;r=0&amp;c0=362b05&amp;c1=375363&amp;c2=000000&amp;ic0=0&amp;ic1=0" async="async"></script>
</center></p>
-------------

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

    #- gtdbtk
    #- infernal 1.1.4
    #- bakta (include trnascan-se)
    #- repeatmasker 4.1.2.p1 (include trf)
    #- mummer4 4.0.0rc1
    #- artemis 18.2.0 (include openjdk)
    #- saspector 0.0.5 (include trf progressivemauve prokka)
    #- lastz 1.04.15
    #- kakscalculator2
    #- interproscan 5.54_87.0 (include emboss openjdk)
    #- eggnog-mapper 2.1.7 (include wget)

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

# License
-------

MGCA is free software, licensed under GPLv3.

# Feedback and Issues
-------------------

Please report any issues to the [issues page](https://github.com/liaochenlanruo/mgca/issues?_blank) or email us at <liaochenlanruo@webmail.hzau.edu.cn>.

# Citation
--------

- If you use this software please cite: Hualin Liu. MGCA: microbial genome component and annotation pipeline. Avaliable at GitHub [https://github.com/liaochenlanruo/mgca](https://github.com/liaochenlanruo/mgca)

# Updates
-------

## - V0.0.0

  - The MGCA was born.

------------------------------------------------------------------------

<p><center><strong>
<script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
<span id="busuanzi_container_site_pv">Total visits: <span id="busuanzi_value_site_pv"></span> times</span>
<span class="post-meta-divider">|</span>
<span id="busuanzi_container_site_uv">Visitors: <span id="busuanzi_value_site_uv"></span> people</span>
</strong></center></p>
