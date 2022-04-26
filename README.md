# mgca
Microbial genome component and annotation pipeline
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
