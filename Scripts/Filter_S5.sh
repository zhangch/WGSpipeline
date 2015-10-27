#!/usr/bin/env bash
source ./configs.sh
echo "Step 5:"
echo "Aligning the remaining reads to human sequence database with MegaBLAST"
megablast -d $BLASTHUMANDB -a $CPU -W 16 -e 0.0000001 -v 1 -b 0 -i ${WORKDIR}/${SAMPLE}_Filter_S4.fasta -o ${WORKDIR}/${SAMPLE}_Filter_S5.out
java -Xms2g -Xmx6g -jar WGSparser.jar parseBLAST ${WORKDIR}/${SAMPLE}_Filter_S4.fasta ${WORKDIR}/${SAMPLE}_Filter_S5.fasta

echo "Removing intermediate files"
rm ${WORKDIR}/${SAMPLE}_Filter_S5.out