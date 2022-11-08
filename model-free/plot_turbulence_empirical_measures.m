%% Plot Turbulence Empirical RSN filt (0.08-0.008)
% Plots results from the empirical analysis: turbulence, information cascade flow, information cascade and information transfer obtained in turbulence_empirical_measures.m
% TBI dataset from OpenNeuro: <https://openneuro.org/datasets/ds000220/versions/1.0.0/file-display/dataset_description.json 
% https://openneuro.org/datasets/ds000220/versions/1.0.0/file-display/dataset_description.json>

%% Load results
clear all
data_path='/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/';
output_path='/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/figures/';
addpath '/Volumes/LASA/TBI_project/Shared_code/Turbulence/TBI_turbulence_current_code/helper functions/';
lambda={'0.27','0.24','0.21','0.18','0.15','0.12','0.09','0.06','0.03','0.01'};
LAMBDA=[0.27 0.24 0.21 0.18 0.15 0.12 0.09 0.06 0.03 0.01];
cond = {'tbi-3mo','tbi-6mo','tbi-12mo','hc-ses1'};
cd(data_path)
results_hc_s1 = load(sprintf('turbu_all_measurements__openneuro_controls_con1.mat'));
results_tbi_s1 = load(sprintf('turbu_all_measurements__openneuro_tbi_con1.mat'));
results_tbi_s2 = load(sprintf('turbu_all_measurements__openneuro_tbi_con2.mat'));
results_tbi_s3 = load(sprintf('turbu_all_measurements__openneuro_tbi_con3.mat'));

Turbu_hc_s1 = results_hc_s1.Turbulence_global_sub;
Turbu_tbi_s1 = results_tbi_s1.Turbulence_global_sub;
Turbu_tbi_s2 = results_tbi_s2.Turbulence_global_sub;
Turbu_tbi_s3 = results_tbi_s3.Turbulence_global_sub;

Turbu_RSN_hc_s1 = results_hc_s1.TurbulenceRSN_sub;
Turbu_RSN_tbi_s1 = results_tbi_s1.TurbulenceRSN_sub;
Turbu_RSN_tbi_s2 = results_tbi_s2.TurbulenceRSN_sub;
Turbu_RSN_tbi_s3 = results_tbi_s3.TurbulenceRSN_sub;

Info_flow_hc_s1 = results_hc_s1.TransferLambda_sub;
Info_flow_tbi_s1 = results_tbi_s1.TransferLambda_sub;
Info_flow_tbi_s2 = results_tbi_s2.TransferLambda_sub;
Info_flow_tbi_s3 = results_tbi_s3.TransferLambda_sub;

Info_cascade_hc_s1 = results_hc_s1.InformationCascade_sub;
Info_cascade_tbi_s1 = results_tbi_s1.InformationCascade_sub;
Info_cascade_tbi_s2 = results_tbi_s2.InformationCascade_sub;
Info_cascade_tbi_s3 = results_tbi_s3.InformationCascade_sub;

Info_transfer_hc_s1 = results_hc_s1.Transfer_sub;
Info_transfer_tbi_s1 = results_tbi_s1.Transfer_sub;
Info_transfer_tbi_s2 = results_tbi_s2.Transfer_sub;
Info_transfer_tbi_s3 = results_tbi_s3.Transfer_sub;

cd(output_path)

%% Plot global Turbulence 3 Timepoints

figure
for lamb=1:length(lambda)
    subplot(2,5,lamb)
    C = {Turbu_tbi_s1(lamb,:), Turbu_tbi_s2(lamb,:), Turbu_tbi_s3(lamb,:),Turbu_hc_s1(lamb,:)};    
    maxNumEl = max(cellfun(@numel,C));
    Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
    Cmat = cell2mat(Cpad);
    boxplot(Cmat,'Labels',cond)
    title(lambda{lamb})
    
%     [~,pval] = ttest(Turbu_c1_BA(lamb,:),Turbu_c2_BA(lamb,:)); % paired t Test
%     p(1,lamb)=pval; clear pval
%     H=sigstar({[1,2]},p(1,lamb));
end
print('Turbulence Global TBI Open Neuro TP123 (N=24) filt','-dpng')
saveas(gcf,'Turbulence Global TBI Open Neuro TP123 (N=24) filt','fig')
close()

%% Plot turbulence by RSN

Rsns = {'visual', 'somatomotor','dorsatt','salventatt','limbic','control','DMN'};
for lamb=1:length(lambda)
    figure
    sgtitle (['Lambda' char(lambda(lamb))])
    for jj=1:7 %Loop for networks
        subplot(2,4,jj)
        C = {Turbu_RSN_tbi_s1(lamb,:,jj),Turbu_RSN_tbi_s2(lamb,:,jj),Turbu_RSN_tbi_s3(lamb,:,jj),Turbu_RSN_hc_s1(lamb,:,jj)};
        maxNumEl = max(cellfun(@numel,C));
        Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
        Cmat = cell2mat(Cpad);
        boxplot(Cmat,'Labels',cond)
        title(Rsns{jj})
%         
%         [~,pval] = ttest(Turbu_RSN_c1_BA(lamb,:,jj),Turbu_RSN_c2_BA(lamb,:,jj)); % paired t Test
%         p(1,jj)=pval; clear pval
%         H=sigstar({[1,2]},p(1,jj));
    end
    print(['Turbulence RSN TBI Open Neuro TP123 (N=24) filt lambda' num2str(lamb)],'-dpng')
    saveas(gcf,['Turbulence RSN TBI Open Neuro TP123 (N=24) filt lambda' num2str(lamb)],'fig')
end
close()

%% Plot information cascade flow

%RGB color coding in matlab
figure;
shadedErrorBar(LAMBDA(2:length(LAMBDA)),Info_flow_tbi_s1(2:length(LAMBDA),:)',{@median,@std},'lineprops',{'k-o','color',[0.4940 0.1840 0.5560],'markerfacecolor',[0.4940 0.1840 0.5560]});
hold on 
shadedErrorBar(LAMBDA(2:length(LAMBDA)),Info_flow_tbi_s2(2:length(LAMBDA),:)',{@median,@std},'lineprops',{'k-o','color',[0.8500 0.3250 0.0980],'markerfacecolor',[0.8500 0.3250 0.0980]});
shadedErrorBar(LAMBDA(2:length(LAMBDA)),Info_flow_tbi_s3(2:length(LAMBDA),:)',{@median,@std},'lineprops',{'k-o','color',[0 0.4470 0.7410],'markerfacecolor',[0 0.4470 0.7410]});
shadedErrorBar(LAMBDA(2:length(LAMBDA)),Info_flow_hc_s1(2:length(LAMBDA),:)',{@median,@std},'lineprops',{'k-o','color',[0.7 0.7 0.7],'markerfacecolor',[0.7 0.7 0.7]});
ylabel('Information Cascade Flow');xlabel('Spatial scale (\lambda)')
legend(cond)
print('Info Flow TBI Open Neuro TP123 (N=24) RGB color filt','-dpng')
saveas(gcf,'Info Flow Open Neuro TP123 (N=24) RGB color filt','fig')
close()

%% Plot information cascade

figure
C = {Info_cascade_tbi_s1,Info_cascade_tbi_s2,Info_cascade_tbi_s3,Info_cascade_hc_s1};
maxNumEl = max(cellfun(@numel,C));
Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
Cmat = cell2mat(Cpad);
boxplot(Cmat,'Labels',cond)
title('Information cascade')

%[~,pval] = ttest(Info_cascade_c1_BA,Info_cascade_c2_BA); % paired t Test
%H=sigstar({[1,2]},pval);
print('Info Cascade TBI Open Neuro TP123 (N=24)filt lambda','-dpng')
saveas(gcf,'Info Cascade TBI Open Neuro TP123 (N=24) filt lambda','fig')
close()

%% Plot information transfer

figure
for lamb=1:length(lambda)
    subplot(2,5,lamb)
    C = {1.-Info_transfer_tbi_s1(lamb,:),1.-Info_transfer_tbi_s2(lamb,:), 1.-Info_transfer_tbi_s3(lamb,:),1.-Info_transfer_hc_s1(lamb,:)};    
    maxNumEl = max(cellfun(@numel,C));
    Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
    Cmat = cell2mat(Cpad);
    boxplot(Cmat,'Labels',cond)
    title(lambda{lamb})
    
    %[~,pval] = ttest(Info_transfer_c1_BA(lamb,:),Info_transfer_c2_BA(lamb,:)); % paired t Test
    %p(1,lamb)=pval; clear pval
    %H=sigstar({[1,2]},p(1,lamb));
end
print('Info Transfer TBI Open Neuro TP123 (N=24)filt lambda','-dpng')
saveas(gcf,'Info Transfer TBI Open Neuro TP123 (N=24)filt lambda','fig')
close()
