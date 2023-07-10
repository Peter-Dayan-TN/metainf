function [p,t,stats] = twowayRepmeasuresANOVA(y_)
%This function is used to perform a 2-way repeated measures ANOVA on the measure
%y is a 3D matrix
%1st dim of y - subjects
%2nd dim - contrast condition
%3 dim - confidence criterion


numSubjects = size(y_,1);
numFactors1 = size(y_,2); %Contrast
numFactors2 = size(y_,3);

%Dependent variable
y = reshape(y_,[],1);

for subject = 1:numSubjects
    for factor1 = 1:numFactors1
        for factor2 = 1:numFactors2
    subjects(subject,factor1,factor2) = subject;
    factors1(subject,factor1,factor2) = factor1;
    factors2(subject,factor1,factor2) = factor2;
        end
    end
end

subjects = reshape(subjects,[],1);
factors1 = reshape(factors1,[],1);
factors2 = reshape(factors2,[],1);


[p,t,stats] = anovan(y,{subjects; factors1; factors2},'random',1,'varnames',{'Subjects';'Contrast';'Confidence criterion'},'model','interaction');


end

