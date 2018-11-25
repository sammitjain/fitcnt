% Vary the number of tuples T to see how it affects performance

% Load the train and test sets
load constSplit.mat;
vals = 10:30:310;

rule = 2;

F = 1024;

N = 14;

%T = 100;

L = 2;

K = 10;

acc_table = zeros(size(vals,2),2);

k = 1;

for v = vals
    disp(['####  T = ' num2str(v) '  ####']);
    tuples = n_make_tuples(N,v,F);
    mem = n_create_memory(N,v,L,K,1);
    tic
    mem = n_tuple_train(train,tuples,mem,N,v,L,K);
    toc
    
    train_scores = n_tuple_test(train,tuples,mem,rule,N,v,L,K);
    test_scores = n_tuple_test(test,tuples,mem,rule,N,v,L,K);
    [~,acc1] = n_predict(test,test_scores);
    [~,acc2] = n_predict(train,train_scores);
    
    disp(['Training Accuracy = ' num2str(acc2) ' %']);
    disp(['Testing Accuracy = ' num2str(acc1) ' %']);
    acc_table(k,:) = [acc2 acc1];
    k = k + 1;
end

plot(acc_table,'o-','LineWidth',2);
hold on;