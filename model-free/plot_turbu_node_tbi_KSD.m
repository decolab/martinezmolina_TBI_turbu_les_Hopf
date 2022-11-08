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

%% Visualization for lambda = 0.03!!!!!!!!!!!!!

%Compute mean differences
turbu_node_hc_con1=nanmean(hc_con1.Turbulence_node_sub(9,:,:),3);
turbu_node_tbi_con1=nanmean(tbi_con1.Turbulence_node_sub(9,:,:),3);
turbu_node_tbi_con2=nanmean(tbi_con2.Turbulence_node_sub(9,:,:),3);
turbu_node_tbi_con3=nanmean(tbi_con3.Turbulence_node_sub(9,:,:),3);

diff_hc_tbi_con1 =abs(turbu_node_hc_con1-turbu_node_tbi_con1);
diff_hc_tbi_con2 =abs(turbu_node_hc_con1-turbu_node_tbi_con2);
diff_hc_tbi_con3 =abs(turbu_node_hc_con1-turbu_node_tbi_con3);

save('diff_turbu_node_lam3_hc_tbi.mat','diff_hc_tbi_con1','diff_hc_tbi_con2','diff_hc_tbi_con3')

%-----------------------------------------------------------------------------------------------------------------------------------------------------------------
% COMPARISON HCs vs TBI 3-months
% Get top15% nodes at lambda=0.03
thr = 0.85; %top15% quantile
index_top15=find(diff_hc_tbi_con1>=quantile(diff_hc_tbi_con1,thr));
qtop15= RSN_labels(1,index_top15);
figure
histogram(qtop15(1,:))
xticklabels(RSN_names)
title ('Turbu node diff HCs vs TBI con1')
print('Distribution lam3 Turbu top 15% nodes diff HCs vs TBI 3-months','-dpng')
saveas(gcf,'Distribution lam3Turbu top 15% nodes diff HCs vs TBI 3-months','fig')

%Create spider plot at lambda=0.03
[a] = histogram(qtop15(1,:));
to_spi = a.Values;
figure
spider_plot(to_spi, ...
    'AxesLabels', RSN_names, ...
    'AxesInterval', 2,...
    'FillOption', {'on'},...
   'FillTransparency', 0.1)
print('Radar lam3 Turbu top 15% nodes diff HCs vs TBI 3-months','-dpng')
saveas(gcf,'Radar lam3 Turbu top 15% nodes diff HCs vs TBI 3-months','fig')

%Create box plot for top15% nodes at lambda=0.03
figure
t=tiledlayout(2,4);
for i=1:7
    index_rsn= index_top15(qtop15(1,:)==i);
    size(index_rsn,2)
    t1 = squeeze(nanmean(hc_con1.Turbulence_node_sub(9,index_rsn,:),2));
    t2 = squeeze(nanmean(tbi_con1.Turbulence_node_sub(9,index_rsn,:),2));
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
title(t,'Turbu top15% nodes lam3 HCs vs TBI 3-months')
print('Boxplot lam3 Turbu top 15% nodes diff HCs vs TBI 3-months','-dpng')
saveas(gcf,'Boxplot lam3 Turbu top 15% nodes diff HCs vs TBI 3-months','fig')
clear Cmat Cpad
%-----------------------------------------------------------------------------------------------------------------------------------------------------------------
% COMPARISON HCs vs TBI 6-months
% Get top15% nodes at lambda=0.03
thr = 0.85; %top15% quantile
index_top15=find(diff_hc_tbi_con2>=quantile(diff_hc_tbi_con2,thr));
qtop15= RSN_labels(1,index_top15);
figure
histogram(qtop15(1,:))
xticklabels(RSN_names)
title ('Turbu node diff HCs vs TBI con2')
print('Distribution lam3 Turbu top 15% nodes diff HCs vs TBI 6-months','-dpng')
saveas(gcf,'Distribution lam3Turbu top 15% nodes diff HCs vs TBI 6-months','fig')

%Create spider plot at lambda=0.03
[a] = histogram(qtop15(1,:));
to_spi = a.Values;
figure
spider_plot(to_spi, ...
    'AxesLabels', RSN_names, ...
    'AxesInterval', 2,...
    'FillOption', {'on'},...
   'FillTransparency', 0.1)
print('Radar lam3 Turbu top 15% nodes diff HCs vs TBI 6-months','-dpng')
saveas(gcf,'Radar lam3 Turbu top 15% nodes diff HCs vs TBI 6-months','fig')

%Create box plot for top15% nodes at lambda=0.03
figure
t=tiledlayout(2,4);
for i=1:7
    index_rsn= index_top15(qtop15(1,:)==i);
    size(index_rsn,2)
    t1 = squeeze(nanmean(hc_con1.Turbulence_node_sub(9,index_rsn,:),2));
    t2 = squeeze(nanmean(tbi_con2.Turbulence_node_sub(9,index_rsn,:),2));
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
title(t,'Turbu top15% nodes lam3 HCs vs TBI 6-months')
print('Boxplot lam3 Turbu top 15% nodes diff HCs vs TBI 6-months','-dpng')
saveas(gcf,'Boxplot lam3 Turbu top 15% nodes diff HCs vs TBI 6-months','fig')
clear Cmat Cpad
%%-----------------------------------------------------------------------------------------------------------------------------------------
% COMPARISON HCs vs TBI 12-months
% Get top15% nodes at lambda=0.03
thr = 0.85; %top15% quantile
index_top15=find(diff_hc_tbi_con3>=quantile(diff_hc_tbi_con3,thr));
qtop15= RSN_labels(1,index_top15);
figure
histogram(qtop15(1,:))
xticklabels(RSN_names)
title ('Turbu node diff HCs vs TBI con3')
print('Distribution lam3 Turbu top 15% nodes diff HCs vs TBI 12-months','-dpng')
saveas(gcf,'Distribution lam3Turbu top 15% nodes diff HCs vs TBI 12-months','fig')

%Create spider plot at lambda=0.03
[a] = histogram(qtop15(1,:));
to_spi = a.Values;
figure
spider_plot(to_spi, ...
    'AxesLabels', RSN_names, ...
    'AxesInterval', 2,...
    'FillOption', {'on'},...
   'FillTransparency', 0.1)
print('Radar lam3 Turbu top 15% nodes diff HCs vs TBI 12-months','-dpng')
saveas(gcf,'Radar lam3 Turbu top 15% nodes diff HCs vs TBI 12-months','fig')

%Create box plot for top15% nodes at lambda=0.03
figure
t=tiledlayout(2,4);
for i=1:7
    index_rsn= index_top15(qtop15(1,:)==i);
    size(index_rsn,2)
    t1 = squeeze(nanmean(hc_con1.Turbulence_node_sub(9,index_rsn,:),2));
    t2 = squeeze(nanmean(tbi_con3.Turbulence_node_sub(9,index_rsn,:),2));
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
title(t,'Turbu top15% nodes lam3 HCs vs TBI 12-months')
print('Boxplot lam3 Turbu top 15% nodes diff HCs vs TBI 12-months','-dpng')
saveas(gcf,'Boxplot lam3 Turbu top 15% nodes diff HCs vs TBI 12-months','fig')
clear Cmat Cpad
%%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%%%Boxplots all lambdas%%%
figure
t=tiledlayout (2,4);
for i=1:7
    indx_rsn= find(RSN_labels==i);
    turbu_RSN_hc_con1 = turbu_hc_con1(indx_rsn);
    mean_RSN_hc_con1(i)=mean(turbu_RSN_hc_con1);
    turbu_RSN_tbi_con1 = turbu_tbi_con1(indx_rsn);
    mean_RSN_tbi_con1(i)=mean(turbu_RSN_tbi_con1);
    diffRSN_hc_tbi_con1(i)=nanmean(turbu_RSN_hc_con1)-nanmean(turbu_RSN_tbi_con1);
    nexttile
    boxplot([turbu_RSN_hc_con1; turbu_RSN_tbi_con1]')
    title(RSN_names(i))
end

figure
t=tiledlayout (2,4);
for i=1:7
    indx_rsn= find(RSN_labels==i);
    turbu_RSN_hc_con1 = turbu_hc_con1(indx_rsn);
    mean_RSN_hc_con1(i)=mean(turbu_RSN_hc_con1);
    turbu_RSN_tbi_con2 = turbu_tbi_con2(indx_rsn);
    mean_RSN_tbi_con2(i)=mean(turbu_RSN_tbi_con2);
    diffRSN_hc_tbi_con2(i)=nanmean(turbu_RSN_hc_con1)-nanmean(turbu_RSN_tbi_con2);
    nexttile
    boxplot([turbu_RSN_hc_con1; turbu_RSN_tbi_con2]')
    title(RSN_names(i))
end

figure
t=tiledlayout (2,4);
for i=1:7
    indx_rsn= find(RSN_labels==i);
    turbu_RSN_hc_con1 = turbu_hc_con1(indx_rsn);
    mean_RSN_hc_con1(i)=mean(turbu_RSN_hc_con1);
    turbu_RSN_tbi_con3 = turbu_tbi_con3(indx_rsn);
    mean_RSN_tbi_con1(i)=mean(turbu_RSN_tbi_con1);
    diffRSN_hc_tbi_con3(i)=nanmean(turbu_RSN_hc_con1)-nanmean(turbu_RSN_tbi_con3);
    nexttile
    boxplot([turbu_RSN_hc_con1; turbu_RSN_tbi_con3]')
    title(RSN_names(i))
end
