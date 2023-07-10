function [p,t,stats] = onewayRepmeasuresANOVA(y,factorName)
%This function performs a one-way repeated measures ANOVA on y 
%Factor - Confidence criterion (5 levels)

%y is a matrix of values from all the different conditions
%Columns - factors  
%Rows - Subjects

% One-way repeated measures ANOVA

numFactors = size(y,2);
numSubjects = size(y,1);

%Dependent variable
y = reshape(y,[],1);

for factor = 1:numFactors
    subjects(1:numSubjects,factor) = 1:numSubjects;
    factors(1:numSubjects,factor) = factor;
end

subjects = reshape(subjects,[],1);
factors = reshape(factors,[],1);


[p,t,stats] = anovan(y,{factors; subjects},'random',2,'varnames',{factorName;'Subjects'});

end

