#!/bin/bash 
#SBATCH --job-name=infocap_tbi_mask2SD_win
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=noelia.martinez@upf.edu
#SBATCH --mem-per-cpu=2G
#SBATCH --cpus-per-task=1
#SBATCH --output=jobid-%A_%a.out
#SBATCH --error=jobid-%A_%a.err
#SBATCH --array=1-100

#Load Matlab 2017a module

ml MATLAB

matlab -nojvm -nodisplay<<-EOF
for cond=1
infocapacity_hopf_errorhete_tbi_mask2SD_bin(${SLURM_ARRAY_TASK_ID},cond);
end
EOF




#matlab -singleCompThread -nojvm -nodisplay < -r "run_hbif(${slurmArrayID},2,'grans');exit;" 
