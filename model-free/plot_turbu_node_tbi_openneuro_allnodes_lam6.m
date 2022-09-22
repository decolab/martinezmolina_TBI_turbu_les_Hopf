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

%% Visualization for lambda = 0.06

%Create box plot for all nodes by RSN at lambda=0.06
figure
t=tiledlayout(2,4);
for i=1:7
    t1 = squeeze(nanmean(hc_con1.Turbulence_node_sub(8,:,:),2));
    t2 = squeeze(nanmean(tbi_con1.Turbulence_node_sub(8,:,:),2));
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

title(t,'Turbu all nodes lam6 HCs vs TBI 3-months')
print('Boxplot lam6 Turbu all nodes diff HCs vs TBI 3-months','-dpng')
saveas(gcf,'Boxplot lam6 Turbu all nodes diff HCs vs TBI 3-months','fig')
clear Cmat Cpad
%-----------------------------------------------------------------------------------------------------------------------------------------------------------------

%Create box plot for all nodes by RSN at lambda=0.03
figure
t=tiledlayout(2,4);
for i=1:7
    t1 = squeeze(nanmean(hc_con1.Turbulence_node_sub(8,:,:),2));
    t2 = squeeze(nanmean(tbi_con2.Turbulence_node_sub(8,:,:),2));
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


title(t,'Turbu all nodes lam6 HCs vs TBI 6-months')
print('Boxplot lam6 Turbu all nodes diff HCs vs TBI 6-months','-dpng')
saveas(gcf,'Boxplot lam6 Turbu all nodes diff HCs vs TBI 6-months','fig')
clear Cmat Cpad
%%-----------------------------------------------------------------------------------------------------------------------------------------
% COMPARISON HCs vs TBI 12-months

%Create box plot for all nodes by RSN at lambda=0.03
figure
t=tiledlayout(2,4);
for i=1:7
    t1 = squeeze(nanmean(hc_con1.Turbulence_node_sub(8,:,:),2));
    t2 = squeeze(nanmean(tbi_con3.Turbulence_node_sub(8,:,:),2));
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

title(t,'Turbu all nodes lam6 HCs vs TBI 12-months')
print('Boxplot lam6 Turbu all nodes diff HCs vs TBI 12-months','-dpng')
saveas(gcf,'Boxplot lam6 Turbu all nodes diff HCs vs TBI 12-months','fig')
clear Cmat Cpad
