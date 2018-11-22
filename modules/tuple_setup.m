function tuples = tuple_setup(N,T)
%% Prepare data
% Load dataset
load deva_final.mat
K = 10; % number of classes
% Choose portion of dataset to use

%% Quantize data into L levels: 0,1,...,L-1
L = 2;
type = 1; %equal divisions
d_range = [0 1]; %range of values (min,max)
[data,level_vals] = n_quantize(data,d_range,L,type);



%% Create tuples
%N = 18; % tuple length
%T = 100; % number of tuples
F = size(data,2)-1; % number of features
tuples = n_make_tuples(N,T,F);

end