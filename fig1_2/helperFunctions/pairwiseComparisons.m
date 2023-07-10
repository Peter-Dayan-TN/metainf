function [pval, tstat] = pairwiseComparisons(y)
%Conduct paired t-test for each pair of columns in y and return p values

[~,pval(1),~,stats1] = ttest(y(:,1),y(:,2));
tstat(1) = stats1.tstat;
[~,pval(2),~,stats2] = ttest(y(:,1),y(:,3));
tstat(2) = stats2.tstat;
[~,pval(3),~,stats3] = ttest(y(:,2),y(:,3));
tstat(3) = stats3.tstat;

end

