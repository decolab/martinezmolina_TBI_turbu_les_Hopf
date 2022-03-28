clear all
cd('F:\turbulence\timeseries\pre_post_schaefer1000\outputs');

for ii=1:2
    aa = load(sprintf('turbu_measurements%d_RSN.mat',ii));
    Info_flow{ii,:,:} = squeeze(aa.TransferLambda_sub);
end

lambda={'0.27','0.24','0.21','0.18','0.15','0.12','0.09','0.06','0.03','0.01'};
cond = {'Pre','Post'};

for lamb=1:10
    figure
    C = {Info_flow{1}(lamb,:) , Info_flow{2}(lamb,:)};
    
    maxNumEl = max(cellfun(@numel,C));
    Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
    Cmat = cell2mat(Cpad);
    boxplot(Cmat,'Labels',cond)
    title(lambda{lamb})
    
    [~,pval] = ttest(Info_flow{1}(lamb,:),Info_flow{2}(lamb,:)); % paired t Test
    p(1,lamb)=pval; clear pval
        
    H=sigstar({[1,2]},p(1,lamb));
end




