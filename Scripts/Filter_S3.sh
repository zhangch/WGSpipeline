#!/usr/bin/env bash
echo "Aligning reads to hg19 Human reference genome with BWA"
RepeatMasker -species human -qq -pa ${CPU} ${WORKDIR}/${SAMPLE}_Filter_S2.fasta -dir ${WORKDIR}
java -jar WGS.jar parseRM ${WORKDIR}/ ${#samples[@]}

