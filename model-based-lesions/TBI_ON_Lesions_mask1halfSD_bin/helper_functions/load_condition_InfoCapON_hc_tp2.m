function [vcondition]=load_condition_InfoCapON_hc_tp2(trial,cond)

for i=1:trial
    load(sprintf('Wtrials_%03d_%d_err_hete_ON_hc_tp2.mat',i,cond));
    vcondition.infocap_all(i,:)=infocapacity;
    vcondition.suscep_all(i,:)=susceptibility;
end