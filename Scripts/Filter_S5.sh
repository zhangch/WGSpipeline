#!/usr/bin/env bash
echo "Aligning the remaining reads to human sequence database with MegaBLAST"
megablast -d "/zenodotus/dat01/betellab_scratch/chz2009/Shah_HP/TCGA/human_blast/ref_contig /zenodotus/dat01/betellab_scratch/chz2009/Shah_HP/TCGA/human_blast/alt_HuRef_contig /zenodotus/dat01/betellab_scratch/chz2009/Shah_HP/TCGA/human_blast/human_genomic" -a 8 -W 16 -e 0.0000001 -v 1 -b 0 -i ${WORKDIR}/${SAMPLE}_Filter_S4.fasta -o ${WORKDIR}/${SAMPLE}_Filter_S5.out
java -Xms2g -Xmx6g -jar WGS.jar parseMEGA ${WORKDIR}/${SAMPLE}_Filter_S5.out ${SAMPLE}_Filter_S4.fasta

echo "Removing intermediate files"
rm ${WORKDIR}/${SAMPLE}_Filter_S4.out