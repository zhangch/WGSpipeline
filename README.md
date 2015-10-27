WGS pipeline for microbiome profiling from biopsy samples
====

Computational pipelines for filtering host DNA and evaluating the microbiome abundance from biopsy WGS samples.

Citing our paper:
---------
Zhang C, Cleveland K, Schnoll-Sussman F, McClure B, Bigg M, Thakkar P, Schultz M, Shah M, and Betel D. Identification of the gastric microbiome from endoscopic biopsy samples using whole genome sequencing. Genome Biology. 2015

Installing prerequisite software and corresponding databases
---------
#### BWA
Download: [BWA 0.6.2](http://sourceforge.net/projects/bio-bwa/files/bwa-0.6.2.tar.bz2/download)  
hg19 Human reference genome: http://hgdownload.soe.ucsc.edu/goldenPath/hg19/chromosomes/  
Additional human genomes: ftp://ftp.ncbi.nlm.nih.gov/genomes/H_sapiens//ARCHIVE/BUILD.37.3/Assembled_chromosomes/seq/  
#### RepearMasker  
Download: [RepeatMasker 4.0.5](http://www.repeatmasker.org/RMDownload.html)  
Database: [Repbase for RepeatMasker] (http://www.girinst.org/)
#### BLAST & MegaBLAST 2.2.27
Download: ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.27/  
Database: [Combined human sequence database] (http://www.girinst.org/)
#### Bowtie2  
Download: [Bowtie2 2.2.5](http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.5/)  
NCBI bacteria compelete genomes: ftp://ftp.ncbi.nlm.nih.gov/genomes/Bacteria/
#### PathoScope  
Download: [PathoScope 2.0](http://sourceforge.net/projects/pathoscope/)  
#### R 
Download: [R 3.0.2](https://cran.r-project.org/src/base/R-3/R-3.0.2.tar.gz)  
#### samtools 
Download: [samtools 0.1.19](http://sourceforge.net/projects/samtools/files/samtools/0.1.19/) 

Setting the parameters
---------
Set the correct paths to above software and databases in configs.sh, and run `bash configs.sh`

Filtering host DNA
---------
Step 1. Align all reads to hg19 Human reference genome with BWA  
`bash Filter_S1.sh`  
Step 2. Align the remaining unmapped reads to additional human genomes with BWA  
`bash Filter_S2.sh`  
Step 3. Filter the remaining unmapped reads with RepearMasker  
`bash Filter_S3.sh`  
Step 4. Align the remaining reads to human sequence database with BLAST  
`bash Filter_S4.sh`  
Step 5. Align the remaining reads to human sequence database with MegaBLAST  
`bash Filter_S5.sh`  

Microbiome profiling
---------
Step 1. Align fully filtered reads to NCBI bacteria compelete genomes with Bowtie2  
Step 2. Calculate the genome coverages to further remove false identification  
Step 3. Assign the multiple mapped the reads with PathoScope  
Step 4. Re-evaluate the relative abundances of microbiome  
