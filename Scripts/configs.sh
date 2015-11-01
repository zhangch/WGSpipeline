#!/bin/bash -l
export PATH=/home/user/tools/bowtie2-2.2.5/:/home/user/tools/samtools-0.1.18:/home/user/tools/RepeatMasker:/home/user/tools/blast-2.2.27/bin/:/home/user/R/R-3.0.2/bin/:/home/user/R/R-3.0.2/bin/£º$PATH

BWA=/home/user/tools/bwa-0.6.2/bwa
BOWTIE2=/home/user/tools/bowtie2-2.2.5/bowtie2
PATHOSCOPE=/home/user/ptools/pathoscope2/pathoscope/pathoscope.py

HUMANHG19="/home/user/genomes/hg19_bwa/hs_ref_GRCh37_p10.fa"
HUMANOTHER="/home/user/genomes/human_bwa/human_genomic"
BACTERIA="/home/user/genomes/bowtie2_allbac/bowtie2_allbac"
BLASTHUMANDB="/home/user/genomes/human_blast/human_genomic"

WORKDIR="/home/user/WGSpipe"
SAMPLE="SRS022545"
CPU=16
MINCOUNTS=50
VAR1=2
VAR2=0.00005