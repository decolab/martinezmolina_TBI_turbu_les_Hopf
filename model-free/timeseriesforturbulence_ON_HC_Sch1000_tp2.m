%% Create timeseries for turbulence

clear all
addpath('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Turbulence/TBI_turbulence_current_code') %code path
data_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/preprocessing/controls_tp2';
input_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/inputs_sch1000/';
fnames=dir(data_path);
fnames=fnames(~ismember({fnames.name},{'.','..'}));
fnames2=fnames(13:end); %if run on macOSX

for s=1:12
    load(fullfile(data_path,fnames2(s).name))
    for i=1:1000 %1000 Schaefer nodes
        data_sc1000_openneuro_con_tp2(i, 1:144)=data{1,167+i}(1:144)';
    end

tseries_tp2(s, 1)={data_sc1000_openneuro_con_tp2};
    
    clearvars -except data_path input_path fnames fnames2 tseries_tp2
end

cd(input_path)
save('tseries_openneuro_controls_tp2_sch1000_test.mat', 'tseries_tp2')
