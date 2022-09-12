clear all

data_path='/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/';
cd (data_path)

ds1=load('turbu_all_measurements__openneuro_controls_con1.mat');
ds2=load('turbu_all_measurements__openneuro_tbi_con1.mat');
ds3=load('turbu_all_measurements__openneuro_tbi_con2.mat');
ds4=load('turbu_all_measurements__openneuro_tbi_con3.mat');
groups={'HC','tbi-ses1','tbi-ses2','tbi-ses3'};

lambda=ds1.LAMBDA; 

% Turbulence Global TBI vs HC
for i=1:length(lambda)
[p_turbu_hcvstbi(i) h]=ranksum((ds1.Turbulence_global_sub(i,:)) ,(ds2.Turbulence_global_sub(i,:)));
end
fileID = fopen('rk_turbugl.txt','w');
fprintf(fileID,'%6s\n','p_turbu_hcvstbi');
fprintf(fileID,'%6.4f\n',p_turbu_hcvstbi);
fclose(fileID);


% Turbulence RSN TBI vs HC
for i=1:length(lambda)
    for j=1:size(ds1.TurbulenceRSN_sub,3)
[p_turbursn_hcvstbi(i,j) h]=ranksum((ds1.TurbulenceRSN_sub(i,:,j)) ,(ds2.TurbulenceRSN_sub(i,:,j)));
    end
end

fileID = fopen(['rk_turbu_RSN.txt'],'w');
fprintf(fileID,'%6s %6s %6s %6s %6s %6s %6s\n','vis','sm','da','va','lim','con','dmn');
fprintf(fileID,'%6.4f %6.4f %6.4f %6.4f %6.4f %6.4f %6.4f\n',p_turbursn_hcvstbi);
fclose(fileID);

% Turbulence Global TBI TP1 vs TP2
for i=1:length(lambda)
[p1t(i) h]=ranksum((ds3.Turbulence_global_sub(i,:)),(ds4.Turbulence_global_sub(i,:)));

end

%Info flow
for i=1:length(lambda)
[pitt(i) h]=ranksum((ds1.Transfer_Lambda_sub(i,:)) ,(ds2.Transfer_Lambda_sub(i,:)));
%fprintf('Turbulence "%d": CNT vs NoRemNoRes=%.4f;\t\n',i,p1);
end

% Info transfer
for i=1:length(lambda)
[pift(i) h]=ranksum((ds1.Transfer_sub(i,:)) ,(ds2.Transfer_sub(i,:)));
%fprintf('Turbulence "%d": CNT vs NoRemNoRes=%.4f;\t\n',i,p1);
end

% Info cascade
for i=1:length(lambda)
[pict(i) h]=ranksum((ds1.Information_cascade_sub(i,:)) ,(ds2.Transfer_Lambda_sub(i,:)));
%fprintf('Turbulence "%d": CNT vs NoRemNoRes=%.4f;\t\n',i,p1);
end
