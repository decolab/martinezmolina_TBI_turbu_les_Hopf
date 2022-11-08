%% Turbulence all empirical measurements original
% Analyze turbulence f-rom the TBI dataset in OpenNeuro: <https://openneuro.org/datasets/ds000220/versions/1.0.0/file-display/dataset_description.json 
% https://openneuro.org/datasets/ds000220/versions/1.0.0/file-display/dataset_description.json>

% Load inputs
clear all
cd('/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/inputs');
load sc_schaefer_MK.mat;                                         % Structural connectivity provided by Morten Kringelbach
load('tseries_openneuro_controls_tp1_sch1000.mat')               % Denoised time-series
load ('RSN7vector.mat');                                         % Labels for the 7 RSN (Yeo, 2011)
load('SchaeferCOG.mat');                                         % Center of gravity coordinates in the Schaefer parcellation
labels= Yeo7vector;
addpath('/Users/noeliamartinezmolina/Documents/GitHub/TBI_turbulence_openneuro_current_code/')
addpath('/Users/noeliamartinezmolina/Documents/GitHub/TBI_turbulence_openneuro_current_code/helper functions/')


% Set Parameters
cond=1;                                     % Number of sessions
xs=tseries(:,cond);                         % Time-series
NSUB=size(find(~cellfun(@isempty,xs)),1);   % Total subjects in each group
TR=2;                                       % Repetition Time (seconds), equivalent to the sampling rate
Tmax=144;                                   % Number of resting-state volumes
NPARCELLS=1000;                             % Number of nodes in Schaefer's parcellation
NR=400;                               
NRini=20;
NRfin=80;

LAMBDA=[0.27 0.24 0.21 0.18 0.15 0.12 0.09 0.06 0.03 0.01]; % Range of lambda values in 0.03 steps
NLAMBDA=length(LAMBDA);

% Bandpass filter settings
fnq=1/(2*TR);                 % Nyquist frequency
flp = 0.008;                  % Lowpass frequency of filter (Hz)
fhi = 0.08;                   % Lowpass frequency of filter (Hz)
Wn=[flp/fnq fhi/fnq];         % Butterworth bandpass non-dimensional frequency
k=2;                          % 2nd order butterworth filter
[bfilt,afilt]=butter(k,Wn);   % Construct the filter

% Calculates array of distance between the nodes' centroids
for i=1:NPARCELLS
    for j=1:NPARCELLS
        rr(i,j)=norm(SchaeferCOG(i,:)-SchaeferCOG(j,:)); % Returns the Euclidean norm of vector v or Euclidean length.
    end
end
range=max(max(rr));
delta=range/NR;

for i=1:NR
    xrange(i)=delta/2+delta*(i-1);
end

% Calculates array of exponential decay between nodes for each lambda
C1=zeros(NLAMBDA,NPARCELLS,NPARCELLS);
ilam=1;
for lambda=LAMBDA
    for i=1:NPARCELLS
        for j=1:NPARCELLS
            C1(ilam,i,j)=exp(-lambda*rr(i,j));
        end
    end
    ilam=ilam+1;
end

% Preallocate variables

%intermediate variables
signal_filt=zeros(NPARCELLS,Tmax);
Phases=zeros(NPARCELLS,Tmax);
entropy1=zeros(NLAMBDA,NPARCELLS,Tmax);
fcr=zeros(NLAMBDA,NSUB);
fclam=zeros(NLAMBDA,NPARCELLS,NPARCELLS);

%outputs per subject
Turbulence_sub=zeros(NLAMBDA,NSUB); % Amplitude turbulence
TransferLambda_sub=zeros(NLAMBDA,NSUB); % Information cascade flow
InformationCascade_sub=zeros(1,NSUB); % Information cascade
Transfer_sub=zeros(1,NSUB); %Information transfer

%---------------------------------------------------------------------------------------------------------------------
% Compute observables 

for sub=1:NSUB
    disp(sub)
    NPARCELLS=1000;                             
    ts=tseries{sub,cond};
    clear Phases Xanalytic signal_filt Phases_surrogate

    % Hilbert transform to calculate the instantaneous phases per node
    for seed=1:NPARCELLS
        ts(seed,:)=detrend(ts(seed,:)-mean(ts(seed,:)));                 % Detrend the time-series
        signal_filt(seed,:) =filtfilt(bfilt,afilt,ts(seed,:));           % Zero phase filtering with 2nd-order butterworth filter      
        Xanalytic = hilbert(demean(signal_filt(seed,:)));                % Get the analytic signal
        Phases(seed,:) = angle(Xanalytic);                               % Get the phases from the analytic signal
        % Visualization
%         figure,plot(ts(seed,:),'r'), hold on, plot(signal_filt(seed,:),'b'), title('Signal filtering'), legend('signal','signal filtered')
%         figure,plot(real(Xanalytic),'r'), hold on, plot(imag(Xanalytic),'b'), title('Hilbert transform'), legend('real','imag')
%         figure,plot3(1:Tmax, real(Xanalytic),imag(Xanalytic)), title('Hilbert transform 3d')
%         xlabel('Time(ms)'),ylabel('Real'),zlabel('Imag')
%         axis tight
%         rotate3d
    end

    % Calculate Kuramoto LOCAL order parameter for all nodes
    for i=1:NPARCELLS
        for ilam=1:NLAMBDA
            C1lam=squeeze(C1(ilam,:,:));
            sumphases=nansum(repmat(C1lam(i,:)',1,Tmax).*complex(cos(Phases),sin(Phases)))/nansum(C1lam(i,:));
            entropy1(ilam,i,:)=abs(sumphases); % Kuramoto local order parameter
            Turbulence_node_sub(ilam,i,sub)=nanstd(entropy1(ilam,i,:)); %Amplitude turbulence (std of Kuramoto local order parameter per node across timepoints)
        end
    end
    cd ('/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/')
  save (sprintf('entropy1_openneuro_hc_con%d_sub%d.mat',cond,sub),'entropy1')
end

cd ('/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/')
%save (sprintf('turbu_by_node_openneuro_tbi_con%d.mat',cond),'Turbulence_node_sub')