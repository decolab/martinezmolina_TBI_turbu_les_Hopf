
clear all;
addpath('/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/Hopf_model/TBI_ON_Lesions_Hopf_mask1halfSD_bin_corr/outputs/Grange/');
addpath('/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/Hopf_model/TBI_ON_Lesions_Hopf_mask1halfSD_weight_corr/outputs/Grange/');
addpath('/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/Hopf_model/TBI_homogeneous/outputs/Grange/TBI/');
addpath(genpath('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/Fig5/'))

G=100;
G_range=0.:0.01:3;

path_hc_tp1='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/Hopf_model/TBI_homogeneous/outputs/Grange/HC';
path_hc_tp2='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/Hopf_model/TBI_ON_Hopf_hc_tp2/outputs/Grange/';
cd(path_hc_tp1)
cond_hc_tp1=load_condition_hc_tp1(G,1);
[minerrhete_hc_tp1,ioptG_hc_tp1]=min(mean(cond_hc_tp1.err_hete_range,2));
optG_hc_tp1=G_range(ioptG_hc_tp1);
cd(path_hc_tp2)
cond_hc_tp2=load_condition_hc_tp2(G,1);
[minerrhete_hc_tp2,ioptG_hc_tp2]=min(mean(cond_hc_tp2.err_hete_range,2));
optG_hc_tp2=G_range(ioptG_hc_tp2);

% TBI NO LESION
for cond=1:3
    if cond==1
        tbi_cond1=load_condition_tbi(G,cond);
    elseif cond==2
        tbi_cond2=load_condition_tbi(G,cond);
    else
        tbi_cond3=load_condition_tbi(G,cond);
    end
end

[minerrhete_tbi_cond1,ioptG_tbicond1]=min(mean(tbi_cond1.err_hete_range,2));
[minerrhete_tbi_cond2,ioptG_tbicond2]=min(mean(tbi_cond2.err_hete_range,2));
[minerrhete_tbi_cond3,ioptG_tbicond3]=min(mean(tbi_cond3.err_hete_range,2));
optG_tbicond1=G_range(ioptG_tbicond1);
optG_tbicond2=G_range(ioptG_tbicond2);
optG_tbicond3=G_range(ioptG_tbicond3);

% TBI LESION 1.5SD BIN

for cond=1:3
    if cond==1
        tbi_cond1_les1SDbin=load_condition_tbi_mask1halfSD_bin(G,cond);
    elseif cond==2
        tbi_cond2_les1SDbin=load_condition_tbi_mask1halfSD_bin(G,cond);
    else
        tbi_cond3_les1SDbin=load_condition_tbi_mask1halfSD_bin(G,cond);
    end
end

[minerrhete_tbi_cond1_les1SDbin,ioptG_tbicond1_les1SDbin]=min(mean(tbi_cond1_les1SDbin.err_hete_range,2));
[minerrhete_tbi_cond2_les1SDbin,ioptG_tbicond2_les1SDbin]=min(mean(tbi_cond2_les1SDbin.err_hete_range,2));
[minerrhete_tbi_cond3_les1SDbin,ioptG_tbicond3_les1SDbin]=min(mean(tbi_cond3_les1SDbin.err_hete_range,2));
optG_tbicond1_les1SDbin=G_range(ioptG_tbicond1_les1SDbin);
optG_tbicond2_les1SDbin=G_range(ioptG_tbicond2_les1SDbin);
optG_tbicond3_les1SDbin=G_range(ioptG_tbicond3_les1SDbin);

% TBI LESION 1.5SD WEIGHT
G=96;
for cond=1:3
    if cond==1
        tbi_cond1_les1SDweight=load_condition_tbi_mask1halfSD_weight(G,cond);
    elseif cond==2
        tbi_cond2_les1SDweight=load_condition_tbi_mask1halfSD_weight(G,cond);
    else
        tbi_cond3_les1SDweight=load_condition_tbi_mask1halfSD_weight(G,cond);
    end
end

[minerrhete_tbi_cond1_les1SDweight,ioptG_tbicond1_les1SDweight]=min(mean(tbi_cond1_les1SDweight.err_hete_range,2));
[minerrhete_tbi_cond2_les1SDweight,ioptG_tbicond2_les1SDweight]=min(mean(tbi_cond2_les1SDweight.err_hete_range,2));
[minerrhete_tbi_cond3_les1SDweight,ioptG_tbicond3_les1SDweight]=min(mean(tbi_cond3_les1SDweight.err_hete_range,2));
optG_tbicond1_les1SDweight=G_range(ioptG_tbicond1_les1SDweight);
optG_tbicond2_les1SDweight=G_range(ioptG_tbicond2_les1SDweight);
optG_tbicond3_les1SDweight=G_range(ioptG_tbicond3_les1SDweight);

% Plot selected G range for comparative purposes
% Hexadecimal colors generated with a viridis generator for 11 categories

%% ALL TOGETHER
x=G_range(1:51)';
figure;
shadedErrorBar(x, cond_hc_tp1.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#440154','markerfacecolor','#440154'});
hold on
shadedErrorBar(x, cond_hc_tp2.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#482475','markerfacecolor','#482475'});
shadedErrorBar(x, tbi_cond1.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#414487','markerfacecolor','#414487'});
shadedErrorBar(x, tbi_cond2.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#355f8d','markerfacecolor','#355f8d'}); 
shadedErrorBar(x, tbi_cond3.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#2a788e','markerfacecolor','#2a788e'}); 
shadedErrorBar(x, tbi_cond1_les1SDbin.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#21918c','markerfacecolor','#21918c'}); 
shadedErrorBar(x, tbi_cond2_les1SDbin.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#22a884','markerfacecolor','#22a884'});
shadedErrorBar(x, tbi_cond3_les1SDbin.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#44bf70','markerfacecolor','#44bf70'}); 
shadedErrorBar(x, tbi_cond1_les1SDweight.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#7ad151','markerfacecolor','#7ad151'});
shadedErrorBar(x, tbi_cond2_les1SDweight.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#bddf26','markerfacecolor','#bddf26'}); 
shadedErrorBar(x, tbi_cond3_les1SDweight.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#fde725','markerfacecolor','#fde725'}); 
ylabel('Fitting');xlabel('Global coupling G')
xline(optG_hc_tp1, 'Color','#440154', 'LineWidth',1.5)
xline(optG_hc_tp2, 'Color','#482475', 'LineWidth',1.5)
xline(optG_tbicond1, 'Color','#414487', 'LineWidth',1.5)
xline(optG_tbicond2, 'Color','#355f8d', 'LineWidth',1.5)
xline(optG_tbicond3, 'Color','#2a788e', 'LineWidth',1.5)
xline(optG_tbicond1_les1SDbin, 'Color','#21918c', 'LineWidth',1.5)
xline(optG_tbicond2_les1SDbin, 'Color','#22a884', 'LineWidth',1.5)
xline(optG_tbicond3_les1SDbin, 'Color','#44bf70', 'LineWidth',1.5)
xline(optG_tbicond1_les1SDweight, 'Color','#7ad151', 'LineWidth',1.5)
xline(optG_tbicond2_les1SDweight, 'Color','#bddf26', 'LineWidth',1.5)
xline(optG_tbicond3_les1SDweight, 'Color','#fde725', 'LineWidth',1.5)
legend({'hc ses 1','hc ses 2','tbi-3mo', 'tbi-6mo', 'tbi-12mo','tbi-3mo_les1.5SDbin', 'tbi-6mo_les1.5SDbin', 'tbi-12mo_les1.5SDbin','tbi-3mo_les1.5SDweight', 'tbi-6mo_les1.5SDweight', 'tbi-12mo_les1.5SDweight'}, 'Location','northeastoutside')
xticks([0 0.1 0.2 0.3 0.4 0.5])

print('Global coupling Fitting Open Neuro HC TBI Lesion Effect 1andhalf SD (N=24)','-dpng')
saveas(gcf,'Global coupling Fitting Open Neuro HC TBI Lesion Effect 1andhalf SD (N=24)','fig')

%% HC TBI NO LES
x=G_range(1:51)';
figure;
shadedErrorBar(x, cond_hc_tp1.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#440154','markerfacecolor','#440154'});
hold on
shadedErrorBar(x, cond_hc_tp2.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#482475','markerfacecolor','#482475'});
shadedErrorBar(x, tbi_cond1.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#414487','markerfacecolor','#414487'});
shadedErrorBar(x, tbi_cond2.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#355f8d','markerfacecolor','#355f8d'}); 
shadedErrorBar(x, tbi_cond3.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#2a788e','markerfacecolor','#2a788e'}); 
ylabel('Fitting');xlabel('Global coupling G')
xline(optG_hc_tp1, 'Color','#440154', 'LineWidth',1.5)
xline(optG_hc_tp2, 'Color','#482475', 'LineWidth',1.5)
xline(optG_tbicond1, 'Color','#414487', 'LineWidth',1.5)
xline(optG_tbicond2, 'Color','#355f8d', 'LineWidth',1.5)
xline(optG_tbicond3, 'Color','#2a788e', 'LineWidth',1.5)
legend({'hc ses 1','hc ses 2','tbi-3mo', 'tbi-6mo', 'tbi-12mo'}, 'Location','northeastoutside')
xticks([0 0.1 0.2 0.3 0.4 0.5])

print('Global coupling Fitting Open Neuro HC TBI No Les (N=24)','-dpng')
saveas(gcf,'Global coupling Fitting Open Neuro HC TBI No Les (N=24)','fig')

%% HC TBI LES 1.5SD BIN
x=G_range(1:51)';
figure;
shadedErrorBar(x, cond_hc_tp1.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#440154','markerfacecolor','#440154'});
hold on
shadedErrorBar(x, cond_hc_tp2.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#482475','markerfacecolor','#482475'});
shadedErrorBar(x, tbi_cond1_les1SDbin.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#21918c','markerfacecolor','#21918c'}); 
shadedErrorBar(x, tbi_cond2_les1SDbin.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#22a884','markerfacecolor','#22a884'});
shadedErrorBar(x, tbi_cond3_les1SDbin.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#44bf70','markerfacecolor','#44bf70'});  
ylabel('Fitting');xlabel('Global coupling G')
xline(optG_hc_tp1, 'Color','#440154', 'LineWidth',1.5)
xline(optG_hc_tp2, 'Color','#482475', 'LineWidth',1.5)
xline(optG_tbicond1_les1SDbin, 'Color','#21918c', 'LineWidth',1.5)
xline(optG_tbicond2_les1SDbin, 'Color','#22a884', 'LineWidth',1.5)
xline(optG_tbicond3_les1SDbin, 'Color','#44bf70', 'LineWidth',1.5)
legend({'hc ses 1','hc ses 2','tbi-3mo_les1.5SDbin', 'tbi-6mo_les1.5SDbin', 'tbi-12mo_les1.5SDbin'}, 'Location','northeastoutside')
xticks([0 0.1 0.2 0.3 0.4 0.5])

print('Global coupling Fitting Open Neuro HC TBI Lesion 1andhalf SD BIN (N=24)','-dpng')
saveas(gcf,'Global coupling Fitting Open Neuro HC TBI Lesion 1andhalf SD BIN (N=24)','fig')

%% HC TBI LES 1.5SD WEIGHT
x=G_range(1:51)';
figure;
shadedErrorBar(x, cond_hc_tp1.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#440154','markerfacecolor','#440154'});
hold on
shadedErrorBar(x, cond_hc_tp2.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#482475','markerfacecolor','#482475'});
shadedErrorBar(x, tbi_cond1_les1SDweight.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#7ad151','markerfacecolor','#7ad151'});
shadedErrorBar(x, tbi_cond2_les1SDweight.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#bddf26','markerfacecolor','#bddf26'}); 
shadedErrorBar(x, tbi_cond3_les1SDweight.err_hete_range(1:51,:)',{@mean,@std},'lineprops',{'k-','color','#fde725','markerfacecolor','#fde725'}); 
ylabel('Fitting');xlabel('Global coupling G')
xline(optG_hc_tp1, 'Color','#440154', 'LineWidth',1.5)
xline(optG_hc_tp2, 'Color','#482475', 'LineWidth',1.5)
xline(optG_tbicond1_les1SDweight, 'Color','#7ad151', 'LineWidth',1.5)
xline(optG_tbicond2_les1SDweight, 'Color','#bddf26', 'LineWidth',1.5)
xline(optG_tbicond3_les1SDweight, 'Color','#fde725', 'LineWidth',1.5)

legend({'hc ses 1','hc ses 2','tbi-3mo_les1.5SDweight', 'tbi-6mo_les1.5SDweight', 'tbi-12mo_les1.5SDweight'}, 'Location','northeastoutside')
xticks([0 0.1 0.2 0.3 0.4 0.5])

print('Global coupling Fitting Open Neuro HC TBI Lesion 1andhalf SD WEIGHT (N=24)','-dpng')
saveas(gcf,'Global coupling Fitting Open Neuro HC TBI Lesion 1andhalf SD WEIGHT (N=24)','fig')