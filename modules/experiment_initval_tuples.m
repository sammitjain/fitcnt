% Vary Initial value in tables from 0.1 to 1. Also keep tuples constant.
% Rotate the 80-20 split
load deva_final.mat; %This loads data
trp = 0.7;
tep = 0.3;
crp = 0;

% Split data according to percentage. Each RUN ensures rotated split.
[train,test,crossval] = n_ttc_split(data,trp,tep,crp);

load constTuples.mat; %This loads constant set of tuples for all runs

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
