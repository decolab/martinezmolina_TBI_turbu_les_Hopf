clear all;
addpath('/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/Hopf_model/TBI_ON_Lesions_Hopf_mask1halfSD_weight/outputs/Trials/');
addpath('/Volumes/LASA/TBI_OpenNeuro/Shared_code/TBI_ON_Lesions_Hopf_mask1halfSD_weight/');
trials=100;
groups={'tbi_tp1','tbi_tp2','tbi_tp3'};

tbi_cond1=load_condition_tbi_mask1halfSD_weight(trials,1);
tbi_cond2=load_condition_tbi_mask1halfSD_weight(trials,2);
tbi_cond3=load_condition_tbi_mask1halfSD_weight(trials,3);

tbi_cond1_infocap=tbi_cond1.infocap_all;
tbi_cond2_infocap=tbi_cond2.infocap_all;
tbi_cond3_infocap=tbi_cond3.infocap_all;

tbi_cond1_suscep=tbi_cond1.suscep_all;
tbi_cond2_suscep=tbi_cond2.suscep_all;
tbi_cond3_suscep=tbi_cond3.suscep_all;

% Plot results
figure
subplot(2,1,1)
boxplot([tbi_cond1.infocap_all tbi_cond2.infocap_all tbi_cond3.infocap_all],'labels',groups)
%H=sigstar({[1,2] [1,3] [3,2] [1 4] [2 4] [3 4]},[pval(:)]); ylabel('Information Capacity')
title(sprintf('N=%d trials',trials));
ylabel('Information capacity');

subplot(2,1,2)
boxplot([ tbi_cond1.suscep_all tbi_cond2.suscep_all tbi_cond3.suscep_all],'labels',groups)
%H=sigstar({[1,2] [1,3] [3,2] [1 4] [2 4] [3 4]},[pvalS(:)]); ylabel('Susceptibility')
ylabel('Susceptibility')

print('Information capacity & susceptibility TBI Open Neuro N=24 TP123 Lesion Mask 1halfSD weight', '-dpng')

