clear all
addpath('C:\Users\yonis\Documents\Laburo\PostDoc\utils');

for ii=1:4
    aa = load(sprintf('turbu_measurementsND%d_RSN.mat',ii));
    Turbu{ii,:,:} = squeeze(aa.Turbulence_sub);
end

Rsns = {'visual', 'somatomotor','dorsatt','salventatt','limbic','control','DMN'}
cond = {'CN','AD','DFT','PD'};
figure

lamb=3
for jj=1:7
    subplot(2,4,jj)
    C = {Turbu{1}(lamb,:,jj) , Turbu{2}(lamb,:,jj), Turbu{3}(lamb,:,jj), Turbu{4}(lamb,:,jj)};
    
    maxNumEl = max(cellfun(@numel,C));
    Cpad = cellfun(@(x){padarray(x(:),[maxNumEl-numel(x),0],NaN,'post')}, C);
    Cmat = cell2mat(Cpad);
    boxplot(Cmat,'Labels',cond)
    title(Rsns{jj})
    %for sh=1:Nshuff
        
        p(1,jj)= ranksum(Turbu{1}(lamb,:,jj),Turbu{2}(lamb,:,jj));
        p(2,jj)= ranksum(Turbu{1}(lamb,:,jj),Turbu{3}(lamb,:,jj));
        p(3,jj)= ranksum(Turbu{1}(lamb,:,jj),Turbu{4}(lamb,:,jj));
        p(4,jj)= ranksum(Turbu{2}(lamb,:,jj),Turbu{3}(lamb,:,jj));
        p(5,jj)= ranksum(Turbu{2}(lamb,:,jj),Turbu{4}(lamb,:,jj));
        p(6,jj)= ranksum(Turbu{3}(lamb,:,jj),Turbu{4}(lamb,:,jj));
        
        
        
        H=sigstar({[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]},p(:,jj));
    end
end


