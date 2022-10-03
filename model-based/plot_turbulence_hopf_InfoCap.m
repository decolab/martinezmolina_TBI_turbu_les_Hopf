clear all;
addpath('/Volumes/LASA/TBI_project/TBI_openneuro/Hopf_model/TBI_homogeneous/outputs/Trials/TBI/');
addpath('/Volumes/LASA/TBI_project/Shared_code/Hopf_TBI_ON/');
trials=100;
groups={'hc','tbi_tp1','tbi_tp2','tbi_tp3'};

tbi_cond1=load_condition_InfoCapON_tbi(trials,1);
tbi_cond2=load_condition_InfoCapON_tbi(trials,2);
tbi_cond3=load_condition_InfoCapON_tbi(trials,3);

addpath('/Volumes/LASA/TBI_project/TBI_openneuro/Hopf_model/TBI_homogeneous/outputs/Trials/HC/'); %controls
cnt=load_condition_InfoCapON_hc(trials,1);

% Wilcoxon ranksum 

% pval(1) = ranksum(cond1.infocap_all,cnt.infocap_all);
% pval(2) = ranksum(cnt.infocap_all,cond2.infocap_all);
% pval(3) = ranksum(cond1.infocap_all,cond2.infocap_all);
% pval(4) = ranksum(cnt.infocap_all,cond3.infocap_all);
% pval(5) = ranksum(cond1.infocap_all,cond3.infocap_all);
% pval(6) = ranksum(cond2.infocap_all,cond3.infocap_all);
% 
% pvalS(1) = ranksum(cond1.suscep_all,cnt.suscep_all);
% pvalS(2) = ranksum(cnt.suscep_all,cond2.suscep_all);
% pvalS(3) = ranksum(cond1.suscep_all,cond2.suscep_all);
% pvalS(4) = ranksum(cnt.suscep_all,cond3.suscep_all);
% pvalS(5) = ranksum(cond1.suscep_all,cond3.suscep_all);
% pvalS(6) = ranksum(cond2.suscep_all,cond3.suscep_all);

%% T-Test 

[~,pval_infocap_hctbi1] = ttest2(tbi_cond1.infocap_all,cnt.infocap_all); % Two-sample t-Test
[~,pval_infocap_hctbi2] = ttest2(tbi_cond2.infocap_all,cnt.infocap_all); % Two-sample t-Test
[~,pval_infocap_hctbi3] = ttest2(tbi_cond3.infocap_all,cnt.infocap_all); % Two-sample t-Test

[~,pval_suscep_hctbi1] = ttest2(tbi_cond1.suscep_all,cnt.suscep_all); % Two-sample t-Test
[~,pval_suscep_hctbi2] = ttest2(tbi_cond2.suscep_all,cnt.suscep_all); % Two-sample t-Test
[~,pval_suscep_hctbi3] = ttest2(tbi_cond3.suscep_all,cnt.suscep_all); % Two-sample t-Test

cd('/Volumes/LASA/TBI_project/TBI_openneuro/Hopf_model/TBI_homogeneous/outputs/Trials/')
%% FDR correction
pval_infocap=horzcat(pval_infocap_hctbi1,pval_infocap_hctbi2,pval_infocap_hctbi3);
[h, crit_p, adj_ci_cvrg, adj_p]=fdr_bh(pval_infocap,.05,'pdep','yes'); %FDR correction Benjamini & Hochberg (1995)
adj_pval_infocap_BH=adj_p; save ('adj_pval_infocap_BH','adj_pval_infocap_BH')

pval_suscep=horzcat(pval_suscep_hctbi1,pval_suscep_hctbi2,pval_suscep_hctbi3);
[h, crit_p, adj_ci_cvrg, adj_p]=fdr_bh(pval_suscep,.05,'pdep','yes'); %FDR correction Benjamini & Hochberg (1995)
adj_pval_suscep_BH=adj_p; save ('adj_pval_suscep_BH','adj_pval_suscep_BH')


figure
subplot(2,1,1)
boxplot([cnt.infocap_all tbi_cond1.infocap_all tbi_cond2.infocap_all tbi_cond3.infocap_all],'labels',groups)
%H=sigstar({[1,2] [1,3] [3,2] [1 4] [2 4] [3 4]},[pval(:)]); ylabel('Information Capacity')
title(sprintf('N=%d trials',trials));
ylabel('Information capacity');

subplot(2,1,2)
boxplot([ cnt.suscep_all tbi_cond1.suscep_all tbi_cond2.suscep_all tbi_cond3.suscep_all],'labels',groups)
%H=sigstar({[1,2] [1,3] [3,2] [1 4] [2 4] [3 4]},[pvalS(:)]); ylabel('Susceptibility')
ylabel('Susceptibility')

print('Information capacity & susceptibility TBI Open Neuro N=24 TP123', '-dpng')