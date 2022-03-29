function turbulence_node_empirical_metaesta_RSN(cond)

cd('/Volumes/LaCie/TBI_project/timeseries/pre_post_schaefer1000/inputs/');
load sc_schaefer_MK.mat; % Markov-Kennedy
load('tseries_TBI_prepost_sch1000.mat')
load ('RSN7vector.mat');
load('SchaeferCOG.mat');
labels= Yeo7vector;


% Parameters of the data
xs=tseries(:, cond);                         %
NSUB=size(find(~cellfun(@isempty,xs)),1);   % Total subjects in each group
TR=2;                                       % Repetition Time (seconds)
Tmax=145;                                % Timepoints
NPARCELLS=1000;                       % Atlas Schaefer 1000 nodes
NR=400;                                    %?
NRini=20;                                   %?
NRfin=80;                                   %?

LAMBDA=[0.27 ];%0.24 0.21 0.18 0.15 0.12 0.09 0.06 0.03 0.01];
NLAMBDA=length(LAMBDA);

% Bandpass filter settings
fnq=1/(2*TR);                 % Nyquist frequency
flp = 0.008;                  % lowpass frequency of filter (Hz)
fhi = 0.08;                   % highpass
Wn=[flp/fnq fhi/fnq];         % butterworth bandpass non-dimensional frequency
k=2;                          % 2nd order butterworth filter
[bfilt,afilt]=butter(k,Wn);   % construct the filter

% Calculates array of distance between the nodes' centroids
for i=1:NPARCELLS
    for j=1:NPARCELLS
        rr(i,j)=norm(SchaeferCOG(i,:)-SchaeferCOG(j,:)); %matriz de distancia entre centroides de nodos. norm calcula la distancia Euclidea entre dos puntos. 
    end
end
range=max(max(rr));
delta=range/NR;

for i=1:NR
    xrange(i)=delta/2+delta*(i-1);
end

% Calculates array of exponential decay between nodes
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

% Initialize variables
entropy=zeros(NLAMBDA,NPARCELLS,Tmax);
entropy_surrogate=zeros(NLAMBDA,NPARCELLS,Tmax);

signal_filt=zeros(NPARCELLS,Tmax);

Phases=zeros(NPARCELLS,Tmax);
Phases_surrogate=zeros(NPARCELLS,Tmax);

TransferLambda_sub=zeros(NLAMBDA,NSUB);

Turbulence_sub=zeros(NLAMBDA,NSUB);
node_Turbulence_sub=zeros(NLAMBDA,NSUB,NPARCELLS);

InformationCascade_sub=zeros(1,NSUB);

Transfer_sub=zeros(1,NSUB);

TransferLambda_su_sub=zeros(NLAMBDA,NSUB);
Turbulence_su_sub=zeros(NLAMBDA,NSUB);

fcr=zeros(NLAMBDA,NSUB);
fcr_surrogate=zeros(NLAMBDA,NSUB);

fclam=zeros(NLAMBDA,NPARCELLS,NPARCELLS);
fclam_surrogate=zeros(NLAMBDA,NPARCELLS,NPARCELLS);


for sub=1:NSUB
    NPARCELLS=1000;                             % Atlas schaefer 1000 nodes
    ts=tseries{sub,cond};
    clear Phases Xanalytic signal_filt Phases_su
    
    % Calculate Hilbert Phase
    for seed=1:NPARCELLS
        ts(seed,:)=detrend(ts(seed,:)-mean(ts(seed,:)));
        signal_filt(seed,:) =filtfilt(bfilt,afilt,ts(seed,:)); %Zero phase filtering
        Xanalytic = hilbert(demean(signal_filt(seed,:)));
        Phases(seed,:) = angle(Xanalytic);
        Phases_su(seed,:)=Phases(seed,randperm(Tmax)); %su=suffle
    end

    for i=1:NPARCELLS
        for ilam=1:NLAMBDA
            C1lam=squeeze(C1(ilam,:,:));
            sumphases=nansum(repmat(C1lam(i,:)',1,Tmax).*complex(cos(Phases),sin(Phases)))/nansum(C1lam(i,:));
            entropy1(ilam,i,:)=abs(sumphases);
        end
    end
    TransferLambda_sub(1,:)=NaN;
    
    % Calculate turbulence
    for ii=1:7
        indx_rsn=find(labels(:,1)==ii);
        NPARCELLS=size(indx_rsn,1);
        clear entropy
        for ilam=1:NLAMBDA
            entropy(ilam,:,:) = entropy1(ilam,indx_rsn,:); %Kuramoto module
            TurbulenceRSN_sub(ilam,sub,ii)=nanstd(squeeze(entropy(ilam,:))); %turbulence for each network (based on Kuramoto module for all 1000 nodes but STD from the nodes)
            Turbulence_global_sub(ilam,sub)=nanstd(squeeze(entropy1(ilam,:)));
        end
        
        
        gKoPRSN(sub,ii)=nanmean(abs(sum(complex(cos(Phases(indx_rsn,:)),sin(Phases(indx_rsn,:))),1))/NPARCELLS); %global Kuramoto parameter (synchronization)
        MetaRSN(sub,ii) = nanstd(abs(sum(complex(cos(Phases(indx_rsn,:)),sin(Phases(indx_rsn,:))),1))/NPARCELLS); %global metastability
        
    end
        
        gKoP(sub)=nanmean(abs(sum(complex(cos(Phases(:,:)),sin(Phases(:,:))),1))/NPARCELLS); %global Kuramoto parameter (synchronization)
        Meta(sub) = nanstd(abs(sum(complex(cos(Phases(:,:)),sin(Phases(:,:))),1))/NPARCELLS); %global metastability
 
          
    % Calculate info flow and info cascade
    for ilam=1:NLAMBDA-1
        [cc pp]=corr(squeeze(entropy(ilam+1,:,2:end))',squeeze(entropy(ilam,:,1:end-1))');
        TransferLambda_sub(ilam+1,sub)=nanmean(abs(cc(find(pp(:)<0.05)))); %info flow
        %surrogates
        %[cc pp]=corr(squeeze(entropy_su(ilam+1,:,2:end))',squeeze(entropy_su(ilam,:,1:end-1))');
        %TransferLambda_su_sub(ilam+1,sub)=nanmean(abs(cc(find(pp(:)<0.05))));
    end
    
    InformationCascade_sub(sub)=nanmean(TransferLambda_sub(2:NLAMBDA,sub),1);
    
    % Transfer across space
    clear fclam
    for ilam=1:NLAMBDA
        fclam(ilam,:,:)=corrcoef(squeeze(entropy1(ilam,:,:))');
        fclam_su(ilam,:,:)=corrcoef(squeeze(entropy_su(ilam,:)'));
    end
    
    
    for lam=1:NLAMBDA
        numind=zeros(1,NR);
        fcra=zeros(1,NR);
        for i=1:NPARCELLS
            for j=1:NPARCELLS
                r=rr(i,j); %matriz de distancia entre centroides de nodos
                index=floor(r/delta)+1;
                if index==NR+1
                    index=NR;
                end
                mcc=fclam(lam,i,j);
                if ~isnan(mcc)
                    fcra(index)=fcra(index)+mcc;
                    numind(index)=numind(index)+1;
                end
            end
        end
        %%% Powerlaw a
        
        grandcorrfcn=fcra./numind; %matriz de corr de Kuramoto por nodo en función de la distancia
        clear xcoor;
        clear ycoor;
        nn=1;
        indxx = find(~isnan(grandcorrfcn));
        indices = indxx(indxx>NRini & indxx<NRfin);
        for k=1:length(indices)
            if grandcorrfcn(k)>0
                xcoor(nn)=log(xrange(k));
                ycoor(nn)=log(grandcorrfcn(k)/grandcorrfcn(indices(1)));
                nn=nn+1;
            end
            
        end
        linfunc = @(A, x)(A(1)*x+A(2));
        options=optimset('MaxFunEvals',10000,'MaxIter',1000,'Display','off');
        A0=[-1 1];
        [Afit Residual]= lsqcurvefit(linfunc,A0,xcoor,ycoor,[-4 -10],[4 10],options);
        Transfer_sub(lam,sub)=abs(Afit(1));
        
    end
end

cd ('F:\turbulence\timeseries\pre_post_schaefer1000\outputs')
save (sprintf('turbu_measurements%d_RSN.mat',cond), 'LAMBDA','TurbulenceRSN_sub','Turbulence_global_sub', 'Transfer_sub', 'InformationCascade_sub', 'TransferLambda_sub','gKoPRSN','MetaRSN','gKoP','Meta');
