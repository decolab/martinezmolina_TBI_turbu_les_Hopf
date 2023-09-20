function create_schaefer1000_gifti(schaefer1000vector,name)
% script to create schaefer1000 gifti files for rendering
%  schaefer1000vector is a 1x1000 vector with a value for each schaefer1000 region
%  name is the base name of the output file (without .func.gii)

base='/Volumes/LASA/TBI_OpenNeuro/Shared_code/Turbulence/TBI_turbulence_current_code/RenderSurface/render_utils/';
atlas_l=gifti([base 'Schaefer1000_L.func.gii']);
atlas_r=gifti([base 'Schaefer1000_R.func.gii']);
label=ft_read_cifti([base 'Schaefer2018_1000Parcels_7Networks_order.dscalar.nii']);

out_l=atlas_l;
out_r=atlas_r;

% correcting zero values for rendering in connectome workbench
[val vidx]=find(schaefer1000vector==0);
%schaefer1000vector(vidx)=-0.0000001;

% left hemisphere
for i=1:500
    idx=find(atlas_l.cdata==i);
    out_l.cdata(idx)=schaefer1000vector(i);
end;

% right hemisphere
for i=501:1000
    idx=find(atlas_r.cdata==i);
    out_r.cdata(idx)=schaefer1000vector(i);
end;

save(out_l,[name '_left.func.gii'],'Base64Binary');
save(out_r,[name '_right.func.gii'],'Base64Binary');
