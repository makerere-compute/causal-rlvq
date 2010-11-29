function data_norm = z_transformation (data)

labels = data(:,end);
data = data(:,1:end-1);

data_norm = zeros(size(data));

for i=1:size (data,2)
    mn_data = mean (data (:,i));
    sq_data = sqrt (var (data (:,i)));

    data_norm (:,i) = (data (:,i)-mn_data)/sq_data;
end

data_norm = [data_norm labels];
end