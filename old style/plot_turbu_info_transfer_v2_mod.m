clear all
cd('F:\turbulence\timeseries\pre_post_schaefer1000\outputs');

for ii=1:2
    aa = load(sprintf('turbu_measurements%d_RSN.mat',ii));
    Info_cascade{ii,:} = squeeze(aa.InformationCascade_sub);
end


cond = {'Pre','Post'};

figure
C = {Info_cascade{1}, Info_cascade{2}};

maxNumEl = max(cellfun(@numel,C));
Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
Cmat = cell2mat(Cpad);
boxplot(Cmat,'Labels',cond)
title('Information cascade')

[~,pval] = ttest(Info_cascade{1},Info_cascade{2}); % paired t Test


H=sigstar({[1,2]},pval);





