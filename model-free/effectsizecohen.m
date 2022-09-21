% Compute effect size (Cohen's D)

% Load empirical measures of turbulence
clear all
cd('/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/');                                       
load('turbu_all_measurements__openneuro_controls_con1.mat')  
load('turbu_by_node_openneuro_controls_con1.mat')  

Turbulence_global_sub_hc=Turbulence_global_sub; %Amplitude turbulence
TransferLambda_sub_hc=TransferLambda_sub; %Information cascade flow
InformationCascade_sub_hc=InformationCascade_sub; %Information cascade
Transfer_sub_hc=Transfer_sub; %Information transfer
Turbulence_RSN_sub_hc_lam6=squeeze(TurbulenceRSN_sub(8,:,:)); % Turbulence by RSN at lambda 6
Turbulence_RSN_sub_hc_lam3=squeeze(TurbulenceRSN_sub(9,:,:)); % Turbulence by RSN at lambda 3

clearvars -except Turbulence_global_sub_hc TransferLambda_sub_hc InformationCascade_sub_hc Transfer_sub_hc Turbulence_RSN_sub_hc_lam6 Turbulence_RSN_sub_hc_lam3

load('turbu_all_measurements__openneuro_tbi_con1.mat')
load('turbu_by_node_openneuro_tbi_con1.mat')

Turbulence_global_sub_tbi_tp1=Turbulence_global_sub; %Amplitude turbulence
TransferLambda_sub_tbi_tp1=TransferLambda_sub; %Information cascade flow
InformationCascade_sub_tbi_tp1=InformationCascade_sub; %Information cascade
Transfer_sub_tbi_tp1=Transfer_sub; %Information transfer
Turbulence_RSN_sub_tbi_tp1_lam6=squeeze(TurbulenceRSN_sub(8,:,:));  % Turbulence by RSN at lambda 6
Turbulence_RSN_sub_tbi_tp1_lam3=squeeze(TurbulenceRSN_sub(9,:,:)); % Turbulence by RSN at lambda 3
clearvars -except Turbulence_global_sub_hc TransferLambda_sub_hc InformationCascade_sub_hc Transfer_sub_hc Turbulence_global_sub_tbi_tp1 TransferLambda_sub_tbi_tp1 InformationCascade_sub_tbi_tp1 Transfer_sub_tbi_tp1 Turbulence_RSN_sub_hc_lam6 Turbulence_RSN_sub_hc_lam3 Turbulence_RSN_sub_tbi_tp1_lam6 Turbulence_RSN_sub_tbi_tp1_lam3


load('turbu_all_measurements__openneuro_tbi_con2.mat') 
load('turbu_by_node_openneuro_tbi_con2.mat')
Turbulence_global_sub_tbi_tp2=Turbulence_global_sub; %Amplitude turbulence
TransferLambda_sub_tbi_tp2=TransferLambda_sub; %Information cascade flow
InformationCascade_sub_tbi_tp2=InformationCascade_sub; %Information cascade
Transfer_sub_tbi_tp2=Transfer_sub; %Information transfer
Turbulence_RSN_sub_tbi_tp2_lam6=squeeze(TurbulenceRSN_sub(8,:,:)); % Turbulence by RSN at lambda 6
Turbulence_RSN_sub_tbi_tp2_lam3=squeeze(TurbulenceRSN_sub(9,:,:)); % Turbulence by RSN at lambda 3
clearvars -except Turbulence_global_sub_hc TransferLambda_sub_hc InformationCascade_sub_hc Transfer_sub_hc Turbulence_global_sub_tbi_tp1 TransferLambda_sub_tbi_tp1 InformationCascade_sub_tbi_tp1 Transfer_sub_tbi_tp1 Turbulence_global_sub_tbi_tp2 TransferLambda_sub_tbi_tp2 InformationCascade_sub_tbi_tp2 Turbulence_RSN_sub_hc_lam6 Turbulence_RSN_sub_hc_lam3 Turbulence_RSN_sub_tbi_tp1_lam6 Turbulence_RSN_sub_tbi_tp1_lam3 Transfer_sub_tbi_tp2 Turbulence_RSN_sub_tbi_tp2_lam6 Turbulence_RSN_sub_tbi_tp2_lam3

load('turbu_all_measurements__openneuro_tbi_con3.mat') 
load('turbu_by_node_openneuro_tbi_con3.mat')
Turbulence_global_sub_tbi_tp3=Turbulence_global_sub; %Amplitude turbulence
TransferLambda_sub_tbi_tp3=TransferLambda_sub; %Information cascade flow
InformationCascade_sub_tbi_tp3=InformationCascade_sub; %Information cascade
Transfer_sub_tbi_tp3=Transfer_sub; %Information transfer
Turbulence_RSN_sub_tbi_tp3_lam6=squeeze(TurbulenceRSN_sub(8,:,:)); % Turbulence by RSN at lambda 6
Turbulence_RSN_sub_tbi_tp3_lam3=squeeze(TurbulenceRSN_sub(9,:,:)); % Turbulence by RSN at lambda 3
clearvars -except Turbulence_global_sub_hc TransferLambda_sub_hc InformationCascade_sub_hc Transfer_sub_hc Turbulence_global_sub_tbi_tp1 TransferLambda_sub_tbi_tp1 InformationCascade_sub_tbi_tp1 Transfer_sub_tbi_tp1 Turbulence_global_sub_tbi_tp2 TransferLambda_sub_tbi_tp2 InformationCascade_sub_tbi_tp2 Transfer_sub_tbi_tp2 Turbulence_global_sub_tbi_tp3 TransferLambda_sub_tbi_tp3 InformationCascade_sub_tbi_tp3 Transfer_sub_tbi_tp3 Turbulence_RSN_sub_hc_lam6 Turbulence_RSN_sub_hc_lam3 Turbulence_RSN_sub_tbi_tp1_lam6 Turbulence_RSN_sub_tbi_tp1_lam3 Transfer_sub_tbi_tp2 Turbulence_RSN_sub_tbi_tp2_lam6 Turbulence_RSN_sub_tbi_tp2_lam3 Turbulence_RSN_sub_tbi_tp3_lam6 Turbulence_RSN_sub_tbi_tp3_lam3


n=1;
for i=1:10 %lambdas
    Effect_turbu_hc_tbi_tp1=meanEffectSize(Turbulence_global_sub_hc(i,:),Turbulence_global_sub_tbi_tp1(i,:),Effect="cohen");
    Cohen_turbu_hc_tbi_tp1(n,1)=round(Effect_turbu_hc_tbi_tp1.Effect,6);
    Effect_turbu_hc_tbi_tp2=meanEffectSize(Turbulence_global_sub_hc(i,:),Turbulence_global_sub_tbi_tp2(i,:),Effect="cohen");
    Cohen_turbu_hc_tbi_tp2(n,1)=round(Effect_turbu_hc_tbi_tp2.Effect,6);
    Effect_turbu_hc_tbi_tp3=meanEffectSize(Turbulence_global_sub_hc(i,:),Turbulence_global_sub_tbi_tp3(i,:),Effect="cohen");
    Cohen_turbu_hc_tbi_tp3(n,1)=round(Effect_turbu_hc_tbi_tp3.Effect,6);
    
    if i==1
        Effect_flow_hc_tbi_tp1=meanEffectSize(TransferLambda_sub_hc(i+1,:), TransferLambda_sub_tbi_tp1(i+1,:), Effect="cohen");
        Cohen_flow_hc_tbi_tp1(n,1)=round(Effect_flow_hc_tbi_tp1.Effect,6);
        Effect_flow_hc_tbi_tp2=meanEffectSize(TransferLambda_sub_hc(i+1,:), TransferLambda_sub_tbi_tp2(i+1,:), Effect="cohen");
        Cohen_flow_hc_tbi_tp2(n,1)=round(Effect_flow_hc_tbi_tp2.Effect,6);
        Effect_flow_hc_tbi_tp3=meanEffectSize(TransferLambda_sub_hc(i+1,:), TransferLambda_sub_tbi_tp3(i+1,:), Effect="cohen");
        Cohen_flow_hc_tbi_tp3(n,1)=round(Effect_flow_hc_tbi_tp3.Effect,6);
    else
        Effect_flow_hc_tbi_tp1=meanEffectSize(TransferLambda_sub_hc(i,:), TransferLambda_sub_tbi_tp1(i,:), Effect="cohen");
        Cohen_flow_hc_tbi_tp1(n,1)=round(Effect_flow_hc_tbi_tp1.Effect,6);
        Effect_flow_hc_tbi_tp2=meanEffectSize(TransferLambda_sub_hc(i,:), TransferLambda_sub_tbi_tp2(i,:), Effect="cohen");
        Cohen_flow_hc_tbi_tp2(n,1)=round(Effect_flow_hc_tbi_tp2.Effect,6);
        Effect_flow_hc_tbi_tp3=meanEffectSize(TransferLambda_sub_hc(i,:), TransferLambda_sub_tbi_tp3(i,:), Effect="cohen");
        Cohen_flow_hc_tbi_tp3(n,1)=round(Effect_flow_hc_tbi_tp3.Effect,6);
    end
    
    Effect_transfer_hc_tbi_tp1=meanEffectSize(1-Transfer_sub_hc(i,:), 1-Transfer_sub_tbi_tp1(i,:), Effect="cohen");
    Cohen_transfer_hc_tbi_tp1(n,1)= round(Effect_transfer_hc_tbi_tp1.Effect,6);
    Effect_transfer_hc_tbi_tp2=meanEffectSize(1-Transfer_sub_hc(i,:), 1-Transfer_sub_tbi_tp2(i,:), Effect="cohen");
    Cohen_transfer_hc_tbi_tp2(n,1)= round(Effect_transfer_hc_tbi_tp2.Effect,6);
    Effect_transfer_hc_tbi_tp3=meanEffectSize(1-Transfer_sub_hc(i,:), 1-Transfer_sub_tbi_tp3(i,:), Effect="cohen");
    Cohen_transfer_hc_tbi_tp3(n,1)= round(Effect_transfer_hc_tbi_tp3.Effect,6);

    n=n+1;
end

Effect_cascade_hc_tbi_tp1=meanEffectSize(InformationCascade_sub_hc,InformationCascade_sub_tbi_tp1);
Cohen_cascade_hc_tbi_tp1=round(Effect_cascade_hc_tbi_tp1.Effect,6);
Effect_cascade_hc_tbi_tp2=meanEffectSize(InformationCascade_sub_hc,InformationCascade_sub_tbi_tp2);
Cohen_cascade_hc_tbi_tp2=round(Effect_cascade_hc_tbi_tp2.Effect,6);
Effect_cascade_hc_tbi_tp3=meanEffectSize(InformationCascade_sub_hc,InformationCascade_sub_tbi_tp3);
Cohen_cascade_hc_tbi_tp3=round(Effect_cascade_hc_tbi_tp3.Effect,6);

c=1;
for j=1:7 %RSNs
Effect_turbu_RSN_hc_tbi_tp2_lam6=meanEffectSize(Turbulence_RSN_sub_hc_lam6(:,j),Turbulence_RSN_sub_tbi_tp2_lam6(:,j), Effect="cohen");
Cohen_turbu_RSN_hc_tbi_tp2_lam6(c,1)=round(Effect_turbu_RSN_hc_tbi_tp2_lam6.Effect,6);
Effect_turbu_RSN_hc_tbi_tp2_lam3=meanEffectSize(Turbulence_RSN_sub_hc_lam3(:,j),Turbulence_RSN_sub_tbi_tp2_lam3(:,j), Effect="cohen");
Cohen_turbu_RSN_hc_tbi_tp2_lam3(c,1)=round(Effect_turbu_RSN_hc_tbi_tp2_lam3.Effect,6);
Effect_turbu_RSN_hc_tbi_tp3_lam6=meanEffectSize(Turbulence_RSN_sub_hc_lam6(:,j),Turbulence_RSN_sub_tbi_tp3_lam6(:,j), Effect="cohen");
Cohen_turbu_RSN_hc_tbi_tp3_lam6(c,1)=round(Effect_turbu_RSN_hc_tbi_tp3_lam6.Effect,6);
Effect_turbu_RSN_hc_tbi_tp3_lam3=meanEffectSize(Turbulence_RSN_sub_hc_lam3(:,j),Turbulence_RSN_sub_tbi_tp3_lam3(:,j), Effect="cohen");
Cohen_turbu_RSN_hc_tbi_tp3_lam3(c,1)=round(Effect_turbu_RSN_hc_tbi_tp3_lam3.Effect,6);
c=c+1;
end


cd ('/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/')
save ('Cohen_turbu_all_measurements_openneuro.mat', 'Cohen_flow_hc_tbi_tp1','Cohen_flow_hc_tbi_tp2','Cohen_flow_hc_tbi_tp3', 'Cohen_turbu_hc_tbi_tp1', 'Cohen_turbu_hc_tbi_tp2', 'Cohen_turbu_hc_tbi_tp3','Cohen_transfer_hc_tbi_tp1','Cohen_transfer_hc_tbi_tp2','Cohen_transfer_hc_tbi_tp3','Cohen_cascade_hc_tbi_tp1','Cohen_cascade_hc_tbi_tp2','Cohen_cascade_hc_tbi_tp3','Cohen_turbu_RSN_hc_tbi_tp2_lam6', 'Cohen_turbu_RSN_hc_tbi_tp2_lam3', 'Cohen_turbu_RSN_hc_tbi_tp3_lam6', 'Cohen_turbu_RSN_hc_tbi_tp3_lam3')
