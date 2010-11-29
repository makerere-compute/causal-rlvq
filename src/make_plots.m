function make_plots(time,train_error,test_error,lambda,lambda_best,param)

% t = 1:length(train_error);
% time = (t-1)*param.interval1;

figure(1)
% subplot(2,2,3)
% plot(time,test_error)
% xlabel('t/P')
% ylabel('e_{gen}')
% axis tight
% % ylim([0 min(test_error)])
subplot(1,2,2)
plot(time,train_error)
xlabel('t/P')
ylabel('e_{train}')
axis tight
% ylim([0 min(train_error)])

switch (param.algo)
    case {'rlvq','grlvq'}
        subplot(1,2,1)
        bar(lambda)
        xlim([1 length(lambda)])
        title('Relevance, end')
%         subplot(2,2,4)
%         bar(lambda_best)
%         xlim([1 length(lambda)])
%         title('Relevance, best')
    case 'gmlvq'
        subplot(2,2,3)
        imagesc(lambda_best)
        colormap(gray)
        colorbar
        axis equal
    case 'lgmlvq'
        figure
        nlambda = length(lambda);
        for i=1:nlambda
            imagesc(lambda_best)
            colormap(gray)
            colorbar
            axis equal
            title(['\lambda ' num2str(i)])
        end
    case {'lgrlvq','clgrlvq'}
        figure
        nlambda = length(lambda);
        for i=1:nlambda
            subplot(ceil(nlambda/2),2,i)
            plot(lambda{i})
            title(['\lambda ' num2str(i)])
            axis tight
        end
    otherwise
        error('algorithm not supported')
end    
axis tight
xlabel('Feature #')
ylabel('Relevance factor')

pause(0)
