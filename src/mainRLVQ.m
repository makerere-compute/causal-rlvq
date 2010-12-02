function [lambda w Test_error] = mainRLVQ(Train_data, Test_data, param)

close all

% Datasets
%Train_data = z_transformation(Train_data);
%Test_data = z_transformation(Test_data);

TrainSetD = Train_data(:,1:end-1);
TrainLabelsD = Train_data(:,end);

TestSetD = Test_data(:,1:end-1);
TestLabelsD = Test_data(:,end);

[lambda w Test_error] = RLVQ(TrainSetD, TrainLabelsD, param, TestSetD, TestLabelsD);

%Plot lambda
%bar(lambda);

% Test error
%Test_error = Test_error(1,end);

