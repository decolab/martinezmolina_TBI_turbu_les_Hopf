
function hopf_DTI_Grange_tbi_lesions_mask1halfSD_weight(s,condition)

load(sprintf('results_f_diff_fce_cond%d_ON_tbi.mat',condition));
load(sprintf('empirical_spacorr_rest_cond_%d_ON_tbi.mat',condition));
load SClongrange.mat;
load schaefer_MK.mat;
load('tseries_openneuro_tbi_tp123_sch1000.mat');
load('lesion_mask_1andhalfSD_weighted.mat')

%Parameters and G range
xs=tseries(:,condition);
NSUB=size(find(~cellfun(@isempty,xs)),1);
NPARCELLS=size(SchaeferCOG,1);
NR=400;
NRini=20;
NRfin=380;
NSUBSIM=100; %number of iterations, 100 is arbitrary because in this case it is enough
lambda=round(lambda,2);

G_range=0.:0.01:3;

G=G_range(s);

empcorrfcn=corrfcn;

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
Tmax=144;
omega = repmat(2*pi*f_diff',1,2); omega(:,1) = -omega(:,1);
dt=0.1*TR/2;
sig=0.01;
dsig = sqrt(dt)*sig;


corrfcn=zeros(NPARCELLS,NR);
lam_mean_spatime_enstrophy=zeros(NLAMBDA,NPARCELLS,Tmax);
err_hete=zeros(1,NSUBSIM);
InfoFlow=zeros(NSUBSIM,NLAMBDA-1);
InfoCascade=zeros(1,NSUBSIM);
Turbulence=zeros(1,NSUBSIM);
mutinfo=zeros(1,NLAMBDA);

IClong=find(Clong>0);
for i=1:NPARCELLS
    for j=1:NPARCELLS
        C(i,j)=exp(-lambda*rr(i,j));
    end
    C(i,i)=0;
end
C(IClong)=Clong(IClong);

C=C.*lesion_mask_1andhalfSD_weighted;  % MULTIPLY BY LESION MASK AVERAGED ACROSS TBI PATIENTS

factor=max(max(C));
C=C/factor*0.2;

G

%% FROM HERE ON MODEL SIMULATIONS 
for sub=1:NSUBSIM
    sub
    
    wC = G*C;
    sumC = repmat(sum(wC,2),1,2);
    
    %% Hopf Simulation
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
    %% Computing simulated FC
    for seed=1:NPARCELLS
        ts(seed,:)=detrend(ts(seed,:)-mean(ts(seed,:)));
        signal_filt(seed,:) =filtfilt(bfilt,afilt,ts(seed,:));
        Xanalytic = hilbert(demean(signal_filt(seed,:)));
        Phases(seed,:) = angle(Xanalytic);
    end
    fcsimul=corrcoef(signal_filt');
    %% Computing simulated observables 
    for i=1:NPARCELLS
        numind=zeros(1,NR);
        corrfcn_1=zeros(1,NR);
        for j=1:NPARCELLS
            r=rr(i,j);
            index=floor(r/delta)+1;
            if index==NR+1
                index=NR;
            end
            mcc=fcsimul(i,j);
            if ~isnan(mcc)
                corrfcn_1(index)=corrfcn_1(index)+mcc;
                numind(index)=numind(index)+1;
            end
        end
        corrfcn(i,:)=corrfcn_1./numind;
        %%% enstrophy
        ilam=1;
        for lam=LAMBDA
            enstrophy=nansum(repmat(squeeze(C1(ilam,i,:)),1,Tmax).*complex(cos(Phases),sin(Phases)))/sum(C1(ilam,i,:));
            lam_mean_spatime_enstrophy(ilam,i,:)=abs(enstrophy);
            ilam=ilam+1;
        end
    end
    Rspatime=squeeze(lam_mean_spatime_enstrophy(indsca,:,:));
    Rsub=nanstd(Rspatime(:));
        
    ilam=1;
    for lam=LAMBDA
        if ilam>1
            [cc pp]=corr((squeeze(lam_mean_spatime_enstrophy(ilam,:,2:end)))',(squeeze(lam_mean_spatime_enstrophy(ilam-1,:,1:end-1)))');
            mutinfo(ilam)=nanmean(cc(find(pp(:)<0.05)));
        end
        ilam=ilam+1;
    end
    
    %% COMPUTING DIFFERENCE BETWEEN SIMULATED AND EMPIRICAL FC  
    for i=1:NPARCELLS
        for k=NRini:NRfin
            err11(k)=(corrfcn(i,k)-empcorrfcn(i,k))^2;
        end
        err1(i)=(nanmean(err11(NRini:NRfin)));
    end
    err_hete(sub)=sqrt(nanmean(err1));
    
    %% OBSERVABLES
    Inflam2=mutinfo(2:end);
    InfoFlow(sub,:)=Inflam2;
    InfoCascade(sub)=nanmean(Inflam2);
    Turbulence(sub)=Rsub;

end

save(sprintf('WG_%03d_%d_ON_tbi_mask1halfSD_weight.mat',s,condition),'InfoCascade','InfoFlow','Turbulence','err_hete');
