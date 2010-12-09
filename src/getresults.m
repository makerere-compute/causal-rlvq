%% Get results for CRLVQ
%

%% lucas

resu = zeros(5,3);
a = load('./results/lucas0_CRLVQ_0','result0');
resu(1,1) = a.result0.Test_error(1,end);

a = load('./results/lucas0_CRLVQ_0.5.mat','result0');
resu(2,1) = a.result0.Test_error(1,end);

a = load('./results/lucas0_CRLVQ_1.mat','result0');
resu(3,1) = a.result0.Test_error(1,end);

a = load('./results/lucas0_CRLVQ_1.5.mat','result0');
resu(4,1) = a.result0.Test_error(1,end);

a = load('./results/lucas0_CRLVQ_2.mat','result0');
resu(5,1) = a.result0.Test_error(1,end);
%

a = load('./results/lucas1_CRLVQ_0','result1');
resu(1,2) = a.result1.Test_error(1,end);

a = load('./results/lucas1_CRLVQ_0.5.mat','result1');
resu(2,2) = a.result1.Test_error(1,end);

a = load('./results/lucas1_CRLVQ_1.mat','result1');
resu(3,2) = a.result1.Test_error(1,end);

a = load('./results/lucas1_CRLVQ_1.5.mat','result1');
resu(4,2) = a.result1.Test_error(1,end);

a = load('./results/lucas1_CRLVQ_2.mat','result1');
resu(5,2) = a.result1.Test_error(1,end);
%

a = load('./results/lucas2_CRLVQ_0','result2');
resu(1,3) = a.result2.Test_error(1,end);

a = load('./results/lucas2_CRLVQ_0.5.mat','result2');
resu(2,3) = a.result2.Test_error(1,end);

a = load('./results/lucas2_CRLVQ_1.mat','result2');
resu(3,3) = a.result2.Test_error(1,end);

a = load('./results/lucas2_CRLVQ_1.5.mat','result2');
resu(4,3) = a.result2.Test_error(1,end);

a = load('./results/lucas2_CRLVQ_2.mat','result2');
resu(5,3) = a.result2.Test_error(1,end);


resu