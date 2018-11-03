function linear_idx = tuple_to_linear(tuple,N,L)
% This script takes a vector [x,y,z...w] and converts it to a linear address

    linear_idx = sum(tuple.*(L.^(N-1:-1:0)))+1;
    % +1 for starting at index 1
end