function [b,tstat, p] = plot_linearFit(y,ylab,sem,printXLabel)
%Do a linear regression on the metacognition measure with confCriteria as a
%predictor - plot the data with error bars. Indicate
%the value of regression coefficient and R-squared

%columns of y correspond to different criterion locations
%rows of y correspond to subjects

%Other inputs
%ylab = Y axis label, ylimits - limits of the y-axis
%sem = standard error

%Outputs - returns the slope of the regression - tstat and p value

%% Plot data
nCriteria = size(y,2);
x = [1:nCriteria];
h1 = errorbar(x,nanmean(y),sem,'.-','LineWidth',.5,'Markersize',10,'color',[.5 .5 .5]); hold on;
h1 = plot(x,nanmean(y),'.','LineWidth',1.5,'Markersize',15,'color',[0 0 0]);
ylabel(ylab,'fontsize',24)
if printXLabel
    xlabel({'Criterion Location';''},'FontSize',24)
end


%Linear regression
%Get statistics - slope, t and p values of the slope
stats = regstats(nanmean(y)',x');
b = stats.beta(2);
tstat = stats.tstat.t(2);
p = stats.tstat.pval(2);

%Linear fit results
%h1 = plot(x,x*b(2)+b(1),'-r','linewidth',1.5)
 str = strcat('slope = ',num2str(round(b,4)),',  p = ',num2str(p));
%str = strcat('slope = ',num2str(b),',  p = ',num2str(p));
l = legend([h1],str);
set(l,'fontSize',20,'location','best')


end

