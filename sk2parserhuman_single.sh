#!/bin/bash
#$ -l h_vmem=15G
#$ -l h_rt=99:00:00
#$ -cwd
#$ -M s.klaasen@hubrecht.eu
#S -M n.lansu@hubrecht.eu
#$ -m beas
#$ -pe threaded 8

A="S5"

cd /hpc/hub_kops/rawdataandmapped/run5

gunzip *$A*_R1_001.fastq.gz

mkdir $A-output

cat *$A*_R1_001.fastq > $A-output/$A-R1.fastq

bwa aln -q 0 -n 0.04 -k 2 -l 200 -t 4 -B 11 /hpc/hub_kops/GRCh38.p10.genome.clean.fa $A-output/$A-R1.fastq > $A-output/$A-R1.sai

gzip *$A*_R1_001.fastq

bwa samse /hpc/hub_kops/GRCh38.p10.genome.clean.fa $A-output/$A-R1.sai $A-output/$A-R1.fastq > $A-output/$A-R1.sam

python /hpc/hub_kops/nlaparserbed96.py $A-output/$A-R1.sam

cd $A-output

awk '{print >> $8; close($8)}' $A-R1.sam_Rnla.out

/hpc/hub_kops/rmcelln.sh *
/hpc/hub_kops/sortcells.sh *
/hpc/hub_kops/remove.duplicate.reads.sh *
/hpc/hub_kops/removeumi.sh *

C="run5_S5"

mkdir /hpc/hub_kops/mappeddata1/$C
cp {1..384} /hpc/hub_kops/mappeddata1/$C
