#!/usr/bin/env bash
source ./configs.sh
echo "Step 5:"
echo "Aligning the remaining reads to human sequence database with BLAST"
blastn -db $BLASTHUMANDB -num_threads $CPU -num_descriptions 1 -num_alignments 1 -word_size 13 -evalue 0.0001 -query ${WORKDIR}/${SAMPLE}_Filter_S4.fasta -out ${WORKDIR}/${SAMPLE}_Filter_S5.out
java -Xms2g -Xmx6g -jar WGSparser.jar parseBLAST ${WORKDIR}/${SAMPLE}_Filter_S4.fasta ${WORKDIR}/${SAMPLE}_Filter_S5.fasta

echo "Removing intermediate files"
rm ${WORKDIR}/${SAMPLE}_Filter_S5.out