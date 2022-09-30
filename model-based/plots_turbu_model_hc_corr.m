clear;
addpath('/Volumes/LASA/TBI_project/TBI_openneuro/Hopf_model/TBI_replication/outputs/Grange/HC/');
addpath('/Volumes/LASA/TBI_project/TBI_openneuro/Hopf_model/TBI_replication/code/');
G=300;
G_range=0.:0.01:3;
LAMBDA=[0.27 0.24 0.21 0.18 0.15 0.12 0.09 0.06 0.03 0.01];
lambda=size(LAMBDA,2)-1;
groups={'hc'};

cond=1;
cond_hc=load_condition_hc(G,cond);
[minerrhete_hc,ioptG_hc]=min(mean(cond_hc.err_hete_range,2));
optG_hc=G_range(ioptG_hc);

cd('/Volumes/LASA/TBI_project/TBI_openneuro/Hopf_model/TBI_replication/inputs/')
save optG_hc.mat optG_hc

figure
subplot(3,1,1)
plot(G_range(1:end-1),mean(cond_hc.err_hete_range,2),'r'); hold on;
lHC=sprintf('G opt: %d, err:%.4f',ioptG_hc,optG_hc);
legend(groups,'Location','northwest');
xlabel('G range');
title('err hete');
vline(icondhc,'r'); 

subplot(3,1,2)
CHC=mean(cond_hc.InfoCascade_range,2);
plot(G_range,CHC,'r'); 
title('InfoCascade');
lCHC=sprintf('%.4f',CHC(icondhc));
xlabel('G range');
vline(icondhc,'r'); 
legend(groups,'Location','northwest');

subplot(3,1,3)
CHC=mean(cond_hc.Turbulence_range,2);
plot(G_range,CHC,'r'); 
title('Turbulence range');
CHC=sprintf('%.4f',CHC(icondhc));
xlabel('G range');
vline(icondhc,'r'); 
legend(groups,'Location','northwest');

% figure;
% shadedErrorBar(,mean(cond_hc.err_hete_range,2),{@median,@std},'lineprops',{'k-o','color',[0.4940 0.1840 0.5560],'markerfacecolor',[0.4940 0.1840 0.5560]});
% hold on 
% shadedErrorBar(LAMBDA(2:length(LAMBDA)),Info_flow_tbi_s2(2:length(LAMBDA),:)',{@median,@std},'lineprops',{'k-o','color',[0.8500 0.3250 0.0980],'markerfacecolor',[0.8500 0.3250 0.0980]});
% shadedErrorBar(LAMBDA(2:length(LAMBDA)),Info_flow_tbi_s3(2:length(LAMBDA),:)',{@median,@std},'lineprops',{'k-o','color',[0 0.4470 0.7410],'markerfacecolor',[0 0.4470 0.7410]});
% shadedErrorBar(LAMBDA(2:length(LAMBDA)),Info_flow_hc_s1(2:length(LAMBDA),:)',{@median,@std},'lineprops',{'k-o','color',[0.7 0.7 0.7],'markerfacecolor',[0.7 0.7 0.7]});
% ylabel('Fitting');xlabel('G range')
% legend(cond)
%print('Info Flow TBI Open Neuro TP123 (N=24) RGB color filt','-dpng')
%saveas(gcf,'Info Flow Open Neuro TP123 (N=24) RGB color filt','fig')
close()
