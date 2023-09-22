%% Create timeseries for turbulence

clear all
data_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/preprocessing/hc_tp1_sch400/';
input_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/inputs_sch400/';
fnames=dir(data_path);
fnames=fnames(~ismember({fnames.name},{'.','..'}));

for s=1:12
    load(fullfile(data_path,fnames(s).name))
    for i=1:400 %100 Schaefer nodes
        data_sc400_openneuro_hc_tp1(i, 1:144)=data{1,1267+i}(1:144)';
 
    end

tseries(s, 1)={data_sc400_openneuro_hc_tp1};
    clearvars -except data_path input_path fnames tseries
end

cd(input_path)
save('tseries_openneuro_hc_tp1_sch400.mat', 'tseries')
