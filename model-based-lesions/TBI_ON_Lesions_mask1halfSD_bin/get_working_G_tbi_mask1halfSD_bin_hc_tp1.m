
clear all
close all
addpath('/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/Hopf_model/TBI_homogeneous/outputs/Grange/HC/');
addpath('/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/Hopf_model/TBI_ON_Lesions_Hopf_mask1halfSD_bin_corr/outputs/Grange/');
addpath('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Hopf_TBI_ON/')
addpath('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Hopf_TBI_ON/helper_functions/')
addpath('/Volumes/LASA/TBI_OpenNeuro/Shared_code/TBI_ON_Lesions_Hopf_mask1halfSD_bin/');
outdir_TBI='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/Hopf_model/TBI_ON_Lesions_Hopf_mask1halfSD_bin_corr/outputs/Grange/optG/';

G=100;
G_range=0.:0.01:3;

cond=1;
cond_hc=load_condition_hc_tp1(G,cond);
[minerrhete_hc,ioptG_hc]=min(mean(cond_hc.err_hete_range,2));
optG_hc=G_range(ioptG_hc);

for cond=1:3
    if cond==1
        tbi_cond1=load_condition_tbi_mask1halfSD_bin(G,cond);
    elseif cond==2
        tbi_cond2=load_condition_tbi_mask1halfSD_bin(G,cond);
    else
        tbi_cond3=load_condition_tbi_mask1halfSD_bin(G,cond);
    end
end

[minerrhete_tbi_cond1,ioptG_tbicond1]=min(mean(tbi_cond1.err_hete_range,2));
[minerrhete_tbi_cond2,ioptG_tbicond2]=min(mean(tbi_cond2.err_hete_range,2));
[minerrhete_tbi_cond3,ioptG_tbicond3]=min(mean(tbi_cond3.err_hete_range,2));
optG_tbicond1=G_range(ioptG_tbicond1);
optG_tbicond2=G_range(ioptG_tbicond2);
optG_tbicond3=G_range(ioptG_tbicond3);

cd (outdir_TBI)
save('optG_tbi_mask1halfSD_bin.mat','optG_tbicond1', 'optG_tbicond2','optG_tbicond3')

% Plot selected G range for comparative purposes
x=G_range(1:51)';
figure;
shadedErrorBar(x, cond_hc.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color',[0.7 0.7 0.7],'markerfacecolor',[0.7 0.7 0.7]}); %grey
hold on
shadedErrorBar(x, tbi_cond1.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color',[0.4940 0.1840 0.5560],'markerfacecolor',[0.4940 0.1840 0.5560]}); %purple
shadedErrorBar(x, tbi_cond2.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color',[0.8500 0.3250 0.0980],'markerfacecolor',[0.8500 0.3250 0.0980]}); %orange
shadedErrorBar(x, tbi_cond3.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color',[0 0.4470 0.7410],'markerfacecolor',[0 0.4470 0.7410]}); %blue
ylabel('Fitting');xlabel('Global coupling G')
xline(optG_hc, 'Color',[0.7 0.7 0.7], 'LineWidth',1.5)
xline(optG_tbicond1, 'Color',[0.4940 0.1840 0.5560], 'LineWidth',1.5)
xline(optG_tbicond2, 'Color',[0.8500 0.3250 0.0980], 'LineWidth',1.5)
xline(optG_tbicond3, 'Color',[0 0.4470 0.7410], 'LineWidth',1.5)
legend({'hc','tbi-3mo', 'tbi-6mo', 'tbi-12mo'}, 'Location','northeastoutside')
xticks([0 0.1 0.2 0.3 0.4 0.5])


print('Global coupling Fitting Open Neuro HC TP1 TBI TP123 (N=24)','-dpng')
saveas(gcf,'Global coupling Fitting Open Neuro HC TP1 TBI TP123 (N=24)','fig')