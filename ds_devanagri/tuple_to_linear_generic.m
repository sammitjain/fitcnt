function linear_idx = tuple_to_linear_generic(tuple,N,base)
% This script takes a vector [x,y,z...w] and converts it to a linear address

linear_idx = sum(tuple.*(base.^(N-1:-1:0)))+1;
% +1 for starting at index 1
end
