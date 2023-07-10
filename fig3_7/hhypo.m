function [perr,mi]=hhypo(dprime)
% compute the probability of error, and the response conditional mutual information
% for a perfect type 1  Bayesian signal detection theory actor/rater pair
% with continuous confidences
% input dprime (d')
% output perr = P(error) = Phi(-d'/2)
%        mi   by calculation of the continuous confidence bins
perr=normcdf(0,dprime/2,1);
mi=midp(dprime);
