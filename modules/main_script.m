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

%% Test-train-crossval split
train_perc = 0.75;
test_perc = 0.25;
crossval_perc = 0;
[train,test,crossval] = n_ttc_split(data,train_perc,test_perc,crossval_perc);

%% Create tuples
N = 18; % tuple length
T = 100; % number of tuples
F = size(data,2)-1; % number of features
tuples = n_make_tuples(N,T,F);

%% Create memory structure
val = 1; % default value for each entry of table
mem = n_create_memory(N,T,L,K,val);

%% Tabulate probability values (Training)
tic
mem = n_tuple_train(train,tuples,mem,N,T,L,K);
toc
%% Adjust values, cross-validation, combining classifiers, etc

%% Test the classifer
rule = 2; % 1: sum rule (~82% accuracy)
          % 2: product rule (~92% accuracy)
test_scores = n_tuple_test(test,tuples,mem,rule,N,T,L,K);

%Predict using max of test scores
predictions = zeros(size(test,1),1);
    for m = 1:size(test,1)
        [~,predictions(m)] = max(test_scores(m,:));
    end

accuracy = 100*sum(predictions==test(:,end))/size(test,1);
disp(['Accuracy = ' num2str(accuracy) ' %']);