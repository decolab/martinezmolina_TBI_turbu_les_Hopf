function infocapacity_hopf_errorhete_tbi(s,condition)

rng(s);
measure='err_hete'; 

if condition==1
     G=optG_tbicond1; %OptG TBI ses1
elseif condition==2
    G=optG_tbicond2; %OptG TBI ses2
elseif condition==3
     G=optG_tbicond3; %OptG TBI ses3
end

NPARCELLS=1000;
NR=400;
NRini=20;
NRfin=380;
NSUBSIM=100; %number of iterations, 100 is arbitrary because in this case it is enough

load SClongrange.mat; %load structural connectivity with long range connections 
load(sprintf('results_f_diff_fce_cond%d_ON_tbi.mat',condition)); % load frequency with maximal power (of narrowly filtered data) by area computed in script Compute_Hopf_Freq_hc.m
load(sprintf('empirical_spacorr_rest_cond_%d_ON_tbi.mat',condition)); %load empirical FC computed in script Empirical_corrfcn_hc.m
load schaefer_MK.mat; %structural connectivity template from DTI provided by Morten L. Kringelbach
load('lesion_mask_1andhalfSD_weighted.mat') % lesion mask thresholded at 1.5 std and averaged across TBI patients (weighted approach)


lambda=round(lambda,1);

rr=zeros(NPARCELLS,NPARCELLS);
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

Isubdiag = find(tril(ones(NPARCELLS),-1));

C=zeros(NPARCELLS,NPARCELLS);

LAMBDA=[0.27 0.24 0.21 0.18 0.15 0.12 0.09 0.06 0.03 0.01];

NLAMBDA=length(LAMBDA);
C1=zeros(NLAMBDA,NPARCELLS,NPARCELLS);
[aux indsca]=min(abs(LAMBDA-lambda));
ilam=1;
for lambda2=LAMBDA
    for i=1:NPARCELLS
        for j=1:NPARCELLS
            C1(ilam,i,j)=exp(-lambda2*rr(i,j));
        end
    end
    ilam=ilam+1;
end

%% Parameters of the data
TR=2;  % Repetition Time (seconds)

% Bandpass filter settings
fnq=1/(2*TR);                 % Nyquist frequency
flp = 0.008;                    % lowpass frequency of filter (Hz)
fhi = 0.08;                    % highpass
Wn=[flp/fnq fhi/fnq];         % butterworth bandpass non-dimensional frequency
k=2;                          % 2nd order butterworth filter
[bfilt,afilt]=butter(k,Wn);   % construct the filter
Isubdiag = find(tril(ones(NPARCELLS),-1));

%% Parameters HOPF
Tmax=145;
omega = repmat(2*pi*f_diff',1,2); omega(:,1) = -omega(:,1);
dt=0.1*TR/2;
sig=0.01;
dsig = sqrt(dt)*sig;

lam_mean_spatime_enstrophy=zeros(NLAMBDA,NPARCELLS,Tmax);
ensspasub=zeros(NSUBSIM,NPARCELLS);
ensspasub1=zeros(NSUBSIM,NPARCELLS);


IClong=find(Clong>0);
for i=1:NPARCELLS
    for j=1:NPARCELLS
        C(i,j)=exp(-lambda*rr(i,j));
    end
    C(i,i)=0;
end
C(IClong)=Clong(IClong);

C=C.*lesion_mask_1andhalfSD_weighted; D; % MULTIPLY BY LESION MASK AVERAGED ACROSS TBI PATIENTS

factor=max(max(C));
C=C/factor*0.2;

for sub=1:NSUBSIM
    sub    
    wC = G*C;
    sumC = repmat(sum(wC,2),1,2);
    
     %% HOPF SIMULATION
    a=-0.02*ones(NPARCELLS,2);
    xs=zeros(Tmax,NPARCELLS);
    z = 0.1*ones(NPARCELLS,2); % --> x = z(:,1), y = z(:,2)
    nn=0;
    % discard first 2000 time steps
    for t=0:dt:2000
        suma = wC*z - sumC.*z; % sum(Cij*xi) - sum(Cij)*xj
        zz = z(:,end:-1:1); % flipped z, because (x.*x + y.*y)
        z = z + dt*(a.*z + zz.*omega - z.*(z.*z+zz.*zz) + suma) + dsig*randn(NPARCELLS,2);
    end
    % actual modeling (x=BOLD signal (Interpretation), y some other oscillation)
    for t=0:dt:((Tmax-1)*TR)
        suma = wC*z - sumC.*z; % sum(Cij*xi) - sum(Cij)*xj
        zz = z(:,end:-1:1); % flipped z, because (x.*x + y.*y)
        z = z + dt*(a.*z + zz.*omega - z.*(z.*z+zz.*zz) + suma) + dsig*randn(NPARCELLS,2);
        if abs(mod(t,TR))<0.01
            nn=nn+1;
            xs(nn,:)=z(:,1)';
        end
    end
    ts=xs';
    
    %% Compute the Kuramoto local parameter of the unperturbed model
    for seed=1:NPARCELLS
        ts(seed,:)=detrend(ts(seed,:)-mean(ts(seed,:)));
        signal_filt(seed,:) =filtfilt(bfilt,afilt,ts(seed,:));
        Xanalytic = hilbert(demean(signal_filt(seed,:)));
        Phases(seed,:) = angle(Xanalytic);
    end
    
    for i=1:NPARCELLS
        ilam=1;
        for lam=LAMBDA
            enstrophy=nansum(repmat(squeeze(C1(ilam,i,:)),1,Tmax).*complex(cos(Phases),sin(Phases)))/sum(C1(ilam,i,:));
            lam_mean_spatime_enstrophy(ilam,i,:)=abs(enstrophy);
            ilam=ilam+1;
        end
    end
    Rspatime=squeeze(lam_mean_spatime_enstrophy(indsca,:,:));
    ensspasub(sub,:)=(nanmean(Rspatime,2))';
    
      %% HERE WE INTRODUCE THE PERTURBATION
    
    a=-0.02+0.02*repmat(rand(NPARCELLS,1),1,2).*ones(NPARCELLS,2);
    nn=0;
    for t=0:dt:((Tmax-1)*TR)
        suma = wC*z - sumC.*z; % sum(Cij*xi) - sum(Cij)*xj
        zz = z(:,end:-1:1); % flipped z, because (x.*x + y.*y)
        z = z + dt*(a.*z + zz.*omega - z.*(z.*z+zz.*zz) + suma) + dsig*randn(NPARCELLS,2);
        if abs(mod(t,TR))<0.01
            nn=nn+1;
            xs(nn,:)=z(:,1)';
        end
    end
    ts=xs';
    Rspatime1=zeros(NPARCELLS,Tmax);
    
    %% Compute the Kuramoto local order parameter of the perturbed model
    for seed=1:NPARCELLS
        ts(seed,:)=detrend(ts(seed,:)-mean(ts(seed,:)));
        signal_filt(seed,:) =filtfilt(bfilt,afilt,ts(seed,:));
        Xanalytic = hilbert(demean(signal_filt(seed,:)));
        Phases(seed,:) = angle(Xanalytic);
    end
    for i=1:NPARCELLS
        %%% enstrophy
        enstrophy=nansum(repmat(squeeze(C1(indsca,i,:)),1,Tmax).*complex(cos(Phases),sin(Phases)))/sum(C1(indsca,i,:));
        Rspatime1(i,:)=abs(enstrophy);
    end
    ensspasub1(sub,:)=(nanmean(Rspatime1,2))';
end

%% Compute susceptibility and information capacity
infocapacity=nanmean(nanstd(ensspasub1-ones(NSUBSIM,1)*nanmean(ensspasub)));
susceptibility=nanmean(nanmean(ensspasub1-ones(NSUBSIM,1)*nanmean(ensspasub)));

save(sprintf('Wtrials_%03d_%d_%s_ON_tbi_mask1halfSD_weight.mat',s,condition,measure),'infocapacity','susceptibility');
