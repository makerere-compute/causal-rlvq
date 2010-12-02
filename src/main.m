function mainCRLVQ()
%% Main CRLVQ
%

clear
clc

%datasets = {'cina', 'reged'};
datasets = {'lucas'};
for ds = 1:length(datasets)
    dataset = datasets{ds}

    % Get datasets
    [data0, data1, data2] = read_data(dataset);

    num_train_examples = floor(0.9 * size(data0,1));
    num_test_examples = size(data0,1) - num_train_examples;
    test1_indicies = randperm(num_test_examples);
    test2_indicies = randperm(num_test_examples);

    Train_data = data0(1:num_train_examples,:);

    Test_data0 = data0(num_train_examples + 1:end, :);
    Test_data1 = data1(test1_indicies, :);
    Test_data2 = data2(test2_indicies, :);


    %% RLVQ

    % Initialize parameters
    eta1 = 1e-6;


    for alpha = [0, 0.3, 0.7, 1, 1.3]

        display(['alpha = ' num2str(alpha)]);
        param = parameters('eta1', eta1, 'alpha', alpha);


        [lambda0 w0 Test_error0] = mainRLVQ(Train_data, Test_data0, param);
        [lambda1 w1 Test_error1] = mainRLVQ(Train_data, Test_data1, param);
        [lambda2 w2 Test_error2] = mainRLVQ(Train_data, Test_data2, param);

        % save results
        result0.lambda = lambda0;
        result1.lambda = lambda1;
        result2.lambda = lambda2;

        result0.Test_error = Test_error0;
        result1.Test_error = Test_error1;
        result2.Test_error = Test_error2;

        fname0 = ['./results/' dataset '0_CRLVQ_' num2str(alpha) '.mat'];
        fname1 = ['./results/' dataset '1_CRLVQ_' num2str(alpha) '.mat'];
        fname2 = ['./results/' dataset '2_CRLVQ_' num2str(alpha) '.mat'];

        save (fname0, 'result0');
        save (fname1, 'result1');
        save (fname2, 'result2');

    end
end