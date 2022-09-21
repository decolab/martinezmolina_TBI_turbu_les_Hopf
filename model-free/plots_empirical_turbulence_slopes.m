clear all;
close all;
data_path='/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/';
output_path='/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/figures/';
addpath(data_path);
addpath(output_path);

% Load data and rename variables
groups={'hc','tbi1','tbi2','tbi3'};
hc=load('turbu_all_measurements__openneuro_controls_con1.mat'); 
Turbulence_global_sub_hc=hc.Turbulence_global_sub;
Transfer_sub_hc=hc.Transfer_sub; clear hc
tbi1=load('turbu_all_measurements__openneuro_tbi_con1.mat');
Turbulence_global_sub_tbi1=tbi1.Turbulence_global_sub;
Transfer_sub_tbi1=tbi1.Transfer_sub; clear tbi1
tbi2=load('turbu_all_measurements__openneuro_tbi_con2.mat');
Turbulence_global_sub_tbi2=tbi2.Turbulence_global_sub; 
Transfer_sub_tbi2=tbi2.Transfer_sub; clear tbi2
tbi3=load('turbu_all_measurements__openneuro_tbi_con3.mat');
Turbulence_global_sub_tbi3=tbi3.Turbulence_global_sub; 
Transfer_sub_tbi3=tbi3.Transfer_sub; clear tbi3

LAMBDA=[0.27 0.24 0.21 0.18 0.15 0.12 0.09 0.06 0.03 0.01];

cd(output_path)
%% Relative amplitude turbulence mean
figure;
for ilambda=1:length(LAMBDA)
subplot(4,3,ilambda)
turbu_hc=nanmean(Turbulence_global_sub_hc(ilambda,:));
turbu_tbi1=nanmean(Turbulence_global_sub_tbi1(ilambda,:));
turbu_tbi2=nanmean(Turbulence_global_sub_tbi2(ilambda,:));
turbu_tbi3=nanmean(Turbulence_global_sub_tbi3(ilambda,:));


X = [1:4];
Y = [turbu_hc, turbu_tbi1, turbu_tbi2, turbu_tbi3];
plot(X,Y,'*')
hold on
p = polyfit(X,Y,1);
y_new = polyval(p,X);
plot(X, y_new,'-c')

slope_turbu(ilambda)= p(1);
end

%% Relative amplitude turbulence all participants
f1=figure; f2=figure;f3=figure;f4=figure;
for ilambda=1:length(LAMBDA)
turbu_hc=Turbulence_global_sub_hc(ilambda,:);
turbu_tbi1=Turbulence_global_sub_tbi1(ilambda,:);
turbu_tbi2=Turbulence_global_sub_tbi2(ilambda,:);
turbu_tbi3=Turbulence_global_sub_tbi3(ilambda,:);


X = [1:12];
%Compute slope for hc
Y_hc = [turbu_hc];
figure (f1)
title('turbu_hc')
subplot(4,3,ilambda)
plot(X,Y_hc,'*')
hold on
p_hc = polyfit(X,Y_hc,1);
yhc_new = polyval(p_hc,X);
plot(X, yhc_new,'-c')

slope_turbu_hc(ilambda)= p_hc(1);

%Compute slope for tbi1
Y_tbi1 = [turbu_tbi1];
figure (f2)
title('turbu_tbi1')
subplot(4,3,ilambda)
plot(X,Y_tbi1,'*')
hold on
p_tbi1 = polyfit(X,Y_tbi1,1);
ytbi1_new = polyval(p_tbi1,X);
plot(X, ytbi1_new,'-c')

slope_turbu_tbi1(ilambda)= p_tbi1(1);

%Compute slope for tbi2
Y_tbi2 = [turbu_tbi2];
figure (f3)
title('turbu_tbi2')
subplot(4,3,ilambda)
plot(X,Y_tbi2,'*')
hold on
p_tbi2 = polyfit(X,Y_tbi2,1);
ytbi2_new = polyval(p_tbi2,X);
plot(X, ytbi2_new,'-c')

slope_turbu_tbi2(ilambda)= p_tbi2(1);

%Compute slope for tbi3
Y_tbi3 = [turbu_tbi3];
figure (f4)
title('turbu_tbi3')
subplot(4,3,ilambda)
plot(X,Y_tbi3,'*')
hold on
p_tbi3 = polyfit(X,Y_tbi3,1);
ytbi3_new = polyval(p_tbi3,X);
plot(X, ytbi3_new,'-c')

slope_turbu_tbi3(ilambda)= p_tbi3(1);

end

clear p_tbi1 p_tbi2 p_tbi3
%plot slopes
figure
plot(LAMBDA,slope_turbu_hc,'-*k')
hold on
plot(LAMBDA,slope_turbu_tbi1,'-*c')
hold on
plot(LAMBDA,slope_turbu_tbi2,'-*r')
hold on
plot(LAMBDA,slope_turbu_tbi3,'-*m')
hold off
yline(0);
legend(groups)
xlabel('Relative amplitude turbulence'), ylabel('Spatial scale') 

print('Relative Amplitude Turbulence HC TBI1-3 Open Neuro','-dpng')

%% Relative information transfer mean
figure;
for ilambda=1:length(LAMBDA)
subplot(4,3,ilambda)
turbu_hc=nanmean(Transfer_global_sub_hc(ilambda,:));
turbu_tbi1=nanmean(Transfer_global_sub_tbi1(ilambda,:));
turbu_tbi2=nanmean(Transfer_global_sub_tbi2(ilambda,:));
turbu_tbi3=nanmean(Transfer_global_sub_tbi3(ilambda,:));


X = [1:4];
Y = [turbu_hc, turbu_tbi1, turbu_tbi2, turbu_tbi3];
plot(X,Y,'*')
hold on
p = polyfit(X,Y,1);
y_new = polyval(p,X);
plot(X, y_new,'-c')

slope_turbu(ilambda)= p(1);
end

%% Relative information transfer all participants
f6=figure; f7=figure;f8=figure;f9=figure;
for ilambda=1:length(LAMBDA)
transfer_hc=Transfer_sub_hc(ilambda,:);
transfer_tbi1=Transfer_sub_tbi1(ilambda,:);
transfer_tbi2=Transfer_sub_tbi2(ilambda,:);
transfer_tbi3=Transfer_sub_tbi3(ilambda,:);


X = [1:12];
%Compute slope for hc
Y_hc = [transfer_hc];
figure (f6)
subplot(4,3,ilambda)
plot(X,Y_hc,'*')
hold on
p_hc = polyfit(X,Y_hc,1);
yhc_new = polyval(p_hc,X);
plot(X, yhc_new,'-c')

slope_transfer_hc(ilambda)= p_hc(1);

%Compute slope for tbi1
Y_tbi1 = [transfer_tbi1];
figure (f7)
subplot(4,3,ilambda)
plot(X,Y_tbi1,'*')
hold on
p_tbi1 = polyfit(X,Y_tbi1,1);
ytbi1_new = polyval(p_tbi1,X);
plot(X, ytbi1_new,'-c')

slope_transfer_tbi1(ilambda)= p_tbi1(1);

%Compute slope for tbi2
Y_tbi2 = [transfer_tbi2];
figure (f8)
subplot(4,3,ilambda)
plot(X,Y_tbi2,'*')
hold on
p_tbi2 = polyfit(X,Y_tbi2,1);
ytbi2_new = polyval(p_tbi2,X);
plot(X, ytbi2_new,'-c')

slope_transfer_tbi2(ilambda)= p_tbi2(1);

%Compute slope for tbi3
Y_tbi3 = [transfer_tbi3];
figure (f9)
subplot(4,3,ilambda)
plot(X,Y_tbi3,'*')
hold on
p_tbi3 = polyfit(X,Y_tbi3,1);
ytbi3_new = polyval(p_tbi3,X);
plot(X, ytbi3_new,'-c')

slope_transfer_tbi3(ilambda)= p_tbi3(1);

end

%plot slopes
figure
plot(LAMBDA,slope_transfer_hc,'-*k')
hold on
plot(LAMBDA,slope_transfer_tbi1,'-*c')
hold on
plot(LAMBDA,slope_transfer_tbi2,'-*r')
hold on
plot(LAMBDA,slope_transfer_tbi3,'-*m')
hold off
yline(0);
legend(groups)
xlabel('Relative information transfer'), ylabel('Spatial scale') 

print('Relative information transfer HC TBI1-3 Open Neuro','-dpng')

cd(data_path)
save('slope_turbu_all', 'slope_turbu_hc','slope_turbu_tbi1','slope_turbu_tbi2','slope_turbu_tbi3')
save('slope_transfer_all', 'slope_transfer_hc','slope_transfer_tbi1','slope_transfer_tbi2','slope_transfer_tbi3')