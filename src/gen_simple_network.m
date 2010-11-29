clear
n = 10000;

% model params for network with arcs:
% b->a
% c->a
% a->d
% a->e
% f independent
% Take a as target variable

cov_b = 2;
mu_b = 3;

cov_c = 3;
mu_c = 2.5;

coeff_ba = 1.1;
coeff_ca = 0.8;
cov_a = .2;
mu_a = 0.5;


cov_d_a0 = 2.5;
mu_d_a0 = -1;
cov_d_a1 = 1.5;
mu_d_a1 = 2;

cov_e_a0 = 3.2;
mu_e_a0 = 0;
cov_e_a1 = 1;
mu_e_a1 = 2;

cov_f = 1;
mu_f = 2;


% Sample data given linear Gaussian parameters
b = randn(n,1)*sqrt(cov_b) + repmat(mu_b,n,1); % cause 1
c = randn(n,1)*sqrt(cov_c) + repmat(mu_c,n,1); % cause 2
f = randn(n,1)*sqrt(cov_f) + repmat(mu_f,n,1); % Non correlated variable
a = (coeff_ba*b + coeff_ca*c +  randn(n,1)*sqrt(cov_a) + repmat(mu_a,n,1))>6; % target
for i=1:n
    if a(i)==0
        d(i) = randn*sqrt(cov_d_a0) + mu_d_a0; % effect 1
        e(i) = randn*sqrt(cov_e_a0) + mu_e_a0; % effect 2
    else
        d(i) = randn*sqrt(cov_d_a1) + mu_d_a1; % effect 14.0000    5.0000    1.8717
        e(i) = randn*sqrt(cov_e_a1) + mu_e_a1; % effect 2        
    end
end
d = d';
e = e';

% data: strong cause, weak cause, independent, weak effect, strong effect
data = [b c f e d a];
data = z_transformation(data);