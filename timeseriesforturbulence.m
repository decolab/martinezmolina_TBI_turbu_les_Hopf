%% Create timeseries for turbulence

clear all
data_path='/Volumes/LASA/TBI/openneuro/derivatives/spm_conn/Output/conn_openneurotbi/results/preprocessing/'; %path to the denoised timeseries from Schaefer 1000 7RNS
output_path='/Volumes/TBI/TBI_project/TBI_openneuro/timeseries/';
fnames=cellstr(conn_dir(fullfile(data_path,'ROI_Subject*_Condition001.mat')));

for s=1:24
    load(fnames{s})
for i=1:1000 %1000 Schaefer nodes
data_sc1000_ses1(i, 1:144)=data{1,167+i}(1:144)';
end
tseries(s, 1)={data_sc1000_ses1};
clearvars -except data_path output_path fnames tseries
end

cd(output_path)
save('tseries_TBI_openneuro_ses1_sch1000.mat', 'tseries')
%% Centroids for nodes
% SchaeferCOG=xlsread('Schaefer2018_1000Parcels_7Networks_order_FSLMNI152_2mm.Centroid_RAS.csv', 'C2:E1001');
% save('SchaeferCOG','SchaeferCOG')