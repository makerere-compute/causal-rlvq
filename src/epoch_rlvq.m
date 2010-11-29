function [w lambda] = epoch_rlvq(w,c_w,lambda,xi,c_xi,eta,eta1,alpha)
%% Learn one epoch with RLVQ
%
% Inputs:
%       w      : initial prototype positions ( K x dimensions)
%       c_w    : class of prototypes (K x 1)
%       lambda : initial relevance vector (1 x dimensions)
%       xi     : data set (P x dimensions)
%       c_xi   : class of data (P x 1)
%       eta    : prototype learning rate
%       eta1   : relevance learning rate
% Outputs:
%       w      : end prototype positions (K x dimensions)
%       lambda : end relevance vector (1 x dimensions)
% Example use:
%       w = randn(1,N);
%       c_w = [1 2]';
%       [ w lambda ] = epoch_rlvq(w, c_w, lambda, xi, 1e-3, 1e-5)


[P N] = size(xi);
[proto N] = size(w);

%alpha = 0;

for mu = 1:P

    % calculate (adapted) distance
    delta = ones(proto,1)*xi(mu,:) - w;
    delta(isnan(delta))=0 ;
    dist = delta.^2 * lambda';
    %---appended---
    x = xi(mu,:);
%     yBC = corrBC(x,w);
%     yAB = corrAB(x);
%     %--------------

    % finding nearest prototype
    [dJ J] = min(dist);

    %update w
    if (c_w(J)==c_xi(mu)), psi=+1; else psi=-1;  end;
    w(J,:) = w(J,:) + psi * eta * lambda .* delta(J,:);

    %update relevances
    if eta1>0

        lambda_update = updateLambda(x, w(J,:), eta1, alpha, psi,lambda);
        lambda = lambda + lambda_update;

        if isnan(lambda)
            keyboard
        end
        lambda = max(lambda,0);
        lambda = lambda/sum(lambda);
    end



end









