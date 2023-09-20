function make_video_sch1000(enstrophy1,outname)

% script to render surfaces for video
addpath(genpath('C:\Users\yonis\Documents\Laburo\PostDoc\Turbulence\RenderSurface\render_utils\'))

make_it_tight = true;
subplot = @(m,n,p)subtightplot(m, n, p, [0.01 0.05], [0.1 0.01], [0.1 0.01]);
if ~make_it_tight,  clear subplot;  end

% load surfaces for rendering on
basedir='C:\Users\yonis\Documents\Laburo\PostDoc\Turbulence\RenderSurface\render_utils\';
glassers_L=gifti([basedir 'Glasser360.L.mid.32k_fs_LR.surf.gii']);
glassersi_L=gifti([basedir 'Glasser360.L.inflated.32k_fs_LR.surf.gii']);
glassersvi_L=gifti([basedir 'Glasser360.L.very_inflated.32k_fs_LR.surf.gii']);
glassersf_L=gifti([basedir 'Glasser360.L.flat.32k_fs_LR.surf.gii']);
glassers_R=gifti([basedir 'Glasser360.R.mid.32k_fs_LR.surf.gii']);
glassersi_R=gifti([basedir 'Glasser360.R.inflated.32k_fs_LR.surf.gii']);
glassersvi_R=gifti([basedir 'Glasser360.R.very_inflated.32k_fs_LR.surf.gii']);
glassersf_R=gifti([basedir 'Glasser360.R.flat.32k_fs_LR.surf.gii']);
% use midthickness surfaces
sl = gifti(glassers_L);
sr = gifti(glassers_R);

% flat 
fl = gifti(glassersf_L);
fr = gifti(glassersf_R);

%load Rspatime_G_0_9.mat % load 1200 points for generating video

v = VideoWriter(outname,'MPEG-4');
open(v)

for i=1:size(enstrophy1,2)

    % create surface file
    create_schaefer1000_gifti(enstrophy1(:,i),['tst']);
    
    % load surface file
    vl=gifti(['tst_left.func.gii']);
    vr=gifti(['tst_right.func.gii']);

    % create figure
    hfig = figure(1);
    subplot(3,2,1); %left hemisphere
    ax=gca;
    axis(ax,'equal');
    axis(ax,'off');
    s(1) = patch(ax,'Faces',sl.faces,'vertices',sl.vertices, 'FaceVertexCData', vl.cdata, 'FaceColor','interp', 'EdgeColor', 'none');
    set(ax,'CLim',[0 1]);
    view(-90,0)

    subplot(3,2,4); %left hemisphere
    ax=gca;
    axis(ax,'equal');
    axis(ax,'off');
    s(1) = patch(ax,'Faces',sl.faces,'vertices',sl.vertices, 'FaceVertexCData', vl.cdata, 'FaceColor','interp', 'EdgeColor', 'none');
    set(ax,'CLim',[0 1]);
    view(90,0)

    subplot(3,2,3); %right hemisphere
    ax2=gca;
    axis(ax2,'equal');
    axis(ax2,'off');
    s(2) = patch(ax2,'Faces',sr.faces,'vertices',sr.vertices, 'FaceVertexCData', vr.cdata, 'FaceColor','interp', 'EdgeColor', 'none');
    set(ax2,'CLim',[0 1]);
    view(-90,0)

    subplot(3,2,2); %right hemisphere
    ax2=gca;
    axis(ax2,'equal');
    axis(ax2,'off');
    s(2) = patch(ax2,'Faces',sr.faces,'vertices',sr.vertices, 'FaceVertexCData', vr.cdata, 'FaceColor','interp', 'EdgeColor', 'none');
    set(ax2,'CLim',[0 1]);
    view(90,0)

    subplot(3,2,5); % right hemisphere flat
    ax2=gca;
    axis(ax2,'equal');
    axis(ax2,'off');
    s(2) = patch(ax2,'Faces',fr.faces,'vertices',fr.vertices, 'FaceVertexCData', vr.cdata, 'FaceColor','interp', 'EdgeColor', 'none');
    set(ax2,'CLim',[0 1]);
    view(180,-90)

	subplot(3,2,6); % left hemisphere flat
    ax2=gca;
    axis(ax2,'equal');
    axis(ax2,'off');
    s(2) = patch(ax2,'Faces',fl.faces,'vertices',fl.vertices, 'FaceVertexCData', vl.cdata, 'FaceColor','interp', 'EdgeColor', 'none');
    set(ax2,'CLim',[0 1]);
    view(180,-90)

    colormap('hot');
    writeVideo(v,frame2im(getframe(hfig)))
    close(hfig)
end
close(v)

