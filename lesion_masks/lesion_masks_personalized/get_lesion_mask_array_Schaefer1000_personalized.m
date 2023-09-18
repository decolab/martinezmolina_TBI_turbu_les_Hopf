clear ()
close ()
code_path='/Volumes/LASA/TBI_OpenNeuro/Shared_code/TBI_ON_Lesions_corr/';
addpath(code_path)
data_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/data/lesions/overlap_Schaefer/Schaefer1000_wotbi09/';
cd (data_path)
table_overlap_volume_tbi02=import_overlap_volume_Sch1000_tbi02('overlap_volume_combined_wsub-tbi02.txt'); %sub1
table_overlap_volume_tbi03=import_overlap_volume_Sch1000_tbi03('overlap_volume_combined_wsub-tbi03.txt'); %sub2
table_overlap_volume_tbi04=import_overlap_volume_Sch1000_tbi04('overlap_volume_combined_wsub-tbi04.txt'); %sub3
table_overlap_volume_tbi05=import_overlap_volume_Sch1000_tbi05('overlap_volume_combined_wsub-tbi05.txt'); %sub4
table_overlap_volume_tbi06=import_overlap_volume_Sch1000_tbi06('overlap_volume_combined_wsub-tbi06.txt'); %sub5
table_overlap_volume_tbi07=import_overlap_volume_Sch1000_tbi07('overlap_volume_combined_wsub-tbi07.txt'); %sub6
table_overlap_volume_tbi08=import_overlap_volume_Sch1000_tbi08('overlap_volume_combined_wsub-tbi08.txt'); %sub7
table_overlap_volume_tbi10=import_overlap_volume_Sch1000_tbi10('overlap_volume_combined_wsub-tbi10.txt'); %sub8
table_overlap_volume_tbi11=import_overlap_volume_Sch1000_tbi11('overlap_volume_combined_wsub-tbi11.txt'); %sub9
table_overlap_volume_tb14=import_overlap_volume_Sch1000_tbi14('overlap_volume_combined_wsub-tbi14.txt'); %sub10
table_overlap_volume= vertcat(table_overlap_volume_tbi02,table_overlap_volume_tbi03,table_overlap_volume_tbi04,table_overlap_volume_tbi05,table_overlap_volume_tbi06,table_overlap_volume_tbi07,table_overlap_volume_tbi08,table_overlap_volume_tbi10,table_overlap_volume_tbi11,table_overlap_volume_tb14);

overlap_vol_all_patients=table_overlap_volume.VarName1; % N=10 patients with lesion masks
table_Schaefer_volume=import_schaefer_volume_1000('Schaefer_volume_combined.txt');
Schaefer_volume=table_Schaefer_volume.VarName1;

%Calculate percent overlap with Schaefer parcel
Schaefer_parcel=reshape(repmat(1:1000,10,1)', [10000 1]);
Schaefer_volume=reshape(repmat(Schaefer_volume,10,1), [10000 1]);
overlap_vol_all_patients(:,2)=(overlap_vol_all_patients./Schaefer_volume)*100;

%Find nodes with >XSD percent overlap with Schaefer parcel per subject
overlap_vol_sub=reshape(overlap_vol_all_patients(:,2), [1000 10]); %N=10 TBI patients with lesions
% Initiate lesion mask and nodes2attack arrays 
lesion_mask_1andhalfSD_sub=ones(10,1000,1000);
lesion_mask_2SD_sub=ones(10,1000,1000);
lesion_mask_3SD_sub=ones(10,1000,1000);
lesion_mask_4SD_sub=ones(10,1000,1000);

nodes2attack_1andhalfstd_sub=zeros(1000,10);
nodes2attack_2std_sub=zeros(1000,10);
nodes2attack_3std_sub=zeros(1000,10);
nodes2attack_4std_sub=zeros(1000,10);

for sbj=1:10 % N=10 TBI patients
idx=find(overlap_vol_sub(:,sbj));
mean_nnz=mean(overlap_vol_sub(idx,sbj));
std_nnz=std(overlap_vol_sub(idx,sbj));
idx_1andhalfstd=find(overlap_vol_sub(:,sbj)>mean_nnz+1.5*std_nnz);
idx_2std=find(overlap_vol_sub(:,sbj)>mean_nnz+2*std_nnz);
idx_3std=find(overlap_vol_sub(:,sbj)>mean_nnz+3*std_nnz);
idx_4std=find(overlap_vol_sub(:,sbj)>mean_nnz+4*std_nnz);

nodes2attack_1andhalfstd_sub(idx_1andhalfstd,sbj)=1;
nodes2attack_2std_sub(idx_2std,sbj)=1;
nodes2attack_3std_sub(idx_3std,sbj)=1;
nodes2attack_4std_sub(idx_4std,sbj)=1;

% Create binary lesion mask to attack connectivity matrix (if idx empty all
%  values in the lesion mask remain 1)

lesion_mask_1andhalfSD_sub(sbj,:, idx_1andhalfstd)=0; 
lesion_mask_1andhalfSD_sub(sbj,idx_1andhalfstd, :)=0;
figure
imagesc(squeeze(lesion_mask_1andhalfSD_sub(sbj,:,:)));
clims=[0 1]; colorbar
title(['Lesion mask 1andhalf SD sub ' num2str(sbj)])
saveas(gcf,sprintf('lesion_mask_1andhalfSD_sub_%d.fig',sbj))


lesion_mask_2SD_sub(sbj,:, idx_2std)=0; lesion_mask_2SD_sub(sbj,idx_2std, :)=0;
figure
imagesc(squeeze(lesion_mask_2SD_sub(sbj,:,:))); 
clims=[0 1]; colorbar
title(['Lesion mask 2 SD sub ' num2str(sbj)])
saveas(gcf,sprintf('lesion_mask_2SD_sub_%d.fig',sbj))


lesion_mask_3SD_sub(sbj,:, idx_3std)=0; lesion_mask_3SD_sub(sbj,idx_3std, :)=0;
figure
imagesc(squeeze(lesion_mask_3SD_sub(sbj,:,:))); 
clims=[0 1]; colorbar
title(['Lesion mask 3 SD sub ' num2str(sbj)])
saveas(gcf,sprintf('lesion_mask_3SD_sub_%d.fig',sbj))


lesion_mask_4SD_sub(sbj,:, idx_4std)=0; lesion_mask_4SD_sub(sbj,idx_4std, :)=0;
figure
imagesc(squeeze(lesion_mask_4SD_sub(sbj,:,:))); 
clims=[0 1]; colorbar
title(['Lesion mask 4 SD sub ' num2str(sbj)])
saveas(gcf,sprintf('lesion_mask_4SD_sub_%d.fig',sbj))

end

cd (code_path)
save('lesion_mask_1andhalfSD_sub.mat', 'lesion_mask_1andhalfSD_sub')
save('nodes2attack_1andhalfSD_sub.mat','nodes2attack_1andhalfstd_sub')
save('lesion_mask_2SD_sub.mat', 'lesion_mask_1andhalfSD_sub')
save('nodes2attack_2SD_sub.mat','nodes2attack_1andhalfstd_sub')
save('lesion_mask_3SD_sub.mat', 'lesion_mask_1andhalfSD_sub')
save('nodes2attack_3SD_sub.mat','nodes2attack_1andhalfstd_sub')
save('lesion_mask_4SD_sub.mat', 'lesion_mask_1andhalfSD_sub')
save('nodes2attack_4SD_sub.mat','nodes2attack_1andhalfstd_sub')

%% Add subjects with no lesion mask (sub-01 no visible lesions & sub-09 excluded for misalignment after normalization)

lesion_mask_1andhalfSD_sub_N12=ones(12,1000,1000);
lesion_mask_2SD_sub_N12=ones(12,1000,1000);
lesion_mask_3SD_sub_N12=ones(12,1000,1000);
lesion_mask_4SD_sub_N12=ones(12,1000,1000);

for sles=1:10
    if sles < 8
    lesion_mask_1andhalfSD_sub_N12(1+sles,:,:)=lesion_mask_1andhalfSD_sub(sles,:,:);
    lesion_mask_2SD_sub_N12(1+sles,:,:)=lesion_mask_2SD_sub(sles,:,:);
    lesion_mask_3SD_sub_N12(1+sles,:,:)=lesion_mask_3SD_sub(sles,:,:);
    lesion_mask_4SD_sub_N12(1+sles,:,:)=lesion_mask_4SD_sub(sles,:,:);
    elseif sles >=8
            lesion_mask_1andhalfSD_sub_N12(2+sles,:,:)=lesion_mask_1andhalfSD_sub(sles,:,:);
    lesion_mask_2SD_sub_N12(2+sles,:,:)=lesion_mask_2SD_sub(sles,:,:);
    lesion_mask_3SD_sub_N12(2+sles,:,:)=lesion_mask_3SD_sub(sles,:,:);
    lesion_mask_4SD_sub_N12(2+sles,:,:)=lesion_mask_4SD_sub(sles,:,:);
    end
end

save('lesion_mask_1andhalfSD_sub_N12.mat', 'lesion_mask_1andhalfSD_sub_N12')
save('lesion_mask_2SD_sub_N12.mat', 'lesion_mask_2SD_sub_N12')
save('lesion_mask_3SD_sub_N12.mat', 'lesion_mask_3SD_sub_N12')
save('lesion_mask_4SD_sub_N12.mat', 'lesion_mask_4SD_sub_N12')






