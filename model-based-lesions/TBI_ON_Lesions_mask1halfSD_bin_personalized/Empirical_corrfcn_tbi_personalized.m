clear all;
addpath('/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/inputs/');
addpath('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Hopf_TBI_ON_personalized/');
load schaefer_MK.mat;
load tseries_openneuro_tbi_tp123_sch1000.mat; % Load your data

% Parameters of the data
TR=2;  % Repetition Time (seconds)
NPARCELLS=1000;
NR=400;
NCOND=3; % put here your total conditions
Tmax=144;

% Bandpass filter settings
fnq=1/(2*TR);                 % Nyquist frequency
flp = 0.008;                    % lowpass frequency of filter (Hz)
fhi = 0.08;                    % highpass
Wn=[flp/fnq fhi/fnq];         % butterworth bandpass non-dimensional frequency
k=2;                          % 2nd order butterworth filter
[bfilt,afilt]=butter(k,Wn);   % construct the filter

for i=1:NPARCELLS
    for j=1:NPARCELLS
        rr(i,j)=norm(SchaeferCOG(i,:)-SchaeferCOG(j,:));
    end
end
range=max(max(rr));
delta=range/NR;

for i=1:NR
    xrange(i)=delta/2+delta*(i-1);
end


for cond=1:NCOND
    xs=tseries(:,cond);
    NSUB=size(find(~cellfun(@isempty,xs)),1);
    ensspasub=zeros(NSUB,NPARCELLS);
    DTspatime=zeros(NPARCELLS,Tmax);
    Rsub=zeros(1,NSUB);
    DTsub=zeros(1,NSUB);
    corrfcnsub=zeros(NSUB,NPARCELLS,NR);
    for sub=1:NSUB
        sub
        ts=xs{sub};
        
        for seed=1:NPARCELLS
            ts(seed,:)=detrend(ts(seed,:)-mean(ts(seed,:)));
            signal_filt(seed,:) =filtfilt(bfilt,afilt,ts(seed,:));
        end
        
        fce=corrcoef(signal_filt');
        
        for i=1:NPARCELLS
            numind=zeros(1,NR);
            corrfcn_1=zeros(1,NR);
            for j=1:NPARCELLS
                r=rr(i,j);
                index=floor(r/delta)+1;
                if index==NR+1
                    index=NR;
                end
                mcc=fce(i,j);
                if ~isnan(mcc)
                    corrfcn_1(index)=corrfcn_1(index)+mcc;
                    numind(index)=numind(index)+1;
                end
            end
            corrfcnsub(sub,i,:)=corrfcn_1./numind;
        end
    end
    
    corrfcn=squeeze(nanmean(corrfcnsub));
    
    cd('/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/inputs')
    save (sprintf('empirical_spacorr_rest_cond_%d_ON_tbi_personalized.mat', cond),'corrfcn','corrfcnsub');
end