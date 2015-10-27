#!/usr/bin/env bash
echo "Aligning reads to hg19 Human reference genome with BWA"
$BWA aln -t $CPU ${HUMANOTHER} ${WORKDIR}/${SAMPLE}_Filter_S1.fasta > ${WORKDIR}/${SAMPLE}_S2.sai
$BWA samse ${HUMANOTHER} ${WORKDIR}/${SAMPLE}_S2.sai ${WORKDIR}/${SAMPLE}_Filter_S1.fasta >${WORKDIR}/${SAMPLE}_S2.sam
samtools view -S -f 4 ${TEMPLOC}/${SAMPLE}/${SAMPLE}_S2.sam | awk '{OFS="\t"; print ">"$1"\n"$10}' - > ${WORKDIR}/${SAMPLE}_Filter_S2.fasta
	
echo "Removing intermediate files"
rm ${WORKDIR}/*.sai
rm ${WORKDIR}/${SAMPLE}_S2.sam
