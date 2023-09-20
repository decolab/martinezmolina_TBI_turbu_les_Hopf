function rendersurface_aal90_gifti(aalvector, symm, rangemin, rangemax, inv, clmap, surfacetype)
% script to render aal90 on inflated brain
%   ML Kringelbach April 2020
%
% Parameters:
%
% aalvector : 1x90 vector
% 
% symm : 1 if ordering is symmetrical
% rangemin, rangemax : limits for colorscheme
%
% inv :
%  0 colormap, interp
%  1 flip colormap, interp
%  2 colormap, only three colours
%  3 special colormap, four colours
%
% clmap : from othercolor, 
defaultclmap = 'YlOrRd5';
%
% surfacetype : 
%  1 midthickness
%  2 inflated (default)
%  3 very inflated

% use parameters
if ~exist('rangemin','var')
     rangemin=min(aalvector);
end

if ~exist('rangemax','var')
     rangemax=max(aalvector);
end

if ~exist('inv','var')
     inv=max(aalvector);
end

% colormap (from othercolor)
if ~exist('clmap','var')
    clmap=defaultclmap;
end

% setup surfacetype
if ~exist('surfacetype','var')
     surfacetype=1; % default is normal
end;


basedir='C:\Users\yonis\Documents\Laburo\PostDoc\Turbulence\RenderSurface\render_utils\';
glassers_L=gifti([basedir 'Glasser360.L.mid.32k_fs_LR.surf.gii']);
glassersi_L=gifti([basedir 'Glasser360.L.inflated.32k_fs_LR.surf.gii']);
glassersvi_L=gifti([basedir 'Glasser360.L.very_inflated.32k_fs_LR.surf.gii']);
glassersf_L=gifti([basedir 'Glasser360.L.flat.32k_fs_LR.surf.gii']);
glassers_R=gifti([basedir 'Glasser360.R.mid.32k_fs_LR.surf.gii']);
glassersi_R=gifti([basedir 'Glasser360.R.inflated.32k_fs_LR.surf.gii']);
glassersvi_R=gifti([basedir 'Glasser360.R.very_inflated.32k_fs_LR.surf.gii']);
glassersf_R=gifti([basedir 'Glasser360.R.flat.32k_fs_LR.surf.gii']);

switch surfacetype
    case 1
        display_surf_left=glassers_L;
        display_surf_right=glassers_R;
    case 2
        display_surf_left=glassersi_L;
        display_surf_right=glassersi_R;
    case 3
        display_surf_left=glassersvi_L;
        display_surf_right=glassersvi_R;
end;
sl = display_surf_left;
sr = display_surf_right;

aaldir='C:\Users\yonis\Documents\Laburo\PostDoc\Turbulence\RenderSurface\render_utils\';
label_L=gifti([aaldir 'fsaverage.L.AAL90_Atlas.32k_fs_LR.shape.gii']);
label_R=gifti([aaldir 'fsaverage.R.AAL90_Atlas.32k_fs_LR.shape.gii']);
aal90_L=gifti([aaldir 'aal90_left.func.gii']);
aal90_R=gifti([aaldir 'aal90_right.func.gii']);
aal90_L.cdata=single(label_L.cdata);
aal90_R.cdata=single(label_R.cdata);

vl=aal90_L;
vr=aal90_R;

currentvec=aalvector;

%% full brain rendering

aal=[1:90];
subcor=[37,38,41,42,71,72,73,74,75,76,77,78];
% There are 41 areas in the gifti parcellation
% the correspondence is as follows 
aal_L=[1:2:69 79:2:90]; 
aal_R=aal_L+1;
aalG=[1 2 13 3 14 4 5 6 7 8 15 9 10 11 16 17 18 19 20 21 12 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41];

if (symm>0) 
    % convert symmetrical to standard
    aalvals(1:2:90)=aalvector(1:45);
    aalvals(2:2:90)=aalvector(90:-1:46);
else
    % standard ordering
    aalvals=aalvector;
end;

for i=1:41
    idx{i}=find(label_L.cdata==aalG(i));
    vl.cdata(idx{i})=aalvals(aal_L(i));
end;

% replace right hemisphere labels with correct values from
for i=1:41
    idx{i}=find(label_R.cdata==aalG(i));
    vr.cdata(idx{i})=aalvals(aal_R(i));
end;

% remove -1 from labels
idx{i}=find(aal90_L.cdata==0);
vl.cdata(idx{i})=-1;
idx{i}=find(aal90_R.cdata==0);
vr.cdata(idx{i})=-1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% render whole brain from above

make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.01 0.05], [0.1 0.01], [0.1 0.01]);
if ~make_it_tight,  clear subplot;  end

    % create figure
    hfig = figure;
    set(gcf, 'Position',  [100, 100, 400, 600]);
    
    subplot(3,2,1); %left hemisphere side view
    ax2=gca;
    axis(ax2,'equal');
    axis(ax2,'off');
    s(1) = patch(ax2,'Faces',sl.faces,'vertices',sl.vertices, 'FaceVertexCData', vl.cdata, 'FaceColor','interp', 'EdgeColor', 'none');
    set(ax2,'CLim',[rangemin rangemax]);
    view(-90,0);
    camlight;
    lighting gouraud;
    material dull;


    subplot(3,2,3); %left hemisphere midline
    ax2=gca;
    axis(ax2,'equal');
    axis(ax2,'off');
    s(1) = patch(ax2,'Faces',sl.faces,'vertices',sl.vertices, 'FaceVertexCData', vl.cdata, 'FaceColor','interp', 'EdgeColor', 'none');
    set(ax2,'CLim',[rangemin rangemax]);
    view(90,0)
    camlight;
    lighting gouraud;
    material dull;

    subplot(3,2,4); %right hemisphere side view
    ax2=gca;
    axis(ax2,'equal');
    axis(ax2,'off');
    s(2) = patch(ax2,'Faces',sr.faces,'vertices',sr.vertices, 'FaceVertexCData', vr.cdata, 'FaceColor','interp', 'EdgeColor', 'none');
    set(ax2,'CLim',[rangemin rangemax]);
    view(-90,0)
    camlight;
    lighting gouraud;
    material dull;
 
    subplot(3,2,2); %right hemisphere midline
    ax2=gca;
    axis(ax2,'equal');
    axis(ax2,'off');
    s(2) = patch(ax2,'Faces',sr.faces,'vertices',sr.vertices, 'FaceVertexCData', vr.cdata, 'FaceColor','interp', 'EdgeColor', 'none');
    set(ax2,'CLim',[rangemin rangemax]);
    view(90,0)
    camlight;
    lighting gouraud;
    material dull;

    % flatmaps
    sl=glassersf_L;
    sr=glassersf_R;
    
    subplot(3,2,5); %left hemisphere flat
    ax2=gca;
    axis(ax2,'equal');
    axis(ax2,'off');
    s(2) = patch(ax2,'Faces',sl.faces,'vertices',sl.vertices, 'FaceVertexCData', vl.cdata, 'FaceColor','interp', 'EdgeColor', 'none');
    set(ax2,'CLim',[rangemin rangemax]);
    view(0,90)
    camlight;
    lighting gouraud;
    material dull;
    %colorbar('southoutside');

    subplot(3,2,6); %right hemisphere flat
    ax2=gca;
    axis(ax2,'equal');
    axis(ax2,'off');
    s(2) = patch(ax2,'Faces',sr.faces,'vertices',sr.vertices, 'FaceVertexCData', vr.cdata, 'FaceColor','interp', 'EdgeColor', 'none');
    set(ax2,'CLim',[rangemin rangemax]);
    view(0,90)
    camlight;
    lighting gouraud;
    material dull;
    colorbar('southoutside');

% setup colormap
switch inv
    case 0
        % use selected colormap (interpolated to 64 values)
        c=othercolor(clmap);
        colormap(c)            
    case 1
        % flip colormap (interpolated to 64 values)
        c=flipud(othercolor(clmap));
    case 2
        % use specialised version with only three values
        c=othercolor(clmap,3);
        % neutral brain colour: grey
        c(1,1)=0.98;c(1,2)=0.98;c(1,3)=0.98; 
        % this is for the second value
        c(2,1)=0.70;c(2,2)=0.70;c(2,3)=0.70; 
    case 3
        % use specialised version with only four values
        c=othercolor(clmap,4);
        % neutral brain colour: grey
        c(1,1)=0.98;c(1,2)=0.98;c(1,3)=0.98; 
        c(2,1)=0.70;c(2,2)=0.70;c(2,3)=0.70; 
end;
% neutral brain colour: grey
c(1,1)=0.98;c(1,2)=0.98;c(1,3)=0.98; 
colormap(c)


