%% Plot lucas lambdas
%
close all

a = load('./lucas/lambdaRLVQ1e-6','lambda');
b = load('./lucas/lambdaRLVQ1e-5','lambda');
c = load('./lucas/lambdaRLVQ1e-4','lambda');
%d = load('./lucas/lambdaRLVQ1e-3','lambda');

aa = load('./lucas/lambdaCRLVQ1e-6','lambda');
bb = load('./lucas/lambdaCRLVQ1e-5','lambda');
cc = load('./lucas/lambdaCRLVQ1e-4','lambda');
%dd = load('./lucas/lambdaCRLVQ1e-3','lambda');

subplot(2,3,1); bar(a.lambda);
subplot(2,3,2); bar(b.lambda);
subplot(2,3,3); bar(c.lambda);
%subplot(2,4,4); bar(d.lambda);

subplot(2,3,4); bar(aa.lambda);
subplot(2,3,5); bar(bb.lambda);
subplot(2,3,6); bar(cc.lambda);
%subplot(2,4,8); bar(dd.lambda);

%% Plot SIM Network
%
close all

a = load('./sim/lambdaSIMRLVQ1e-6','lambda');
b = load('./sim/lambdaSIMRLVQ1e-5','lambda');
c = load('./sim/lambdaSIMRLVQ1e-4','lambda');

aa = load('./sim/lambdaSIMCRLVQ1e-6','lambda');
bb = load('./sim/lambdaSIMCRLVQ1e-5','lambda');
cc = load('./sim/lambdaSIMCRLVQ1e-4','lambda');

subplot(2,3,1); bar(a.lambda);
subplot(2,3,2); bar(b.lambda);
subplot(2,3,3); bar(c.lambda);

subplot(2,3,4); bar(aa.lambda);
subplot(2,3,5); bar(bb.lambda);
subplot(2,3,6); bar(cc.lambda);
