clear;
addpath('/Volumes/LASA/TBI_project/TBI_openneuro/Hopf_model/TBI_replication/outputs/Grange/TBI/');
G=40;
G_range=0.:0.01:3;
LAMBDA=[0.27 0.24 0.21 0.18 0.15 0.12 0.09 0.06 0.03 0.01];
lambda=size(LAMBDA,2)-1;
groups={'tbi-ses1','tbi-ses2','tbi-ses3'};

for cond=1:3
    if cond==1
        cond1=load_condition_tbi(G,cond);
    elseif cond==2
        cond2=load_condition_tbi(G,cond);
    else 
         cond3=load_condition_tbi(G,cond);
    end
end


[minerrhete_cond1,ioptG_tbicond1]=min(mean(cond1.err_hete_range,2));
[minerrhete_cond2,ioptG_tbicond2]=min(mean(cond2.err_hete_range,2));
[minerrhete_cond3,ioptG_tbicond3]=min(mean(cond3.err_hete_range,2));
optG_tbicond1=G_range(ioptG_tbicond1);
optG_tbicond2=G_range(ioptG_tbicond2);
optG_tbicond3=G_range(ioptG_tbicond3);

cd('/Volumes/LASA/TBI_project/TBI_openneuro/Hopf_model/TBI_replication/inputs/')
save optG_tbicond1.mat optG_tbicond1
save optG_tbicond2.mat optG_tbicond2
save optG_tbicond3.mat optG_tbicond3

figure
%subplot(3,1,1)
plot(G_range,mean(cond1.err_hete_range,2),'r'); hold on;
plot(G_range,mean(cond2.err_hete_range,2),'g'); hold on;
plot(G_range,mean(cond3.err_hete_range,2),'b'); hold on;

lpre=sprintf('G opt: %d, err:%.4f',icond1,optG_cond1);
lpost=sprintf('G opt: %d, err:%.4f',icond2,optG_cond2);
lCNT=sprintf('G opt: %d, err:%.4f',icond3,optG_cond3);

legend(groups,'Location','northwest');
xlabel('G range');
title('err hete');
vline(icond2,'g'); hold on;
vline(icond1,'r');
vline(icond3,'b');



subplot(3,1,2)
CRI=mean(cond1.InfoCascade_range,2);
CMI=mean(cond2.InfoCascade_range,2);
plot(G_range,CRI,'g'); hold on;
plot(G_range,CMI,'b'); hold on;
title('InfoCascade');
lCR=sprintf('%.4f',CRI(icond1));
lCM=sprintf('%.4f',CMI(icond2));
xlabel('G range');
vline([(icond1) (icond2)],{'g','b'});
legend(groups,'Location','northwest');

subplot(3,1,3)
CRT=mean(cond1.Turbulence_range,2);
CMT=mean(cond2.Turbulence_range,2);
plot(G_range,CRT,'g'); hold on;
plot(G_range,CMT,'b'); hold on;
title('Turbulence range');
lCR=sprintf('%.4f',CRT(icond1));
lCM=sprintf('%.4f',CMT(icond2));
xlabel('G range');
vline([(icond1) (icond2)],{'g','b'});
legend(groups,'Location','northwest');
