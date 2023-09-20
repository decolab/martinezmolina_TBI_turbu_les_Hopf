% Render brain surface turbulence by node
clear
close all
cd ('/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/')
addpath('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Turbulence/TBI_turbulence_current_code/')
%% Load node-level turbulence for different groups and conditions
load('turbu_by_node_openneuro_controls_con1.mat')
Turbulence_node_sub_controls_con1=Turbulence_node_sub; clear Turbulence_node_sub
load('turbu_by_node_openneuro_tbi_con1.mat')
Turbulence_node_sub_tbi_con1=Turbulence_node_sub; clear Turbulence_node_sub
load('turbu_by_node_openneuro_tbi_con2.mat')
Turbulence_node_sub_tbi_con2=Turbulence_node_sub; clear Turbulence_node_sub
load('turbu_by_node_openneuro_tbi_con3.mat')
Turbulence_node_sub_tbi_con3=Turbulence_node_sub; clear Turbulence_node_sub

cd ('render')
%% Renderings node-level HCs vs TBI 3-months for lambda=0.06

turbu_node_controls_con1_lam6=nanmean(Turbulence_node_sub_controls_con1(8,:,:),3);
turbu_node_tbi_con1_lam6=nanmean(Turbulence_node_sub_tbi_con1(8,:,:),3);

diff_hc_tbi_con1_lam6=abs(turbu_node_controls_con1_lam6 -turbu_node_tbi_con1_lam6);
%rangemin=min(diff_hc_tbi_con1_lam6);
rangemax=max(diff_hc_tbi_con1_lam6);

%rendersurface_schaefer1000(diff_hc_tbi_con1_lam6, rangemin, rangemax, 0, 'Purples9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con1_lam6, 0, rangemax, 0, 'YlOrRd9',1 )
print('render_hc_tbi_con1_lam6_ylorrd9', '-dpng')
save brain_nodes_diff_hc_tbi_con1_lam6.mat diff_hc_tbi_con1_lam6

%% Renderings node-level HCs vs TBI 6-months for lambda=0.06

turbu_node_controls_con1_lam6=nanmean(Turbulence_node_sub_controls_con1(8,:,:),3);
turbu_node_tbi_con2_lam6=nanmean(Turbulence_node_sub_tbi_con2(8,:,:),3);

diff_hc_tbi_con2_lam6=abs(turbu_node_controls_con1_lam6-turbu_node_tbi_con2_lam6);
%rangemin=min(diff_hc_tbi_con2_lam6);
rangemax=max(diff_hc_tbi_con2_lam6);

%rendersurface_schaefer1000(diff_hc_tbi_con2_lam6, rangemin, rangemax, 0, 'Oranges9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con2_lam6, 0, rangemax, 0, 'YlOrRd9',1 )
print('render_hc_tbi_con2_lam6_ylorrd9', '-dpng')
save brain_nodes_diff_hc_tbi_con2_lam6.mat diff_hc_tbi_con2_lam6

%% Renderings node-level HCs vs TBI 12-months for lambda=0.06

turbu_node_controls_con1_lam6=nanmean(Turbulence_node_sub_controls_con1(8,:,:),3);
turbu_node_tbi_con3_lam6=nanmean(Turbulence_node_sub_tbi_con3(8,:,:),3);

diff_hc_tbi_con3_lam6=abs(turbu_node_controls_con1_lam6-turbu_node_tbi_con3_lam6);
%rangemin=min(diff_hc_tbi_con2_lam6);
rangemax=max(diff_hc_tbi_con2_lam6);

%rendersurface_schaefer1000(diff_hc_tbi_con3_lam6, rangemin, rangemax, 0, 'Blues9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con3_lam6, 0, rangemax, 0, 'YlOrRd9',1 )
print('render_hc_tbi_con3_lam6_ylorrd9', '-dpng')
save brain_nodes_diff_hc_tbi_con3_lam6.mat diff_hc_tbi_con3_lam6

%% Renderings node-level HCs vs TBI 3-months for lambda=0.03

turbu_node_controls_con1_lam3=nanmean(Turbulence_node_sub_controls_con1(9,:,:),3);
turbu_node_tbi_con1_lam3=nanmean(Turbulence_node_sub_tbi_con1(9,:,:),3);

diff_hc_tbi_con1_lam3=abs(turbu_node_controls_con1_lam3 -turbu_node_tbi_con1_lam3);
%rangemin=min(diff_hc_tbi_con1_lam3);
rangemax=max(diff_hc_tbi_con1_lam3);

%rendersurface_schaefer1000(diff_hc_tbi_con1_lam3, rangemin, rangemax, 0, 'Purples9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con1_lam3, 0, rangemax, 0, 'YlOrRd9',1 )
print('render_hc_tbi_con1_lam3_ylorrd9', '-dpng')
save brain_nodes_diff_hc_tbi_con1_lam3.mat diff_hc_tbi_con1_lam3

%% Renderings node-level HCs vs TBI 6-months for lambda=0.03

turbu_node_controls_con1_lam3=nanmean(Turbulence_node_sub_controls_con1(9,:,:),3);
turbu_node_tbi_con2_lam3=nanmean(Turbulence_node_sub_tbi_con2(9,:,:),3);

diff_hc_tbi_con2_lam3=abs(turbu_node_controls_con1_lam3-turbu_node_tbi_con2_lam3);
%rangemin=min(diff_hc_tbi_con2_lam3);
rangemax=max(diff_hc_tbi_con2_lam3);

%rendersurface_schaefer1000(diff_hc_tbi_con2_lam3, rangemin, rangemax, 0, 'Oranges9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con2_lam3, 0, rangemax, 0, 'YlOrRd9',1 )
print('render_hc_tbi_con2_lam3_ylorrd9', '-dpng')
save brain_nodes_diff_hc_tbi_con2_lam3.mat diff_hc_tbi_con2_lam3

%% Renderings node-level HCs vs TBI 12-months for lambda=0.03

turbu_node_controls_con1_lam3=nanmean(Turbulence_node_sub_controls_con1(9,:,:),3);
turbu_node_tbi_con3_lam3=nanmean(Turbulence_node_sub_tbi_con3(9,:,:),3);

diff_hc_tbi_con3_lam3=abs(turbu_node_controls_con1_lam3-turbu_node_tbi_con3_lam3);
%rangemin=min(diff_hc_tbi_con2_lam3);
rangemax=max(diff_hc_tbi_con2_lam3);

%rendersurface_schaefer1000(diff_hc_tbi_con3_lam3, rangemin, rangemax, 0, 'Blues9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con3_lam3, 0, rangemax, 0, 'YlOrRd9',1 )
print('render_hc_tbi_con3_lam3_ylorrd9', '-dpng')
save brain_nodes_diff_hc_tbi_con3_lam3.mat diff_hc_tbi_con3_lam3

%% Renderings node-level HCs vs TBI 3-months for lambda=0.01

turbu_node_controls_con1_lam1=nanmean(Turbulence_node_sub_controls_con1(10,:,:),3);
turbu_node_tbi_con1_lam1=nanmean(Turbulence_node_sub_tbi_con1(10,:,:),3);

diff_hc_tbi_con1_lam1=abs(turbu_node_controls_con1_lam1 -turbu_node_tbi_con1_lam1);
%rangemin=min(diff_hc_tbi_con1_lam1);
rangemax=max(diff_hc_tbi_con1_lam1);

%rendersurface_schaefer1000(diff_hc_tbi_con1_lam13, rangemin, rangemax, 0, 'Purples9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con1_lam1, 0, rangemax, 0, 'YlOrRd9',1 )
print('render_hc_tbi_con1_lam1_ylorrd9', '-dpng')
save brain_nodes_diff_hc_tbi_con1_lam1.mat diff_hc_tbi_con1_lam1

%% Renderings node-level HCs vs TBI 6-months for lambda=0.01

turbu_node_controls_con1_lam1=nanmean(Turbulence_node_sub_controls_con1(10,:,:),3);
turbu_node_tbi_con2_lam1=nanmean(Turbulence_node_sub_tbi_con2(10,:,:),3);

diff_hc_tbi_con2_lam1=abs(turbu_node_controls_con1_lam1-turbu_node_tbi_con2_lam1);
%rangemin=min(diff_hc_tbi_con2_lam1);
rangemax=max(diff_hc_tbi_con2_lam1);

%rendersurface_schaefer1000(diff_hc_tbi_con2_lam1, rangemin, rangemax, 0, 'Oranges9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con2_lam1, 0, rangemax, 0, 'YlOrRd9',1 )
print('render_hc_tbi_con2_lam1_ylorrd9', '-dpng')
save brain_nodes_diff_hc_tbi_con2_lam1.mat diff_hc_tbi_con2_lam1

%% Renderings node-level HCs vs TBI 12-months for lambda=0.01

turbu_node_controls_con1_lam1=nanmean(Turbulence_node_sub_controls_con1(10,:,:),3);
turbu_node_tbi_con3_lam1=nanmean(Turbulence_node_sub_tbi_con3(10,:,:),3);

diff_hc_tbi_con3_lam1=abs(turbu_node_controls_con1_lam1-turbu_node_tbi_con3_lam1);
%rangemin=min(diff_hc_tbi_con2_lam1);
rangemax=max(diff_hc_tbi_con2_lam1);

%rendersurface_schaefer1000(diff_hc_tbi_con3_lam1, rangemin, rangemax, 0, 'Blues9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con3_lam1, 0, rangemax, 0, 'YlOrRd9',1 )
print('render_hc_tbi_con3_lam1_ylorrd9', '-dpng')
save brain_nodes_diff_hc_tbi_con3_lam1.mat diff_hc_tbi_con3_lam1