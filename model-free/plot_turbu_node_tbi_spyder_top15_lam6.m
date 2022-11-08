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

%% Visualization for lambda = 0.06

%Compute mean differences
turbu_node_hc_con1=nanmean(hc_con1.Turbulence_node_sub(8,:,:),3);
turbu_node_tbi_con1=nanmean(tbi_con1.Turbulence_node_sub(8,:,:),3);
turbu_node_tbi_con2=nanmean(tbi_con2.Turbulence_node_sub(8,:,:),3);
turbu_node_tbi_con3=nanmean(tbi_con3.Turbulence_node_sub(8,:,:),3);

diff_hc_tbi_con1 =abs(turbu_node_hc_con1-turbu_node_tbi_con1);
diff_hc_tbi_con2 =abs(turbu_node_hc_con1-turbu_node_tbi_con2);
diff_hc_tbi_con3 =abs(turbu_node_hc_con1-turbu_node_tbi_con3);

save('diff_turbu_node_lam6_hc_tbi.mat','diff_hc_tbi_con1','diff_hc_tbi_con2','diff_hc_tbi_con3')

%-----------------------------------------------------------------------------------------------------------------------------------------------------------------
% COMPARISON HCs vs TBI 3-months
% Get top15% nodes at lambda=0.06
thr = 0.85; %top15% quantile
index_top15=find(diff_hc_tbi_con1>=quantile(diff_hc_tbi_con1,thr));
qtop15= RSN_labels(1,index_top15);
save('index_top15_turbu_node_lam6_hc_tbi_con1.mat','index_top15')
% Find top10 nodes based on max diff
diff_hc_tbi_con1_top15=diff_hc_tbi_con1(1,index_top15);
diff_hc_tbi_con1_top15(2,:)=index_top15;
diff_hc_tbi_con1_top15=diff_hc_tbi_con1_top15';
sorted_diff_hc_tbi_con1_top15=sortrows(diff_hc_tbi_con1_top15);
max10_hc_tbi_con1_top15=sorted_diff_hc_tbi_con1_top15(length(sorted_diff_hc_tbi_con1_top15)-9:length(sorted_diff_hc_tbi_con1_top15),:);
save('max10_hc_tbi_con1_top15_turbu_node_lam6.mat','max10_hc_tbi_con1_top15')

cd('figures/')
figure
histogram(qtop15(1,:))
xticklabels(RSN_names)
title ('Turbu node diff HCs vs TBI con1')
print('Distribution lam6 Turbu top 15% nodes diff HCs vs TBI 3-months','-dpng')
saveas(gcf,'Distribution lam6Turbu top 15% nodes diff HCs vs TBI 3-months','fig')

%Create spider plot at lambda=0.06
[a] = histogram(qtop15(1,:));
to_spi = a.Values;
figure
spider_plot(to_spi, ...
    'AxesLabels', RSN_names, ...
    'AxesInterval', 2,...
    'AxesDisplay','data',...
    'AxesPrecision',0,...
    'FillOption', {'on'},...
   'FillTransparency', 0.25,...
    'Color' , [0.4940, 0.1840, 0.5560],...
    'AxesFontSize',14,...
    'LabelFontSize',14,...
    'AxesLabelsOffset',0.15,... 
    'AxesLabelsEdge','none');
print('Radar lam6 Turbu top 15% nodes diff HCs vs TBI 3-months','-dpng')
saveas(gcf,'Radar lam6 Turbu top 15% nodes diff HCs vs TBI 3-months','fig')

%Create box plot for top15% nodes at lambda=0.06
figure
t=tiledlayout(2,4);
for i=1:7
    index_rsn= index_top15(qtop15(1,:)==i);
    size(index_rsn,2)
    t1 = squeeze(nanmean(hc_con1.Turbulence_node_sub(8,index_rsn,:),2));
    t2 = squeeze(nanmean(tbi_con1.Turbulence_node_sub(8,index_rsn,:),2));
    if ~isempty(index_rsn)
    C = {t1, t2};
    nexttile
    maxNumEl = max(cellfun(@numel,C));
    Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
    Cmat = cell2mat(Cpad);
    groups={'HC','TBI 3-MO'};
    boxplot(Cmat,'Labels',groups)

    [~,pval] = ttest2(t1,t2); % paired t Test
    p(1,i)=pval; clear pval t1 t2
    H=sigstar({[1,2]},p(1,i));
    
    title(RSN_names{i})
    end
end
title(t,'Turbu top15% nodes lam6 HCs vs TBI 3-months')
print('Boxplot lam6 Turbu top 15% nodes diff HCs vs TBI 3-months','-dpng')
saveas(gcf,'Boxplot lam6 Turbu top 15% nodes diff HCs vs TBI 3-months','fig')
clear Cmat Cpad index_top15
%-----------------------------------------------------------------------------------------------------------------------------------------------------------------
% COMPARISON HCs vs TBI 6-months
% Get top15% nodes at lambda=0.03
cd ..
thr = 0.85; %top15% quantile
index_top15=find(diff_hc_tbi_con2>=quantile(diff_hc_tbi_con2,thr));
qtop15= RSN_labels(1,index_top15);
save('index_top15_turbu_node_lam6_hc_tbi_con2.mat','index_top15') 
% Find top10 nodes based on max diff
diff_hc_tbi_con2_top15=diff_hc_tbi_con2(1,index_top15);
diff_hc_tbi_con2_top15(2,:)=index_top15;
diff_hc_tbi_con2_top15=diff_hc_tbi_con2_top15';
sorted_diff_hc_tbi_con2_top15=sortrows(diff_hc_tbi_con2_top15);
max10_hc_tbi_con2_top15=sorted_diff_hc_tbi_con2_top15(length(sorted_diff_hc_tbi_con2_top15)-9:length(sorted_diff_hc_tbi_con2_top15),:);
save('max10_hc_tbi_con2_top15_turbu_node_lam6.mat','max10_hc_tbi_con2_top15')

cd 'figures/'
figure
histogram(qtop15(1,:))
xticklabels(RSN_names)
title ('Turbu node diff HCs vs TBI con2')
print('Distribution lam6 Turbu top 15% nodes diff HCs vs TBI 6-months','-dpng')
saveas(gcf,'Distribution lam6Turbu top 15% nodes diff HCs vs TBI 6-months','fig')

%Create spider plot at lambda=0.06
[a] = histogram(qtop15(1,:));
to_spi = a.Values;
figure
spider_plot(to_spi, ...
    'AxesLabels', RSN_names, ...
    'AxesInterval', 2,...
    'AxesDisplay','data',...
    'AxesPrecision',0,...
    'FillOption', {'on'},...
   'FillTransparency', 0.25,...
    'Color' , [0.8500 0.3250 0.0980],...
    'AxesFontSize',14,...
    'LabelFontSize',14,...
    'AxesLabelsOffset',0.15,... 
    'AxesLabelsEdge','none');
print('Radar lam6 Turbu top 15% nodes diff HCs vs TBI 6-months','-dpng')
saveas(gcf,'Radar lam6 Turbu top 15% nodes diff HCs vs TBI 6-months','fig')

%Create box plot for top15% nodes at lambda=0.06
figure
t=tiledlayout(2,4);
for i=1:7
    index_rsn= index_top15(qtop15(1,:)==i);
    size(index_rsn,2)
    t1 = squeeze(nanmean(hc_con1.Turbulence_node_sub(8,index_rsn,:),2));
    t2 = squeeze(nanmean(tbi_con2.Turbulence_node_sub(8,index_rsn,:),2));
    if ~isempty(index_rsn)
    C = {t1, t2};
    nexttile
    maxNumEl = max(cellfun(@numel,C));
    Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
    Cmat = cell2mat(Cpad);
    groups={'HC','TBI 6-MO'};
    boxplot(Cmat,'Labels',groups)

    [~,pval] = ttest2(t1,t2); % paired t Test
    p(1,i)=pval; clear pval t1 t2
    H=sigstar({[1,2]},p(1,i));
    
    title(RSN_names{i})
    end
end
title(t,'Turbu top15% nodes lam6 HCs vs TBI 6-months')
print('Boxplot lam6 Turbu top 15% nodes diff HCs vs TBI 6-months','-dpng')
saveas(gcf,'Boxplot lam6 Turbu top 15% nodes diff HCs vs TBI 6-months','fig')
clear Cmat Cpad index_top15
%%-----------------------------------------------------------------------------------------------------------------------------------------
% COMPARISON HCs vs TBI 12-months
% Get top15% nodes at lambda=0.06
cd ..
thr = 0.85; %top15% quantile
index_top15=find(diff_hc_tbi_con3>=quantile(diff_hc_tbi_con3,thr));
qtop15= RSN_labels(1,index_top15);
save('index_top15_turbu_node_lam6_hc_tbi_con3.mat','index_top15') 
% Find top10 nodes based on max diff
diff_hc_tbi_con3_top15=diff_hc_tbi_con3(1,index_top15);
diff_hc_tbi_con3_top15(2,:)=index_top15;
diff_hc_tbi_con3_top15=diff_hc_tbi_con3_top15';
sorted_diff_hc_tbi_con3_top15=sortrows(diff_hc_tbi_con3_top15);
max10_hc_tbi_con3_top15=sorted_diff_hc_tbi_con3_top15(length(sorted_diff_hc_tbi_con3_top15)-9:length(sorted_diff_hc_tbi_con3_top15),:);
save('max10_hc_tbi_con3_top15_turbu_node_lam6.mat','max10_hc_tbi_con3_top15')

cd 'figures/'
figure
histogram(qtop15(1,:))
xticklabels(RSN_names)
title ('Turbu node diff HCs vs TBI con3')
print('Distribution lam6 Turbu top 15% nodes diff HCs vs TBI 12-months','-dpng')
saveas(gcf,'Distribution lam6Turbu top 15% nodes diff HCs vs TBI 12-months','fig')

%Create spider plot at lambda=0.06
[a] = histogram(qtop15(1,:));
to_spi = a.Values;
figure
spider_plot(to_spi, ...
    'AxesLabels', RSN_names, ...
    'AxesInterval', 2,...
    'AxesDisplay','data',...
    'AxesPrecision',0,...
    'FillOption', {'on'},...
   'FillTransparency', 0.25,...
    'Color' , [0.3010, 0.7450, 0.9330],...
    'AxesFontSize',14,...
    'LabelFontSize',14,...
    'AxesLabelsOffset',0.15,... 
    'AxesLabelsEdge','none');
print('Radar lam6 Turbu top 15% nodes diff HCs vs TBI 12-months','-dpng')
saveas(gcf,'Radar lam6 Turbu top 15% nodes diff HCs vs TBI 12-months','fig')

%Create box plot for top15% nodes at lambda=0.06
figure
t=tiledlayout(2,4);
for i=1:7
    index_rsn= index_top15(qtop15(1,:)==i);
    size(index_rsn,2)
    t1 = squeeze(nanmean(hc_con1.Turbulence_node_sub(8,index_rsn,:),2));
    t2 = squeeze(nanmean(tbi_con3.Turbulence_node_sub(8,index_rsn,:),2));
    if ~isempty(index_rsn)
    C = {t1, t2};
    nexttile
    maxNumEl = max(cellfun(@numel,C));
    Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
    Cmat = cell2mat(Cpad);
    groups={'HC','TBI 12-MO'};
    boxplot(Cmat,'Labels',groups)

    [~,pval] = ttest2(t1,t2); % paired t Test
    p(1,i)=pval; clear pval t1 t2
    H=sigstar({[1,2]},p(1,i));
    
    title(RSN_names{i})
    end
end
title(t,'Turbu top15% nodes lam6 HCs vs TBI 12-months')
print('Boxplot lam6 Turbu top 15% nodes diff HCs vs TBI 12-months','-dpng')
saveas(gcf,'Boxplot lam6 Turbu top 15% nodes diff HCs vs TBI 12-months','fig')
clear Cmat Cpad index_top15
