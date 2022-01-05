#!/bin/bash
#SBATCH --account="gbru_fy21_tomato_ralstonia"
#SBATCH --job-name=avx_ph_leven
#SBATCH --array=1-1
#SBATCH --time=96:00:00
#SBATCH -p atlas
#SBATCH -N 1
#SBATCH -n 40
#SBATCH -o slurm-%A_%a.out



# print info
date;hostname;pwd


module load conda
#source activate guidemakerenv
source activate AVX2




inputgenome=$1
inputpam=$2
dtype=$3
outdir=$4
bname=$(basename $inputgenome)


echo $SLURM_CLUSTER_NAME
echo $SLURM_JOB_NODELIST
echo $SLURM_JOB_PARTITION
echo $SLURM_JOB_NUM_NODES


logfile=GM_"$inputpam"_"$dtype"_"$SLURM_JOB_ID"_"$SLURM_ARRAY_TASK_ID".log




for i in 0

do

array=(32)


for THREADS in "${array[@]}"
do
  	echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
        echo "My TMPDIR IS: " $TMPDIR

        echo "Input Genome:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " $bname
        echo "Input PAM:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " $inputpam
        echo "Threads used:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " $THREADS
        echo "GuideMaker"

        /usr/bin/time -v guidemaker -i $inputgenome \
                        --pamseq $inputpam --outdir $outdir --pam_orientation 3prime \
                        --guidelength 20 --lsr 11 --dist 3 --before 500 --dtype $dtype \
                        --into  500 --knum 10 --controls 10  --log $logfile --threads $THREADS

done
done

