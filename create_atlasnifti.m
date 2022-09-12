function create_atlasnifti(aalvector,name,symm)
% script to create AAL nifti file for rendering
%  aalvector is a 1x90 vector with a value for each AAL region
%  name is the name of the output file
%  symm is a flag that if >0 means that ordering is symmetrical
addpath('/Users/noeliamartinezmolina/Documents/MATLAB/NIfTI_20140122');
atlasnii=load_nii('/Volumes/LASA/TBI_project/Parcellations/MNI/Schaefer2018_1000Parcels_7Networks_order_FSLMNI152_2mm.nii');

% create new image
newnii=atlasnii;
% set datatype to correct single type (rather than uint8)
newnii.img=zeros(size(atlasnii.img),'single');
%     8 Signed integer                (int32, bitpix=32) % DT_INT32, NIFTI_TYPE_INT32 
newnii.hdr.dime.datatype=16;
newnii.hdr.dime.bitpix=32;

if (symm>0) 
    % convert symmetrical to standard
    aalvals(1:2:1000)=aalvector(1:500);
    aalvals(2:2:1000)=aalvector(1000:-1:501);
else
    aalvals=aalvector;
end

for i=1:1000
    % find the indices of voxels for a given aal region
    vox=find(atlasnii.img==i);
    % set value for each voxel in aal region 
    newnii.img(vox)=aalvals(i);
end


%save new nifti file
save_nii (newnii, name);

