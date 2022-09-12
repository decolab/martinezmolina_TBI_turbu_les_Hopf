%% Create timeseries for turbulence

clear all
data_path='/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/preprocessing/controls/';
input_path='/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/inputs/';
fnames=dir(data_path);
fnames=fnames(~ismember({fnames.name},{'.','..'}));

for s=1:12
    load(fullfile(data_path,fnames(s).name))
    for i=1:1000 %1000 Schaefer nodes
        data_sc1000_openneuro_con_tp1(i, 1:144)=data{1,167+i}(1:144)';
    end

tseries(s, 1)={data_sc1000_openneuro_con_tp1};
    
    clearvars -except data_path input_path fnames tseries
end

cd(input_path)
save('tseries_openneuro_controls_tp1_sch1000.mat', 'tseries')
