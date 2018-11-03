function [data,level_vals] = n_quantize(data,d_range,L,type)
    if(type==1)
        min = d_range(1);
        max = d_range(2);
        levels = 0:L-1;
        level_vals = round((max-min)./(levels+1));
        
        level_vals = [level_vals 0];
        level_vals = level_vals(end:-1:1);
        
        data_q = discretize(data(:,1:end-1),level_vals);
        
        data_q = data_q-1;
        
        data = [data_q data(:,end)];
    end
end