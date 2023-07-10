function [FAR,HR] = zROC(stimulus, response, confidence, nRatings,correctExtremes)

%--------------------------------------------------------------------------
% The function creates ROC and zROC plots, and computes s (the standard
% deviation ratio of the two Gaussians).
%
% Inputs:
% stimulus: vector of 2 values (lower one is noise, higher one is stimulus)
% response: vector with the same values as the stimulus
% confidence: vector with confidence values
% nRatings: number of confidence ratings used
%--------------------------------------------------------------------------

% Confidence criteria on the left of the decision criterion
for roc_point=1:nRatings-1
    HR(roc_point) = sum(stimulus==max(stimulus) & (response==max(stimulus) | confidence<=nRatings-roc_point)) ...
        / sum(stimulus==max(stimulus));
    FAR(roc_point) = sum(stimulus==min(stimulus) & (response==max(stimulus) | confidence<=nRatings-roc_point)) ...
        / sum(stimulus==min(stimulus));
end

% Decision criterion and confidence criteria to the right of it
for roc_point=nRatings:2*nRatings-1
    HR(roc_point) = sum(stimulus==max(stimulus) & response==max(stimulus) & confidence>roc_point-nRatings) ...
        / sum(stimulus==max(stimulus));
    FAR(roc_point) = sum(stimulus==min(stimulus) & response==max(stimulus) & confidence>roc_point-nRatings) ...
        / sum(stimulus==min(stimulus));
end

% % Correct for values of 0 or 1
if correctExtremes
    HR(HR==0) = .5/sum(stimulus==max(stimulus));
    HR(HR==1) = 1 - .5/sum(stimulus==max(stimulus));
    
    FAR(FAR==0) = .5/sum(stimulus==min(stimulus));
    FAR(FAR==1) = 1 - .5/sum(stimulus==min(stimulus));
end

%
% % Remove values of 0 and 1 from HR and FAR (preferable over correcting such
% % values since the correction may introduce noise)
% HR_noExtreme = HR(HR>0 & HR<1 & FAR>0 & FAR<1);
% FAR_noExtreme = FAR(HR>0 & HR<1 & FAR>0 & FAR<1);
% nPoints = length(HR_noExtreme);

