% Vary Initial value in tables from 0.1 to 1. Also keep split constant.
% Rotate the tuples

% Load the constant training, testing and crossval sets
load constSplit.mat;

% Create tuples. These get randomized at each execution of this script.
tuples = n_make_tuples(18,100,1024);
vals = 0.1:0.1:1;

rule = 2;

N = 18;

T = 100;

L = 2;

K = 10;

acc_table = zeros(size(vals,2),1);

k = 1;

for v = vals
    disp(['v = ' num2str(v)]);
    mem = n_create_memory(N,T,L,K,v);
    tic
    mem = n_tuple_train(train,tuples,mem,N,T,L,K);
    toc
    
    test_scores = n_tuple_test(test,tuples,mem,rule,N,T,L,K);
    [~,acc] = n_predict(test,test_scores);
    
    disp(['Accuracy = ' num2str(acc) ' %']);
    
    acc_table(k) = acc;
    k = k + 1;
end

plot(acc_table);
hold on;