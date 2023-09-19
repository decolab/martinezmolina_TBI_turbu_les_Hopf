%% Create timeseries for turbulence

clear all
addpath('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Turbulence/TBI_turbulence_current_code') %code path
data_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/preprocessing/tbi_sch1000/';
input_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/inputs_sch1000/';
fnames=dir(data_path);
fnames=fnames(~ismember({fnames.name},{'.','..'}));

for s=1:12
    load(fullfile(data_path,fnames(s).name))
    for i=1:1000 %1000 Schaefer nodes
        data_sc1000_openneuro_tbi_tp1(i, 1:144)=data{1,167+i}(1:144)';
        data_sc1000_openneuro_tb_tp2(i, 1:144)=data{1,167+i}(145:288)';
        data_sc1000_openneuro_tb_tp3(i, 1:144)=data{1,167+i}(289:end)';
    end

tseries(s, 1)={data_sc1000_openneuro_tbi_tp1};
tseries(s, 2)={data_sc1000_openneuro_tbi_tp2};
tseries(s, 3)={data_sc1000_openneuro_tb_tp3};
    
    clearvars -except data_path input_path fnames tseries tseries tseries
end

cd(input_path)
save('tseries_openneuro_tbi_tp1_sch1000_test.mat', 'tseries')
save('tseries_openneuro_tbi_tp2_sch1000_test.mat', 'tseries')
save('tseries_openneuro_tbi_tp3_sch1000_test.mat', 'tseries')
