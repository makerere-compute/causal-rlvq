function [lambda w test_error train_error lambda_best w_best ] = RLVQ(TrainSet,TrainLabels,param,TestSet,TestLabels)
%% Relevance LVQ
% Relevance LVQ for data set of P examples x N-dim. and class labels P x 1
% using K prototypes. The program runs several epochs of LVQ1 until prototypes W converge,
% then follows up with Relevance learning.
%
% See PARAMETERS for settings.
%
% Inputs:
%       TrainSet     : data set (P x dimensions) 
%                      note: must be normalized to zero mean and unit variance 
%       TrainLabels  : class of data (P x 1)
%       param        : relevance learning rate
%       TestSet      : test set (optional)
%       TestLabels   : class of test set (optional)
% Outputs:
%       lambda      : end relevance vector (1 x dimensions)
%       w           : end prototype positions (K x dimensions)
%       test_error  : generalization error on the test set, if available
%       train_error : generalization error on the training set
%       lambda_best : best achieved relevance vector wrt. generalization error
%       w_best      : best achieved prototype configuration
%
% Default use:
%
%       [lambda w ] = RLVQ(TrainSet,TrainLabels);
%
% Example with user defined parameters: (see PARAMETERS.m)
%
%       param = parameters('nProtoClass',3,'nEpochs',500,'eta1',1e-5);
%       [lambda w ] = RLVQ(TrainSet,TrainLabels,param);



% If default parameters are used
if nargin < 3
    param = parameters();
end
% If no test set is used
if nargin < 4  
    param = parameters(param,'skip_test_error',1); 
end
    
[P N] = size(TrainSet);
uniqueLabels = unique(TrainLabels);
nClasses = length(uniqueLabels);

% Initialize prototypes and relevance vector/matrix
w  = zeros(param.nProtoClass * nClasses,N);
c_w = zeros(param.nProtoClass * nClasses,1);
count = 1;
for i=1:nClasses
    mean_cls = nanmean( TrainSet(find(TrainLabels==uniqueLabels(i)) , :) );
    for j=1:param.nProtoClass
        w( count,:) = mean_cls;
        c_w( count ) = uniqueLabels(i);
        count = count+1;
    end
end
lambda = ones(1,N) /sqrt(N);


% Learn n epochs
eg_best = [];
w_best = [];
lambda_best = [];
m=1;
for epoch = param.StartEpoch:param.nEpochs
    
    % learning rates
    eta = param.eta;
    if epoch < param.StartRelevance, eta1 = 0;
    else eta1 = param.eta1;
    end;
    
    if epoch < param.StartCausalRelevance, alpha = 0;
    else alpha = param.alpha;
    end;    
    
    % update prototypes and relevances for one epoch
    [w lambda] = epoch_rlvq(w,c_w,lambda,TrainSet,TrainLabels,eta,eta1,alpha);
        

    % calculate errors at intervals
    if mod(epoch,param.interval1)==0  || epoch==1
        if param.skip_train_error, et = 0;
        else [et] = calculate_errors(w,c_w,TrainSet,TrainLabels,lambda,param);
        end
        if param.skip_test_error, eg = 0;
        else [eg] = calculate_errors(w,c_w,TestSet,TestLabels,lambda,param);
        end
        time(m) = epoch; 
        train_error(m) = et;
        test_error(m) =  eg;
        display(['epochs = ' num2str(epoch) ', test_error = ' num2str(eg) ', train_error = ' num2str(et)]);
        m=m+1;
    end
    
    % save best result
    if epoch==1 || eg < eg_best
        eg_best = eg;
        lambda_best = lambda;
        w_best = w;
    end

    % plots
    if param.show_plots && mod(epoch,param.interval2)==0,
        make_plots(time,train_error,test_error,lambda,lambda_best,param);
        drawnow();
    end
            
end % param.nEpochs


