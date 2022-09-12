%% Create timeseries for turbulence

clear all
data_path='/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/preprocessing/controls/'; %path to the denoised timeseries from Schaefer 1000 7RNS
output_path='/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/inputs/';
fnames=cellstr(conn_dir(fullfile(data_path,'ROI_Subject*_Condition000.mat')));

for s=1:12
    load(fnames{s})
for i=1:1000 %1000 Schaefer nodes
data_sc1000_hc_ses1(i, 1:144)=data{1,167+i}(1:144)';
end
tseries(s, 1)={data_sc1000_hc_ses1};
clearvars -except data_path output_path fnames tseries
end

cd(output_path)
save('tseries_openneuro_controls_tp1_sch1000_cond1.mat', 'tseries')
