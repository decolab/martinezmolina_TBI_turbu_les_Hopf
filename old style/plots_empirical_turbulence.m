clear;
close all;
addpath('C:\Users\anira\Documents\UPF\Depression_Copenhagen\v2\utils');
con1=load('turbu_measurements1.mat');
con2=load('turbu_measurements2.mat');
con3=load('turbu_measurements3.mat');
con4=load('turbu_measurements4.mat');

LAMBDA=[0.27 0.24 0.21 0.18 0.15 0.12 0.09 0.06 0.03 0.01];%emp SClongrange.mat (0.1758)
groups={'CNT','NN','NR','RR'};

for i=1:length(LAMBDA)
    pval(i,1) = ranksum(con1.Turbulence_sub(i,:),con2.Turbulence_sub(i,:));
    pval(i,2)  = ranksum(con1.Turbulence_sub(i,:),con3.Turbulence_sub(i,:));
    pval(i,3) = ranksum(con2.Turbulence_sub(i,:),con4.Turbulence_sub(i,:));
    pval(i,4) = ranksum(con3.Turbulence_sub(i,:),con4.Turbulence_sub(i,:));
    pval(i,5) = ranksum(con1.Turbulence_sub(i,:),con4.Turbulence_sub(i,:));
    pval(i,6) = ranksum(con2.Turbulence_sub(i,:),con3.Turbulence_sub(i,:));
end

figure;
for ilambda=1:length(LAMBDA)
subplot(4,3,ilambda)
turbucond1=con1.Turbulence_sub(ilambda,:);
turbucond2=con2.Turbulence_sub(ilambda,:);
turbucond3=con3.Turbulence_sub(ilambda,:);
turbucond4=con4.Turbulence_sub(ilambda,:);
C = {turbucond1, turbucond2, turbucond3, turbucond4};
maxNumEl = max(cellfun(@numel,C));
Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
Cmat = cell2mat(Cpad);
boxplot(Cmat,'Labels',groups)
ylabel(sprintf('lambda %.2f',LAMBDA(ilambda)));
H=sigstar({[1,2],[1,3],[2,4],[3,4],[1,4],[2,3]},pval(ilambda,:));
end
[rejectedH0s] = FDR_benjHoch(pval(10,:), 0.05)
pval

% en lambda 10 sobreviven:
% rejectedH0s =
% 
%      6
%      1

% pval =
% 
%     0.1061    0.5744    0.0832    0.3362    0.4360    0.7068
%     0.0779    0.8363    0.0983    0.5031    0.4716    0.4059
%     0.1164    0.8136    0.1016    0.7059    0.5192    0.2591
%     0.2263    0.3842    0.1619    0.6879    0.4020    0.1019
%     0.3526    0.1001    0.1924    0.4877    0.4297    0.0554
%     0.3355    0.0629    0.2727    0.3741    0.4235    0.0490
%     0.2991    0.0834    0.1716    0.6177    0.4081    0.0554
%     0.1762    0.1530    0.0951    0.6524    0.3151    0.0398
%     0.0356    0.2576    0.0332    0.8742    0.3125    0.0140
%     0.0146    0.3126    0.0261    0.9127    0.3151    0.0089


%--------------- Info Flow dejando afuera los ultimos valores de lambda--
for i=2:length(LAMBDA)
    pvalTransLambda(i,1) = ranksum(con1.TransferLambda_sub(i,:),con2.TransferLambda_sub(i,:));
    pvalTransLambda(i,2)  = ranksum(con1.TransferLambda_sub(i,:),con3.TransferLambda_sub(i,:));
    pvalTransLambda(i,3) = ranksum(con2.TransferLambda_sub(i,:),con4.TransferLambda_sub(i,:));
    pvalTransLambda(i,4) = ranksum(con3.TransferLambda_sub(i,:),con4.TransferLambda_sub(i,:));
    pvalTransLambda(i,5) = ranksum(con1.TransferLambda_sub(i,:),con4.TransferLambda_sub(i,:));
    pvalTransLambda(i,6) = ranksum(con2.TransferLambda_sub(i,:),con3.TransferLambda_sub(i,:))
end

figure;
for ilambda=2:length(LAMBDA)
subplot(4,3,ilambda)
C = {con1.TransferLambda_sub(ilambda,:), con2.TransferLambda_sub(ilambda,:),...
    con3.TransferLambda_sub(ilambda,:), con4.TransferLambda_sub(ilambda,:)};
maxNumEl = max(cellfun(@numel,C));
Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
Cmat = cell2mat(Cpad);
boxplot(Cmat,'Labels',groups);
H=sigstar({[1,2],[1,3],[2,4],[3,4],[1,4],[2,3]},pvalTransLambda(ilambda,:));
title(sprintf('%f',LAMBDA(ilambda)));
end
% pvalTransLambda
%     0.8146    0.3325    0.6110    0.7059    0.7229    0.3403
%     0.7599    0.3126    0.4550    0.7982    0.5691    0.2307
%     0.7063    0.2701    0.2798    0.8742    0.4204    0.2174
%     0.5029    0.2625    0.2210    0.9515    0.2639    0.1590
%     0.2895    0.3443    0.1393    0.9709    0.1955    0.1865
%     0.1174    0.4102    0.0525    0.8171    0.2166    0.0947
%     0.0427    0.4441    0.0607    0.9903    0.3842    0.0246
%     0.0276    0.5664    0.0832    0.9515    0.6441    0.0281
%     0.0091    0.6646    0.0388    0.8742    0.5367    0.0161
figure;
subplot(1,2,1)
shadedErrorBar(LAMBDA(2:length(LAMBDA)),con1.TransferLambda_sub (2:length(LAMBDA),:)',{@median,@std},'lineprops',{'r-o','markerfacecolor','r'});
hold on 
shadedErrorBar(LAMBDA(2:length(LAMBDA)),con2.TransferLambda_sub(2:length(LAMBDA),:)',{@median,@std},'lineprops',{'b-o','markerfacecolor','b'});
shadedErrorBar(LAMBDA(2:length(LAMBDA)),con3.TransferLambda_sub(2:length(LAMBDA),:)',{@median,@std},'lineprops',{'g-o','markerfacecolor','g'});
shadedErrorBar(LAMBDA(2:length(LAMBDA)),con4.TransferLambda_sub(2:length(LAMBDA),:)',{@median,@std},'lineprops',{'m-o','markerfacecolor','m'});
ylabel('Info Flow');xlabel('Lambda Pairs')
%legend(groups)




% -----------Info Cascade---------------- 
subplot(1,2,2)
startfrom=2;
cntsub=(1:123);

con1.InfoCascade= nanmean(con1.TransferLambda_sub(startfrom:length(LAMBDA),cntsub),1);
con2.InfoCascade = nanmean(con2.TransferLambda_sub(startfrom:length(LAMBDA),:),1);
con3.InfoCascade = nanmean(con3.TransferLambda_sub(startfrom:length(LAMBDA),:),1);
con4.InfoCascade = nanmean(con4.TransferLambda_sub(startfrom:length(LAMBDA),1:21),1);
C = {con1.InfoCascade, con2.InfoCascade, con3.InfoCascade, con4.InfoCascade};
maxNumEl = max(cellfun(@numel,C));
Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
Cmat = cell2mat(Cpad); 
boxplot(Cmat,'Labels',groups)

ylabel('Info Cascade')
pvalIC(1) = ranksum(con1.InfoCascade(cntsub),con2.InfoCascade);
pvalIC(2)  = ranksum(con1.InfoCascade(cntsub),con3.InfoCascade);
pvalIC(3) = ranksum(con2.InfoCascade,con4.InfoCascade);
pvalIC(4) = ranksum(con3.InfoCascade,con4.InfoCascade)
pvalIC(5) = ranksum(con1.InfoCascade(cntsub),con4.InfoCascade)
pvalIC(6) = ranksum(con2.InfoCascade,con3.InfoCascade)

[rejectedH0s] = FDR_benjHoch(pvalIC, 0.05);
%rejectedH0s =

%      1
%      6
H=sigstar({[1,2],[1,3],[2,4],[3,4],[1,4],[2,3]},pvalIC(:));
pvalIC
% info cascade, hem tret lambdas no signif

%    0.0207    0.0182    0.1692    0.0994    0.7033    0.9621

% subplot(2,2,3)
% 
% C = {con1.InfoCascade, con2.InfoCascade, con3.InfoCascade, con4.InfoCascade};
% maxNumEl = max(cellfun(@numel,C));
% Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
% Cmat = cell2mat(Cpad); 
% boxplot(Cmat,'Labels',groups)


%-------Transfer ----------%
for i=1:length(LAMBDA)
    pvalTr(i,1) = ranksum(con1.Transfer_sub(i,:),con2.Transfer_sub(i,:));
    pvalTr(i,2)  = ranksum(con1.Transfer_sub(i,:),con3.Transfer_sub(i,:));
    pvalTr(i,3) = ranksum(con2.Transfer_sub(i,:),con4.Transfer_sub(i,:));
    pvalTr(i,4) = ranksum(con3.Transfer_sub(i,:),con4.Transfer_sub(i,:));
    pvalTr(i,5) = ranksum(con1.Transfer_sub(i,:),con4.Transfer_sub(i,:));
    pvalTr(i,6) = ranksum(con2.Transfer_sub(i,:),con3.Transfer_sub(i,:));
end
[rejectedH0s] = FDR_benjHoch(pvalTr(10,:), 0.05);
H=sigstar({[1,2],[1,3],[2,4],[3,4],[1,4],[2,3]},pvalTr(10,:));

ylabel('Transfer')


figure;
for ilambda=1:length(LAMBDA)
subplot(4,3,ilambda)
C = {2-con1.Transfer_sub(ilambda,:), 2-con2.Transfer_sub(ilambda,:),...
    2-con3.Transfer_sub(ilambda,:),2- con4.Transfer_sub(ilambda,:)};
maxNumEl = max(cellfun(@numel,C));
Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
Cmat = cell2mat(Cpad);
boxplot(Cmat,'Labels',groups);
H=sigstar({[1,2],[1,3],[2,4],[3,4],[1,4],[2,3]},pvalTr(ilambda,:));
title(sprintf('%f',LAMBDA(ilambda)));
ylabel('Transfer')
end

%----------------------
% for python
% tur = [con1.Turbulence(4,:), con2.Turbulence(4,:), con3.Turbulence(4,:), con4.Turbulence(4,:)];
% trans = [con1.Transfer(4,:), con2.Transfer(4,:), con3.Transfer(4,:), con4.Transfer(4,:)];
% IC = [con1.InfoCascade, con2.InfoCascade, con3.InfoCascade, con4.InfoCascade];
% 


