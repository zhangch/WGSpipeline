#!/usr/bin/env bash
source ./configs.sh
echo "Step 1:"
echo "Aligning fully filtered reads to NCBI bacteria compelete genomes with Bowtie2"
$BOWTIE2 -p ${CPU} --local -D 20 -R 3 -N 1 -L 32 -i S,1,0.50 -x ${BACTERIA} -f ${WORKDIR}/${SAMPLE}_Filter_S5.fasta -S ${WORKDIR}/${SAMPLE}_profiling.sam

echo "Step 2:"
echo "Calculating the genome coverages"
grep "@SQ" ${WORKDIR}/${SAMPLE}_profiling.sam | awk '{print substr($2,4),substr($3,4)}' > ${WORKDIR}/speciesList.txt
mkdir ${WORKDIR}/result
samtools view -S -F4 ${WORKDIR}/${SAMPLE}_profiling.sam >> ${WORKDIR}/result/mappedReads.sam
samtools view -S -H ${WORKDIR}/${SAMPLE}_profiling.sam >> ${WORKDIR}/result/header.sam 
finalCount=0
cat ${WORKDIR}/speciesList.txt | while read line; do 
		species=$(echo $line | awk '{print $1}')
		speShort=$(echo $line | awk '{match($1,"[A-Z][a-z]*[_][a-z]*",a)}END{print a[0],$3}')
		genomeLength=$(echo $line | awk '{print $2}')
		#echo $species
    count=$(grep -v "XS" ${WORKDIR}/result/mappedReads.sam | grep -c $species)
    if [ $count -gt $MINCOUNTS ]; then
			$((finalCount++))
    	echo $species
    	grep -v "XS" ${WORKDIR}/result/mappedReads.sam | grep $species > ${WORKDIR}/result/temp.sam
    	cat ${WORKDIR}/result/header.sam ${WORKDIR}/result/temp.sam > ${WORKDIR}/result/temp1.sam
			samtools view -S -b  ${WORKDIR}/result/temp1.sam -o ${WORKDIR}/result/temp1.bam
			samtools sort ${WORKDIR}/result/temp1.bam ${WORKDIR}/result/temp2
			samtools index ${WORKDIR}/result/temp2.bam
			samtools view ${WORKDIR}/result/temp2.bam -o ${WORKDIR}/result/${speShort}
			Rscript calVar.R ${WORKDIR}/result/${speShort} $genomeLength 5000 $VAR1 $VAR2
    	rm ${WORKDIR}/result/temp.sam
    	rm ${WORKDIR}/result/temp1.sam
    	rm ${WORKDIR}/result/temp1.bam
    	rm ${WORKDIR}/result/temp2.bam
    	rm ${WORKDIR}/result/temp2.bam.bai
    	rm ${WORKDIR}/result/${speShort}
    fi
done

echo "Step 3:"
echo "Assigning the multiple mapped the reads with PathoScope"
python $PATHOSCOPE ID -alignFile ${WORKDIR}/${SAMPLE}_profiling.sam -expTag ${SAMPLE} -outDir ${WORKDIR}/result

echo "Step 4:"
echo "Re-evaluating the relative abundances of microbiome"
if [ $finalCount -gt 0 ]; then
	Rscript calPer.R ${WORKDIR}/result/${SAMPLE}-sam-report.tsv ${WORKDIR}/result/report.txt ${SAMPLE}
fi
echo "Removing intermediate files"
rm ${WORKDIR}/result/*.sam
rm ${WORKDIR}/result/${SAMPLE}-sam-report.tsv
rm ${WORKDIR}/result/report.txt
