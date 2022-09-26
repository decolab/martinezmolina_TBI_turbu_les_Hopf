% Render brain surface turbulence by node
clear
close all
cd ('/Volumes/LASA/TBI_project/TBI_openneuro/timeseries/outputs/Turbulence_30_06_2022/')
addpath('/Volumes/LASA/TBI_project/Shared_code/Turbulence/TBI_turbulence_current_code/RenderSurface/')
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

%rendersurface_schaefer1000(diff_hc_tbi_con1_lam6, rangemin, rangemax, 0, 'Oranges9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con1_lam6, 0, rangemax, 0, 'Purples9',1 )
print('render_hc_tbi_con1_lam6', '-dpng')
save brain_nodes_diff_hc_tbi_con1_lam6.mat diff_hc_tbi_con1_lam6

%% Renderings node-level HCs vs TBI 6-months for lambda=0.06

turbu_node_controls_con1_lam6=nanmean(Turbulence_node_sub_controls_con1(8,:,:),3);
turbu_node_tbi_con2_lam6=nanmean(Turbulence_node_sub_tbi_con2(8,:,:),3);

diff_hc_tbi_con2_lam6=abs(turbu_node_controls_con1_lam6-turbu_node_tbi_con2_lam6);
%rangemin=min(diff_hc_tbi_con2_lam6);
rangemax=max(diff_hc_tbi_con2_lam6);

%rendersurface_schaefer1000(diff_hc_tbi_con2_lam6, rangemin, rangemax, 0, 'Oranges9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con2_lam6, 0, rangemax, 0, 'Oranges9',1 )
print('render_hc_tbi_con2_lam6', '-dpng')
save brain_nodes_diff_hc_tbi_con2_lam6.mat diff_hc_tbi_con2_lam6

%% Renderings node-level HCs vs TBI 12-months for lambda=0.06

turbu_node_controls_con1_lam6=nanmean(Turbulence_node_sub_controls_con1(8,:,:),3);
turbu_node_tbi_con3_lam6=nanmean(Turbulence_node_sub_tbi_con3(8,:,:),3);

diff_hc_tbi_con3_lam6=abs(turbu_node_controls_con1_lam6-turbu_node_tbi_con3_lam6);
%rangemin=min(diff_hc_tbi_con2_lam6);
rangemax=max(diff_hc_tbi_con2_lam6);

%rendersurface_schaefer1000(diff_hc_tbi_con3_lam6, rangemin, rangemax, 0, 'Oranges9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con3_lam6, 0, rangemax, 0, 'Blues9',1 )
print('render_hc_tbi_con3_lam6', '-dpng')
save brain_nodes_diff_hc_tbi_con3_lam6.mat diff_hc_tbi_con3_lam6

%% Renderings node-level HCs vs TBI 3-months for lambda=0.03

turbu_node_controls_con1_lam3=nanmean(Turbulence_node_sub_controls_con1(8,:,:),3);
turbu_node_tbi_con1_lam3=nanmean(Turbulence_node_sub_tbi_con1(8,:,:),3);

diff_hc_tbi_con1_lam3=abs(turbu_node_controls_con1_lam3 -turbu_node_tbi_con1_lam3);
%rangemin=min(diff_hc_tbi_con1_lam3);
rangemax=max(diff_hc_tbi_con1_lam3);

%rendersurface_schaefer1000(diff_hc_tbi_con1_lam3, rangemin, rangemax, 0, 'Oranges9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con1_lam3, 0, rangemax, 0, 'Purples9',1 )
print('render_hc_tbi_con1_lam3', '-dpng')
save brain_nodes_diff_hc_tbi_con1_lam3.mat diff_hc_tbi_con1_lam3

%% Renderings node-level HCs vs TBI 6-months for lambda=0.06

turbu_node_controls_con1_lam3=nanmean(Turbulence_node_sub_controls_con1(8,:,:),3);
turbu_node_tbi_con2_lam3=nanmean(Turbulence_node_sub_tbi_con2(8,:,:),3);

diff_hc_tbi_con2_lam3=abs(turbu_node_controls_con1_lam3-turbu_node_tbi_con2_lam3);
%rangemin=min(diff_hc_tbi_con2_lam3);
rangemax=max(diff_hc_tbi_con2_lam3);

%rendersurface_schaefer1000(diff_hc_tbi_con2_lam3, rangemin, rangemax, 0, 'Oranges9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con2_lam3, 0, rangemax, 0, 'Oranges9',1 )
print('render_hc_tbi_con2_lam3', '-dpng')
save brain_nodes_diff_hc_tbi_con2_lam3.mat diff_hc_tbi_con2_lam3

%% Renderings node-level HCs vs TBI 12-months for lambda=0.06

turbu_node_controls_con1_lam3=nanmean(Turbulence_node_sub_controls_con1(8,:,:),3);
turbu_node_tbi_con3_lam3=nanmean(Turbulence_node_sub_tbi_con3(8,:,:),3);

diff_hc_tbi_con3_lam3=abs(turbu_node_controls_con1_lam3-turbu_node_tbi_con3_lam3);
%rangemin=min(diff_hc_tbi_con2_lam3);
rangemax=max(diff_hc_tbi_con2_lam3);

%rendersurface_schaefer1000(diff_hc_tbi_con3_lam3, rangemin, rangemax, 0, 'Oranges9',1 )
rendersurface_schaefer1000(diff_hc_tbi_con3_lam3, 0, rangemax, 0, 'Blues9',1 )
print('render_hc_tbi_con3_lam3', '-dpng')
save brain_nodes_diff_hc_tbi_con3_lam3.mat diff_hc_tbi_con3_lam3