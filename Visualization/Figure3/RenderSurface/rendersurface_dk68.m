function rendersurface_dk68(dk68vector,rangemin,rangemax, inv,clmap,surfacetype)
% script for rendering a dk68 vector
%   ML Kringelbach April 2020
%
% dk68vector : the dk68 values to be rendered
%
% rangemin, rangemax : limits for colorscheme
%
% inv:
%  0 colormap, interp
%  1 flip colormap, interp
%  2 colormap, only three colours
%
% clmap : from othercolor, default 'Bu_10'
%
% surfacetype: 
%  1 midthickness
%  2 inflated (default)
%  3 very inflated


if ~exist('rangemin','var')
     rangemin=min(dk68vector);
end

if ~exist('rangemax','var')
     rangemax=max(dk68vector);
end

if ~exist('inv','var')
     inv=max(dk68vector);
end

if ~exist('clmap','var')
    clmap='Bu_10';
end

if ~exist('surfacetype','var')
     surfacetype=2; % default is inflated
end


% make space tight
make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.01 0.05], [0.1 0.01], [0.1 0.01]);
if ~make_it_tight,  clear subplot;  end

% load the different views
% base='/Users/mortenk/Documents/MATLAB/osl/std_masks/';
% display_surf_left=gifti([base 'ParcellationPilot.L.inflated.32k_fs_LR.surf.gii']);
% display_surf_right=gifti([base 'ParcellationPilot.R.inflated.32k_fs_LR.surf.gii']);

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



base='C:\Users\yonis\Documents\Laburo\PostDoc\Turbulence\RenderSurface\render_utils\';
% label gifti
label_L=gifti([ base 'fsaverage.L.DKT_org_Atlas.32k_fs_LR.label.gii']);
label_R=gifti([ base 'fsaverage.R.DKT_org_Atlas.32k_fs_LR.label.gii']);
% functional gifti
vl=gifti([ base 'dbs80_left.func.gii']);
vr=gifti([ base 'dbs80_right.func.gii']);

% % replace the left hemisphere labels with values from dkt(1:34)
% % dk46_L.labels contains 34 elements
dkt=[1:35]; dkt(4)=[];

for i=1:34
    idx{i}=find(label_L.cdata==dkt(i));
    vl.cdata(idx{i})=dk68vector(i);
end;

% replace right hemisphere labels with correct values from
for i=35:68
    idx{i}=find(label_R.cdata==dkt(i-34));
    vr.cdata(idx{i})=dk68vector(i);
end;

% remove -1 from labels
idx{i}=find(label_L.cdata==-1);
vl.cdata(idx{i})=0;
idx{i}=find(label_R.cdata==-1);
vr.cdata(idx{i})=0;


%% rendering

    % create figure
    hfig = figure;
    set(gcf, 'Position',  [100, 100, 500, 500]);
    set(gcf, 'Position',  [40, 40, 400, 600]);
    
    subplot(3,2,4); %left hemisphere side view
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

    subplot(3,2,1); %right hemisphere side view
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
   % colorbar('southoutside');

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
    end;
    % neutral brain colour: grey
    c(1,1)=0.95;c(1,2)=0.95;c(1,3)=0.95; 
    colormap(c)
    colorbar


