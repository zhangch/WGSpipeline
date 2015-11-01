#!/usr/bin/env bash
source ./configs.sh
echo "Step 4:"
echo "Aligning the remaining reads to human sequence database with MegaBLAST"
megablast -d $BLASTHUMANDB -a $CPU -W 16 -e 0.0000001 -v 1 -b 0 -i ${WORKDIR}/${SAMPLE}_Filter_S3.fasta -o ${WORKDIR}/${SAMPLE}_Filter_S4.out
java -Xms2g -Xmx6g -jar WGSparser.jar parseBLAST ${WORKDIR}/${SAMPLE}_Filter_S3.fasta ${WORKDIR}/${SAMPLE}_Filter_S4.fasta

echo "Removing intermediate files"
rm ${WORKDIR}/${SAMPLE}_Filter_S4.out