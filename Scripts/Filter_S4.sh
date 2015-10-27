#!/usr/bin/env bash
echo "Aligning the remaining reads to human sequence database with BLAST"
blastn -db "/zenodotus/dat01/betellab_scratch/chz2009/Shah_HP/TCGA/human_blast/ref_contig /zenodotus/dat01/betellab_scratch/chz2009/Shah_HP/TCGA/human_blast/alt_HuRef_contig /zenodotus/dat01/betellab_scratch/chz2009/Shah_HP/TCGA/human_blast/human_genomic" -num_threads 8 -num_descriptions 1 -num_alignments 1 -word_size 13 -evalue 0.0001 -query ${WORKDIR}/${SAMPLE}_Filter_S3.fasta -out ${WORKDIR}/${SAMPLE}_Filter_S4.out
java -Xms2g -Xmx6g -jar WGS.jar parseBLAST ${WORKDIR}/${SAMPLE}_Filter_S4.out ${SAMPLE}_Filter_S3.fasta

echo "Removing intermediate files"
rm ${WORKDIR}/${SAMPLE}_Filter_S4.out