%% Create timeseries for turbulence

clear all
addpath('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Turbulence/TBI_turbulence_current_code') %code path
data_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/preprocessing/controls_sch1000/';
input_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/inputs_sch1000/';
fnames=dir(data_path);
fnames=fnames(~ismember({fnames.name},{'.','..'}));

for s=1:12
    load(fullfile(data_path,fnames(s).name))
    for i=1:1000 %1000 Schaefer nodes
          for i=1:1000 %1000 Schaefer nodes
        data_sc1000_openneuro_con_tp1(i, 1:144)=data{1,167+i}(1:144)';
    end
    end

tseries_tp1(s, 1)={data_sc1000_openneuro_con_tp1};
    
    clearvars -except data_path input_path fnames tseries_tp1
end

cd(input_path)
save('tseries_openneuro_controls_tp1_sch1000.mat', 'tseries_tp1')
