#!/bin/bash
#SBATCH --account="gbru_fy21_tomato_ralstonia"
#SBATCH --job-name=gm_human
#SBATCH --output=gm_human_%A_%a.out
#SBATCH --error=gm_human_%A_%a.err
#SBATCH --time=96:00:00
#SBATCH -p bigmem
#SBATCH -N 1
#SBATCH -n 48
#SBATCH --mem 1500G


# print info
date;hostname;pwd


module load conda
#source activate guidemakerenv
source activate AVX2




inputgenome=GCF_000001405.39_GRCh38.p13_genomic.gbff
inputpam=NNAGAAW


echo $SLURM_CLUSTER_NAME 
echo $SLURM_JOB_NODELIST
echo $SLURM_JOB_PARTITION
echo $SLURM_JOB_NUM_NODES


logfile=GM_human_hamming_NNAGAAW_"$SLURM_JOB_ID"_"$SLURM_ARRAY_TASK_ID".log




for i in 0

do

array=(32)


for THREADS in "${array[@]}"
do
  	echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
        echo "My TMPDIR IS: " $TMPDIR

        echo "Input Genome:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " $inputgenome
        echo "Input PAM:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " $inputpam
        echo "Threads used:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " $THREADS
        echo "GuideMaker"

        /usr/bin/time -v guidemaker \
			-i /project/gbru_fy21_tomato_ralstonia/guidemaker/all_test_data/GCF_000001405.39_GRCh38.p13_genomic.gbff.gz \
                        --pamseq NNAGAAW --outdir TEST --pam_orientation 3prime \
                        --guidelength 20 --lsr 11 --dist 3 --before 500 \
                        --into  500 --knum 10 --controls 10  --log $logfile --threads $THREADS

done
done

