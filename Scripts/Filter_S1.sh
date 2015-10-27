#!/usr/bin/env bash
source ./configs.sh
echo "Step 1:"
echo "Aligning reads to hg19 Human reference genome with BWA"
$BWA aln -t $CPU $HUMANHG19 ${WORKDIR}/${SAMPLE}_R1.fastq > ${WORKDIR}/aln_R1.sai
$BWA aln -t $CPU $HUMANHG19 ${WORKDIR}/${SAMPLE}_R2.fastq > ${WORKDIR}/aln_R2.sai
$BWA sampe $HUMANHG19 ${WORKDIR}/aln_R1.sai ${WORKDIR}/aln_R2.sai ${WORKDIR}/${SAMPLE}_R1.fastq ${WORKDIR}/${SAMPLE}_R2.fastq > ${WORKDIR}/Aligned.out.sam
samtools view -S -f 4 ${WORKDIR}/Aligned.out.sam | awk '{OFS="\t"; print ">"$1"\n"$10}' - > ${WORKDIR}/${SAMPLE}_Filter_S1.fasta

echo "Removing intermediate files"
rm ${WORKDIR}/*.sai
rm ${WORKDIR}/Aligned.out.sam
