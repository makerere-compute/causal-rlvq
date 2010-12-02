function lambda_update = updateLambda(x,w,eta1,alpha,psi)
% Function to update lambda
% input : 
%   x - example
%   w - prototype
%   eta1 - learning rate for lambda(rlvq only)
%   alpha - learning rate for contributions to lambda (c-rlvq)
%   
% output : 
%   lambda_update - lambda update
% For ordinary RLVQ set alpha = 0

%global pairweights;

N = size(x,2);

lambda_update = zeros(1,N);


for j = 1:N
    lambda_update(j) = -eta1*psi*(x(j)-w(j))^2;
    
    collider_component = zeros(1,N);
    for k = 1:N
        if j ~= k
            collider_component(k) = -alpha*psi*(x(k)-w(k))^2 + alpha*(x(j)-x(k))^2;
        else
            collider_component(k) = inf;
        end
    end
    [min_collider_component, other_leg_of_V] = min(collider_component);
    lambda_update(j) = lambda_update(j) + eta1*min_collider_component;

    %disp([j,other_leg_of_V, abs(x(j)-w(j))])
    
    %if alpha>0
    %   pairweights(j,other_leg_of_V) = pairweights(j,other_leg_of_V) + lambda_update(j);    
    %end

end