function [lambda w] = mainRLVQ(data)

close all

%pack;
TrainSetD = data(:,1:end-1);
TrainLabelsD = data(:,end);
[lambda w] = RLVQ(TrainSetD, TrainLabelsD);

