clear all
addpath('/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/Hopf_model/TBI_homogeneous/outputs/Trials/TBI/');
addpath('/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/Hopf_model/TBI_ON_Hopf_hc_tp2/outputs/Trials/');
addpath('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Hopf_TBI_ON/'); %codepath
outdir('/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/Hopf_model/TBI_ON_Hopf_hc_tp2/outputs/Trials');
trials=100;
groups={'hc','tbi_tp1','tbi_tp2','tbi_tp3'};

hc_cond2=load_condition_InfoCapON_hc_tp2(trials,1);
tbi_cond1=load_condition_InfoCapON_tbi(trials,1);
tbi_cond2=load_condition_InfoCapON_tbi(trials,2);
tbi_cond3=load_condition_InfoCapON_tbi(trials,3);

%% To export for stats 
hc_cond2_infocap=hc_cond2.infocap_all;
tbi_cond1_infocap=tbi_cond1.infocap_all;
tbi_cond2_infocap=tbi_cond2.infocap_all;
tbi_cond3_infocap=tbi_cond3.infocap_all;

hc_cond2_suscep=hc_cond2.suscep_all;
tbi_cond1_suscep=tbi_cond1.suscep_all;
tbi_cond2_suscep=tbi_cond2.suscep_all;
tbi_cond3_suscep=tbi_cond3.suscep_all;

cd(outdir)
save ('perturbation_hc_cond2.mat', 'hc_cond2_infocap','hc_cond2_suscep')
save ('perturbation_tbi_cond1.mat', 'tbi_cond1_infocap','tbi_cond1_suscep')
save ('perturbation_tbi_cond2.mat', 'tbi_cond2_infocap','tbi_cond2_suscep')
save ('perturbation_tbi_cond3.mat', 'tbi_cond3_infocap','tbi_cond3_suscep')

%% Visualization
figure
subplot(2,1,1)
boxplot([hc_cond2.infocap_all tbi_cond1.infocap_all tbi_cond2.infocap_all tbi_cond3.infocap_all],'labels',groups)
title(sprintf('N=%d trials',trials));
ylabel('Information capacity');

subplot(2,1,2)
boxplot([ hc_cond2.suscep_all tbi_cond1.suscep_all tbi_cond2.suscep_all tbi_cond3.suscep_all],'labels',groups)
ylabel('Susceptibility')

print('Information capacity & susceptibility TBI Open Neuro N=24 TP123', '-dpng')

