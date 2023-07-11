function [vcondition]=load_condition_tbi(G,sbj,cond)

for wG=1:G
    load(sprintf('WG_%03d_%d_sub_%d_ON_tbi_mask1halfSD_bin.mat',wG,sbj,cond));

    vcondition.err_hete_range(wG,:)=(err_hete);
    vcondition.InfoFlow_range(wG,:,:)=(InfoFlow);
    vcondition.InfoCascade_range(wG,:)=(InfoCascade);
    vcondition.Turbulence_range(wG,:)=(Turbulence);
end