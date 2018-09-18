function data = digit_sampling(num_samples,data)
    % after loading devanagri_all_digits.mat
    
    data = [data(1:num_samples,:);data(2001:2000+num_samples,:);data(4001:4000+num_samples,:);data(6001:6000+num_samples,:)];
    
end