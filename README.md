![Platform](https://img.shields.io/badge/Platform-WSL%2FLinux%2FmacOS-green) [![License](https://img.shields.io/github/license/liaochenlanruo/mgca)](https://github.com/liaochenlanruo/mgca/blob/master/LICENSE) [![GitHubversion](https://anaconda.org/bioconda/mgca/badges/version.svg)](https://anaconda.org/bioconda/mgca) ![Downloads conda](https://img.shields.io/conda/dn/bioconda/mgca.svg?style=flat) [![install with bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat)](http://bioconda.github.io/recipes/mgca/README.html) [![…˙–≈÷Æ·€](https://pub.idqqimg.com/wpa/images/group.png "945751012")](//shang.qq.com/wpa/qunwpa?idkey=fd4637eecd73bf0a5a8caa274843a07afdf1fbbc40a86630df5d4b029749cc7b)

# MGCA
Microbial genome component and annotation pipeline

<p><center>
<script type="text/javascript" src="//rf.revolvermaps.com/0/0/7.js?i=5s00t0kj4q3&amp;m=7&amp;c=ff0000&amp;cr1=ffffff&amp;sx=0" async="async"></script>
&nbsp;&nbsp;&nbsp;&nbsp;
<script type="text/javascript" src="//rf.revolvermaps.com/0/0/0.js?i=5yz1k9xmfb5&amp;d=3&amp;p=1&amp;b=0&amp;w=293&amp;g=2&amp;f=arial&amp;fs=12&amp;r=0&amp;c0=362b05&amp;c1=375363&amp;c2=000000&amp;ic0=0&amp;ic1=0" async="async"></script>
</center></p>
-------------

# Installation
----
he software was tested successfully on Windows WSL, Linux x64 platform, and macOS. Because this software relies on a large number of other software, so it is recommended to install with **[Bioconda](https://bioconda.github.io/index.html)**.

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
