%% Create timeseries for turbulence

clear all
data_path='/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/preprocessing/tbi/'; %path to the denoised timeseries from Schaefer 1000 7RNS
output_path='/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/inputs/';
fnames=cellstr(conn_dir(fullfile(data_path,'ROI_Subject*_Condition000.mat')));

for s=1:12
    load(fnames{s})
for i=1:1000 %1000 Schaefer nodes
data_sc1000_tbi_ses1(i, 1:144)=data{1,167+i}(1:144)';
data_sc1000_tbi_ses2(i, 1:144)=data{1,167+i}(145:288)';
data_sc1000_tbi_ses3(i, 1:144)=data{1,167+i}(289:432)';
end
tseries_ses1(s, 1)={data_sc1000_tbi_ses1};
tseries_ses2(s, 1)={data_sc1000_tbi_ses2};
tseries_ses3(s, 1)={data_sc1000_tbi_ses3};
clearvars -except data_path output_path fnames tseries_ses1 tseries_ses2 tseries_ses3
end

cd(output_path)
tseries=[tseries_ses1 tseries_ses2 tseries_ses3];
save('tseries_openneuro_tbi_tp123_sch1000_test', 'tseries')
