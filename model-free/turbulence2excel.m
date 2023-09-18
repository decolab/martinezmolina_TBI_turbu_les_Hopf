clear () ; close ()
data_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/';
data_path_rev='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/outputs/Turbulence_20_06_2023/';

% Data from controls 

cd(data_path)
load('turbu_all_measurements_openneuro_controls_con1.mat')
Turbulence_global_hc1=Turbulence_global_sub;
TransferLambda_hc1=TransferLambda_sub;
InformationCascade_hc1=InformationCascade_sub;
Transfer_hc1=Transfer_sub;
cd(data_path_rev)
load('turbu_all_measurements_openneuro_controls_tp2.mat')
Turbulence_global_hc2=Turbulence_global_sub;
TransferLambda_hc2=TransferLambda_sub;
InformationCascade_hc2=InformationCascade_sub;
Transfer_hc2=Transfer_sub;

clearvars -except Turbulence_global_hc1 Turbulence_global_hc2 TransferLambda_hc1 TransferLambda_hc2 InformationCascade_hc1 InformationCascade_hc2 Transfer_hc1 Transfer_hc2 data_path data_path_rev

% Mean from controls
for lam=1:10
    for sub=1:12
        Turbulence_global_hc_mean(lam,sub)= mean ([Turbulence_global_hc1(lam,sub) Turbulence_global_hc2(lam,sub)]);
        TransferLambda_hc_mean(lam,sub)=mean ([TransferLambda_hc1(lam,sub) TransferLambda_hc2(lam,sub)]);
        Transfer_hc_mean(lam,sub)=mean ([Transfer_hc1(lam,sub) Transfer_hc2(lam,sub)]);
    end
end

for sub=1:12
    InformationCascade_hc_mean(1,sub)=mean([InformationCascade_hc1(1,sub) InformationCascade_hc2(1,sub)]);
end

Turbulence_global_hc1=table(Turbulence_global_hc1);
TransferLambda_hc1=table(TransferLambda_hc1);
InformationCascade_hc1=table(InformationCascade_hc1);
Transfer_hc1=table(Transfer_hc1);
Turbulence_global_hc2=table(Turbulence_global_hc2);
TransferLambda_hc2=table(TransferLambda_hc2);
InformationCascade_hc2=table(InformationCascade_hc2);
Transfer_hc2=table(Transfer_hc2);
Turbulence_global_hc_mean=table(Turbulence_global_hc_mean);
TransferLambda_hc_mean=table(TransferLambda_hc_mean);
InformationCascade_hc_mean=table(InformationCascade_hc_mean);
Transfer_hc_mean=table(Transfer_hc_mean);

cd(fullfile(data_path,'excel'))
writetable(Turbulence_global_hc1, 'Turbulence_global_sub_controls_con1.xlsx')
writetable(TransferLambda_hc1, 'InfoCascadeFlow_sub_controls_con1.xlsx')
writetable(InformationCascade_hc1, 'InformationCascade_sub_controls_con1.xlsx')
writetable(Transfer_hc1, 'Transfer_sub_controls_con1.xlsx')
writetable(Turbulence_global_hc2, 'Turbulence_global_sub_controls_con2.xlsx')
writetable(TransferLambda_hc2, 'InfoCascadeFlow_sub_controls_con2.xlsx')
writetable(InformationCascade_hc2, 'InformationCascade_sub_controls_con2.xlsx')
writetable(Transfer_hc_mean, 'Transfer_sub_controls_con2.xlsx')
writetable(Turbulence_global_hc_mean, 'Turbulence_global_sub_controls_mean.xlsx')
writetable(TransferLambda_hc_mean, 'InfoCascadeFlow_sub_controls_mean.xlsx')
writetable(InformationCascade_hc_mean, 'InformationCascade_sub_controls_mean.xlsx')
writetable(Transfer_hc_mean, 'Transfer_sub_controls_mean.xlsx')

clearvars -except data_path data_path_rev

% Data from TBI patients T1-T3

cd(data_path)
load('turbu_all_measurements_openneuro_tbi_con1.mat')
Turbulence_global_sub_tbi_con1=table(Turbulence_global_sub);
TransferLambda_sub_tbi_con1=table(TransferLambda_sub);
InformationCascade_sub_tbi_con1=table(InformationCascade_sub);
Transfer_sub_tbi_con1=table(Transfer_sub);

cd(fullfile(data_path,'excel'))
writetable(Turbulence_global_sub_tbi_con1, 'Turbulence_global_sub_tbi_con1.xlsx')
writetable(TransferLambda_sub_tbi_con1, 'InfoCascadeFlow_sub_tbi_con1.xlsx')
writetable(InformationCascade_sub_tbi_con1, 'InformationCascade_sub_tbi_con1.xlsx')
writetable(Transfer_sub_tbi_con1, 'Transfer_sub_tbi_con1.xlsx')

clearvars -except data_path 

cd(data_path)
load('turbu_all_measurements_openneuro_tbi_con2.mat')
Turbulence_global_sub_tbi_con2=table(Turbulence_global_sub);
TransferLambda_sub_tbi_con2=table(TransferLambda_sub);
InformationCascade_sub_tbi_con2=table(InformationCascade_sub);
Transfer_sub_tbi_con2=table(Transfer_sub);

cd(fullfile(data_path,'excel'))
writetable(Turbulence_global_sub_tbi_con2, 'Turbulence_global_sub_tbi_con2.xlsx')
writetable(TransferLambda_sub_tbi_con2, 'InfoCascadeFlow_sub_tbi_con2.xlsx')
writetable(InformationCascade_sub_tbi_con2, 'InformationCascade_sub_tbi_con2.xlsx')
writetable(Transfer_sub_tbi_con2, 'Transfer_sub_tbi_con2.xlsx')

clearvars -except data_path 

cd(data_path)
load('turbu_all_measurements_openneuro_tbi_con3.mat')
Turbulence_global_sub_tbi_con3=table(Turbulence_global_sub);
TransferLambda_sub_tbi_con3=table(TransferLambda_sub);
InformationCascade_sub_tbi_con3=table(InformationCascade_sub);
Transfer_sub_tbi_con3=table(Transfer_sub);

cd(fullfile(data_path,'excel'))
writetable(Turbulence_global_sub_tbi_con3, 'Turbulence_global_sub_tbi_con3.xlsx')
writetable(TransferLambda_sub_tbi_con3, 'InfoCascadeFlow_sub_tbi_con3.xlsx')
writetable(InformationCascade_sub_tbi_con3, 'InformationCascade_sub_tbi_con3.xlsx')
writetable(Transfer_sub_tbi_con3, 'Transfer_sub_tbi_con3.xlsx')

clearvars -except data_path 