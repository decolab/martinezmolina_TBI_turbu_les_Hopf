clear all
cd('F:\turbulence\timeseries\pre_post_schaefer1000\outputs');

for ii=1:2
    aa = load(sprintf('turbu_measurements%d_RSN.mat',ii));
    Turbu{ii,:,:} = squeeze(aa.TurbulenceRSN_sub);
end

Rsns = {'visual', 'somatomotor','dorsatt','salventatt','limbic','control','DMN'};
cond = {'Pre','Post'};
figure

lamb=10;
for jj=1:7 %Loop for networks
    subplot(2,4,jj)
    C = {Turbu{1}(lamb,:,jj) , Turbu{2}(lamb,:,jj)};
    
    maxNumEl = max(cellfun(@numel,C));
    Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
    Cmat = cell2mat(Cpad);
    boxplot(Cmat,'Labels',cond)
    title(Rsns{jj})
    
    %p(1,jj)= ranksum(Turbu{1}(lamb,:,jj),Turbu{2}(lamb,:,jj));
    [~,pval] = ttest(Turbu{1}(lamb,:,jj),Turbu{2}(lamb,:,jj)); % paired t Test
   
    p(1,jj)=pval; clear pval
        
    H=sigstar({[1,2]},p(1,jj));
    
end



