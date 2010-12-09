
%% Plot lucas lambda


a = load('./results/lucas0_CRLVQ_0','result0');
resu1 = a.result0.lambda;

a = load('./results/lucas0_CRLVQ_1.mat','result0');
resu2 = a.result0.lambda;

a = load('./results/lucas0_CRLVQ_2.mat','result0');
resu3 = a.result0.lambda;
%

subplot(3,1,1); bar(resu1);
subplot(3,1,2); bar(resu2);
subplot(3,1,3); bar(resu3);