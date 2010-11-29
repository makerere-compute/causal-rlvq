function [lambda w] = mainRLVQ(data)

close all
addpath RLVQ/

%pack;
TrainSetD = data(:,1:end-1);
TrainLabelsD = data(:,end);
[lambda w] = RLVQ(TrainSetD, TrainLabelsD);

% ind_rel = ceil(lambda);
% relfeats = labels(find(ind_rel == 1));
