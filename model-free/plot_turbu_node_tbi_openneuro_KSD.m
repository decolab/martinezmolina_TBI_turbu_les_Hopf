clear;
close all;
cd ('/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/')
hc_con1=load('turbu_by_node_openneuro_controls_con1.mat');
tbi_con1=load('turbu_by_node_openneuro_tbi_con1.mat');
tbi_con2=load('turbu_by_node_openneuro_tbi_con2.mat');
tbi_con3=load('turbu_by_node_openneuro_tbi_con3.mat');
%Yeo (Yeo et al. 2011) 7 RSNs:
% RSN 1, visual
% RSN 2, somatomotor
% RSN 3, dorsatt
% RSN 4, salventatt
% RSN 5, limbic
% RSN 6, control
% RSN 7, DMN
load ('RSN7vector.mat');  
RSN_labels= Yeo7vector';
RSN_names=({'VIS','SM','DAT','VAT','LIM','CNT','DMN'});
addpath('/Volumes/LASA/TBI_project/Shared_code/Turbulence/TBI_turbulence_current_code/helper functions')

LAMBDA=[0.27 0.24 0.21 0.18 0.15 0.12 0.09 0.06 0.03 0.01];

cd('figures/')
%% Compute Kolmogorov-Smirnov distance
% HC vs TBI 3-months
figure
t=tiledlayout(4,3);
for ilambda=1:length(LAMBDA)
    turbu_hc_con1=hc_con1.Turbulence_node_sub(ilambda,:);
    turbu_tbi_con1=tbi_con1.Turbulence_node_sub(ilambda,:);
    %visualization
    nexttile
    h1=histogram(turbu_hc_con1);
    set(h1,'FaceColor', 'b','facealpha',0.4);
    hold on
    h2=histogram(turbu_tbi_con1);
    set(h2,'FaceColor','g','facealpha',0.4);  
    title(['lambda' num2str(LAMBDA(ilambda))])

    %stats
    [hh pp_hc_tbicon1(ilambda) KSD_hc_tbicon1(ilambda,1)]=kstest2(turbu_hc_con1,turbu_tbi_con1);  %% FCD fitting 
end
title(t,'Turbu node distribution HCs vs TBI 3-months')
print('turbu node hist HC vs TBI 3-months','-dpng')
saveas(gcf,'turbu node hist HC vs TBI 3-months','fig')

%visualization for figure in ms
figure
bar([10:-1:1],KSD_hc_tbicon1,'b')
title('KSD HCs vs TBI 3-months')
xticklabels({'0.01','0.03','0.06','0.09','0.12','0.15','0.18','0.21','0.24','0.27'})
print('turbu node KSD HC vs TBI 3-months','-dpng')
saveas(gcf,'turbu node KSD HC vs TBI 3-months','fig')

% HC vs TBI 6-months
figure
t=tiledlayout(4,3);
for ilambda=1:length(LAMBDA)
    turbu_hc_con1=hc_con1.Turbulence_node_sub(ilambda,:);
    turbu_tbi_con2=tbi_con2.Turbulence_node_sub(ilambda,:);
    %visualization
    nexttile
    h1=histogram(turbu_hc_con1);
    set(h1,'FaceColor', 'b','facealpha',0.4);
    hold on
    h2=histogram(turbu_tbi_con2);
    set(h2,'FaceColor','g','facealpha',0.4);  
    title(['lambda' num2str(LAMBDA(ilambda))])

    %stats
    [hh pp_hc_tbicon2(ilambda) KSD_hc_tbicon2(ilambda,1)]=kstest2(turbu_hc_con1,turbu_tbi_con2);  %% FCD fitting 
end
title(t,'Turbu node distribution HCs vs TBI 6-months')
print('turbu node hist HC vs TBI 6-months','-dpng')
saveas(gcf,'turbu node hist HC vs TBI 6-months','fig')

%visualization for figure in ms
figure
bar([10:-1:1],KSD_hc_tbicon2,'b')
title('KSD HCs vs TBI 6-months')
xticklabels({'0.01','0.03','0.06','0.09','0.12','0.15','0.18','0.21','0.24','0.27'})
print('turbu node KSD HC vs TBI 6-months','-dpng')
saveas(gcf,'turbu node KSD HC vs TBI 6-months','fig')

% HC vs TBI 12-months
figure
t=tiledlayout(4,3);
for ilambda=1:length(LAMBDA)
    turbu_hc_con1=hc_con1.Turbulence_node_sub(ilambda,:);
    turbu_tbi_con3=tbi_con3.Turbulence_node_sub(ilambda,:);
    %visualization
    nexttile
    h1=histogram(turbu_hc_con1);
    set(h1,'FaceColor', 'b','facealpha',0.4);
    hold on
    h2=histogram(turbu_tbi_con3);
    set(h2,'FaceColor','g','facealpha',0.4);  
    title(['lambda' num2str(LAMBDA(ilambda))])

    %stats
    [hh pp_hc_tbicon3(ilambda) KSD_hc_tbicon3(ilambda,1)]=kstest2(turbu_hc_con1,turbu_tbi_con3);  %% FCD fitting 
end
title(t,'Turbu node distribution HCs vs TBI 12-months')
print('turbu node hist HC vs TBI 12-months','-dpng')
saveas(gcf,'turbu node hist HC vs TBI 12-months','fig')

%visualization for figure in ms
figure
bar([10:-1:1],KSD_hc_tbicon3,'b')
title('KSD HCs vs TBI 12-months')
xticklabels({'0.01','0.03','0.06','0.09','0.12','0.15','0.18','0.21','0.24','0.27'})
print('turbu node KSD HC vs TBI 12-months','-dpng')
saveas(gcf,'turbu node KSD HC vs TBI 12-months','fig')

cd ..
save('pp_KSD_openneuro.mat','pp_hc_tbicon1','pp_hc_tbicon2','pp_hc_tbicon3','KSD_hc_tbicon1','KSD_hc_tbicon2','KSD_hc_tbicon3')
