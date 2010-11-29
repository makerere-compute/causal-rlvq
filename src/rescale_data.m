function [nxi mean1 std1] = rescale_data(xi_raw) 
% rescale to mean 0 and variance 1

[I J] = size(xi_raw);
nxi = zeros(I,J);

mean1 = nanmean(xi_raw);
std1  = nanstd(xi_raw);

for j = 1:J;   
    if std1(j) ~= 0;
        nxi(1:I,j) = (xi_raw(1:I,j) - mean1(j))/std1(j);
    else
        nxi(1:I,j) = 0;
    end
end
return    

