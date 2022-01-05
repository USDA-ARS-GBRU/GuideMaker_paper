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


#module load conda
#source activate guidemakerenv
#source activate AVX2




inputgenome=GCA_000001405.15_GRCh38_no_alt_analysis_set
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
                        --fasta /project/gbru_fy21_tomato_ralstonia/guidemaker/all_test_data/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz \
                        --gff /project/gbru_fy21_tomato_ralstonia/guidemaker/all_test_data/GCA_000001405.15_GRCh38_full_analysis_set.refseq_annotation.gff.gz \
                        --pamseq NNAGAAW --outdir TEST --pam_orientation 3prime \
                        --guidelength 25 --lsr 20 --dist 3 --before 500 \
                        --into  500 --knum 10 --controls 10  --log $logfile --threads $THREADS

done
done

