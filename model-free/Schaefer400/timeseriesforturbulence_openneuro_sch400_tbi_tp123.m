%% Create timeseries for turbulence

clear all
data_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/preprocessing/tbi_sch400/';
input_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/inputs_sch400/';
fnames=dir(data_path);
fnames=fnames(~ismember({fnames.name},{'.','..'}));

for s=1:12
    load(fullfile(data_path,fnames(s).name))
    for i=1:400 %100 Schaefer nodes
        data_sc400_openneuro_tbi_tp1(i, 1:144)=data{1,1267+i}(1:144)';
        data_sc400_openneuro_tb_tp2(i, 1:144)=data{1,1267+i}(145:288)';
        data_sc400_openneuro_tb_tp3(i, 1:144)=data{1,1267+i}(289:end)';
    end

tseries(s, 1)={data_sc400_openneuro_tbi_tp1};
tseries(s, 2)={data_sc400_openneuro_tb_tp2};
tseries(s, 3)={data_sc400_openneuro_tb_tp3};
    
    clearvars -except data_path input_path fnames tseries
end

cd(input_path)
save('tseries_openneuro_tbi_tp123_sch400.mat', 'tseries')
