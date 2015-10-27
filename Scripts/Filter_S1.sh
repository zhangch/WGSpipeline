#!/usr/bin/env bash
echo "Aligning reads to hg19 Human reference genome with BWA"
$BWA aln -t $CPU $HUMANHG19 ${WORKDIR}/R1.fastq > ${WORKDIR}/aln_R1.sai
$BWA aln -t $CPU $HUMANHG19 ${WORKDIR}/R2.fastq > ${WORKDIR}/aln_R2.sai
$BWA sampe $HUMANHG19 ${WORKDIR}/aln_R1.sai ${WORKDIR}/aln_R2.sai ${WORKDIR}/R1.fastq ${WORKDIR}/R2.fastq > ${WORKDIR}/Aligned.out.sam
samtools view -S -f 4 ${WORKDIR}/Aligned.out.sam | awk '{OFS="\t"; print ">"$1"\n"$10}' - > ${WORKDIR}/${SAMPLE}_Filter_S1.fasta

echo "Removing intermediate files"
rm ${WORKDIR}/*.sai
rm ${WORKDIR}/Aligned.out.sam
