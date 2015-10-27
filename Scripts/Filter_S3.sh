#!/usr/bin/env bash
source ./configs.sh
echo "Step 3:"
echo "Aligning reads to hg19 Human reference genome with BWA"
RepeatMasker -species human -qq -pa ${CPU} ${WORKDIR}/${SAMPLE}_Filter_S2.fasta -dir ${WORKDIR}
java -jar WGSparser.jar parseRM ${WORKDIR}/${SAMPLE}_Filter_S2.fasta ${WORKDIR}/${SAMPLE}_Filter_S3.fasta

echo "Removing intermediate files"
rm ${WORKDIR}/${SAMPLE}_Filter_S2.fasta.tbl
rm ${WORKDIR}/${SAMPLE}_Filter_S2.fasta.out
rm ${WORKDIR}/${SAMPLE}_Filter_S2.fasta.masked
rm ${WORKDIR}/${SAMPLE}_Filter_S2.fasta.cat.gz
