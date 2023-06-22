clear ()
close ()
code_path='/Volumes/LASA/TBI_OpenNeuro/Shared_code/TBI_ON_Lesions/';
addpath(code_path)
data_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/data/lesions/overlap_Schaefer/Schaefer400_wotbi09/';
cd (data_path)
table_overlap_volume=import_overlap_volume_Sch400('overlap_volume_combined.txt');
overlap_vol_all_patients=table_overlap_volume.VarName1; % N=10 patients with lesion masks
table_Schaefer_volume=import_schaefer_volume_400('Schaefer_volume_combined.txt');
Schaefer_volume=table_Schaefer_volume.VarName1;

%Calculate percent overlap with Schaefer parcel
Schaefer_parcel=reshape(repmat(1:400,10,1), [4000 1]);
Schaefer_volume=reshape(repmat(Schaefer_volume',10,1), [4000 1]);
overlap_vol_all_patients(:,2)=(overlap_vol_all_patients./Schaefer_volume)*100;

%Find nodes with >XSD percent overlap with Schaefer parcel
idx=find(overlap_vol_all_patients(:,2));
mean_nnz=mean(overlap_vol_all_patients(idx,2));
std_nnz=std(overlap_vol_all_patients(idx,2));
idx_1andhalfstd=find(overlap_vol_all_patients(:,2)>mean_nnz+1.5*std_nnz);
idx_2std=find(overlap_vol_all_patients(:,2)>mean_nnz+2*std_nnz);
idx_3std=find(overlap_vol_all_patients(:,2)>mean_nnz+3*std_nnz);
idx_4std=find(overlap_vol_all_patients(:,2)>mean_nnz+4*std_nnz);

nodes2attack_1andhalfstd=Schaefer_parcel(idx_1andhalfstd,1);
nodes2attack_2std=Schaefer_parcel(idx_2std,1);
nodes2attack_3std=Schaefer_parcel(idx_3std,1);
nodes2attack_4std=Schaefer_parcel(idx_4std,1);

% Option A: Create binary lesion mask to attack connectivity matrix

lesion_mask_1andhalfSD=ones(400,400);
lesion_mask_1andhalfSD(:, nodes2attack_1andhalfstd)=0; lesion_mask_1andhalfSD(nodes2attack_1andhalfstd, :)=0;
figure
imagesc(lesion_mask_1andhalfSD); colorbar
title('Lesion mask 1andhalf SD')
save('lesion_mask_1andhalfSD.mat','lesion_mask_1andhalfSD')
saveas(gcf,'lesion_mask_1andhalfSD.fig')

lesion_mask_2SD=ones(400,400);
lesion_mask_2SD(:, nodes2attack_2std)=0; lesion_mask_2SD(nodes2attack_2std, :)=0;
figure
imagesc(lesion_mask_2SD); colorbar
title('Lesion mask 2SD')
save('lesion_mask_2SD.mat','lesion_mask_2SD')
saveas(gcf,'lesion_mask_2SD.fig')

lesion_mask_3SD=ones(400,400);
lesion_mask_3SD(:, nodes2attack_3std)=0; lesion_mask_3SD(nodes2attack_3std, :)=0;
figure
imagesc(lesion_mask_3SD); colorbar
title('Lesion mask 3SD')
save('lesion_mask_3SD.mat','lesion_mask_3SD')
saveas(gcf,'lesion_mask_3SD.fig')

lesion_mask_4SD=ones(400,400);
lesion_mask_4SD(:, nodes2attack_4std)=0; lesion_mask_4SD(nodes2attack_4std, :)=0;
figure
imagesc(lesion_mask_4SD); colorbar
title('Lesion mask 4SD')
save('lesion_mask_4SD.mat','lesion_mask_4SD')
saveas(gcf,'lesion_mask_4SD.fig')

% Option B: Create weighted lesion mask to attack connectivity matrix
% based on number of patients with lesions

% Find frequency of patients with lesioned parcels
tbi_patients=12;
[nodesattack_excludingrep,ia,ic] = unique(nodes2attack_1andhalfstd); 
for k=1:numel(nodesattack_excludingrep)
frequency(k)=length(find(nodes2attack_1andhalfstd==nodesattack_excludingrep(k)));
end
frequency=frequency';

lesion_mask_1andhalfSD_weighted=ones(400,400);
for n=1:numel(nodesattack_excludingrep)
    range_weights=(1:1:max(frequency));
    for w=1:numel(range_weights)
        if frequency(n)==range_weights(w)
            lesion_mask_1andhalfSD_weighted(nodesattack_excludingrep(n),:)=1-(range_weights(w)/tbi_patients); lesion_mask_1andhalfSD_weighted(:,nodesattack_excludingrep(n))=1-(range_weights(w)/tbi_patients);
        end
    end
end

figure
imagesc(lesion_mask_1andhalfSD_weighted); colorbar
title('Lesion mask 1andhalf SD_weighted')
save('lesion_mask_1andhalfSD_weighted.mat','lesion_mask_1andhalfSD_weighted')
saveas(gcf,'lesion_mask_1andhalfSD_weighted.fig')

clear nodesattack_excludingrep frequency ia ic range_weights

tbi_patients=12;
[nodesattack_excludingrep,ia,ic] = unique(nodes2attack_2std); 
for k=1:numel(nodesattack_excludingrep)
frequency(k)=length(find(nodes2attack_2std==nodesattack_excludingrep(k)));
end
frequency=frequency';

lesion_mask_2SD_weighted=ones(400,400);
for n=1:numel(nodesattack_excludingrep)
    range_weights=(1:1:max(frequency));
    for w=1:numel(range_weights)
        if frequency(n)==range_weights(w)
            lesion_mask_2SD_weighted(nodesattack_excludingrep(n),:)=1-(range_weights(w)/tbi_patients); lesion_mask_2SD_weighted(:,nodesattack_excludingrep(n))=1-(range_weights(w)/tbi_patients);
        end
    end
end

figure
imagesc(lesion_mask_2SD_weighted); colorbar
title('Lesion mask 2SD_weighted')
save('lesion_mask_2SD_weighted.mat','lesion_mask_2SD_weighted')
saveas(gcf,'lesion_mask_2SD_weighted.fig')


clear nodesattack_excludingrep frequency ia ic range_weights

tbi_patients=12;
[nodesattack_excludingrep,ia,ic] = unique(nodes2attack_3std); 
for k=1:numel(nodesattack_excludingrep)
frequency(k)=length(find(nodes2attack_3std==nodesattack_excludingrep(k)));
end
frequency=frequency';

lesion_mask_3SD_weighted=ones(400,400);
for n=1:numel(nodesattack_excludingrep)
    range_weights=(1:1:max(frequency));
    for w=1:numel(range_weights)
        if frequency(n)==range_weights(w)
            lesion_mask_3SD_weighted(nodesattack_excludingrep(n),:)=1-(range_weights(w)/tbi_patients); lesion_mask_3SD_weighted(:,nodesattack_excludingrep(n))=1-(range_weights(w)/tbi_patients);
        end
    end
end

figure
imagesc(lesion_mask_3SD_weighted); colorbar
title('Lesion mask 3SD_weighted')
save('lesion_mask_3SD_weighted.mat','lesion_mask_3SD_weighted')
saveas(gcf,'lesion_mask_3SD_weighted.fig')

tbi_patients=12;
[nodesattack_excludingrep,ia,ic] = unique(nodes2attack_2std); 
for k=1:numel(nodesattack_excludingrep)
frequency(k)=length(find(nodes2attack_4std==nodesattack_excludingrep(k)));
end
frequency=frequency';

lesion_mask_4SD_weighted=ones(400,400);
for n=1:numel(nodesattack_excludingrep)
    range_weights=(1:1:max(frequency));
    for w=1:numel(range_weights)
        if frequency(n)==range_weights(w)
            lesion_mask_4SD_weighted(nodesattack_excludingrep(n),:)=1-(range_weights(w)/tbi_patients); lesion_mask_4SD_weighted(:,nodesattack_excludingrep(n))=1-(range_weights(w)/tbi_patients);
        end
    end
end

figure
imagesc(lesion_mask_4SD_weighted); colorbar
title('Lesion mask 4SD_weighted')
save('lesion_mask_4SD_weighted.mat','lesion_mask_4SD_weighted')
saveas(gcf,'lesion_mask_4SD_weighted.fig')


