function [error_rate error_type wins] = calculate_errors(w,c_w,xi,c_xi,lambda,param)
% Calculate classification (quantization) error for supervised
% (unsupervised) learning
%
% Inputs:
%   w           : prototypes
%   c_w         : labels of prototypes
%   xi          : set of examples (PxN)
%   c_xi        : labels of examples
%   lambda      : relevance vector/matrix/cells of matrices
%   param       : structure of parameters
%       param.algo    :   algorithm
%
% Outputs:
%    error_rate : classification (quantization) error
%    errortype  :  Type-I, Type-II classification errors
%    wins       : number of represented by


[P N] = size(xi);
nb_classes = length(unique(c_w));
n_proto = size(w,1);

dist = zeros(P,length(c_w));
for i = 1:n_proto
    delta = xi - ones(P,1)*w(i,:);
    delta(isnan(delta)) = 0;
    switch param.algo
        case {'rlvq','grlvq','vq','ng'}
            replambda = ones(P,1) * lambda;
            dist(1:P,i) = sum( (replambda .* (delta.^2))' );
        case 'lgrlvq'
            dist(1:P,i) = delta.^2*lambda{i}';
        case 'clgrlvq'
            dist(1:P,i) = delta.^2*lambda{c_w(i)}';
        case 'gmlvq'
            dist(1:P,i) = sum( ((delta*lambda).*delta) ,2 );  % Hadamard product: to skip unnecessary calculation between two different examples
        case 'lgmlvq'
            dist(1:P,i) = sum( ((delta*lambda{i}).*delta) ,2 );  % Hadamard product: to skip unnecessary calculation between two different examples
        otherwise
            error('algorithm not supported')
    end
end
[dJ J] = min(dist,[],2);  % distance and index of closest prototype


switch param.algo

    case {'vq','ng'}  % Quantization error

        error_rate = 1/2 * sum(dJ) / P;
        error_type = [];

    case {'rlvq','grlvq','lgrlvq','clgrlvq','gmlvq','lgmlvq'}  % Classification error
    
        c_J = c_w(J); % class of nearest prototype
        error_rate = sum( c_xi ~= c_J )/P;
        error_type = zeros(nb_classes,2) ;
        for j=1:nb_classes
            % type 1 errors, false positives
            B = find(c_J == j);
            if B>0,
                error_type(j,1) = sum( c_xi(B) ~= j ) / length(B);
            else error_type(j,1) = 0; end

            % type 2 errors, false negatives
            C = find(c_xi == j);
            if C>0
                error_type(j,2) = sum( c_J(C) ~= j ) / length(C);
            else error_type(j,1) = 0; end
        end
        
    otherwise
        error('algorithm not supported')
end

% Count wins for each prototype
for i=1:length(c_w)
    wins(i) = sum( J==i )/P;
end

