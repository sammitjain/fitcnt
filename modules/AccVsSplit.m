% Vary the training percentage: 0.4 to 0.9

% Load the data
load deva_final.mat;

% Create tuples. These get randomized at each execution of this script.
tuples = n_make_tuples(18,100,1024);
vals = 0.4:0.1:0.9;

rule = 2;

N = 18;

T = 100;

L = 2;

K = 10;

acc_table = zeros(size(vals,2),2);

k = 1;

for v = vals
    disp(['v = ' num2str(v)]);
    [train,test,crossval] = n_ttc_split(data,v,1-v,0);
    mem = n_create_memory(N,T,L,K,1);
    tic
    mem = n_tuple_train(train,tuples,mem,N,T,L,K);
    toc
    
    train_scores = n_tuple_test(train,tuples,mem,rule,N,T,L,K);
    test_scores = n_tuple_test(test,tuples,mem,rule,N,T,L,K);
    [~,acc1] = n_predict(test,test_scores);
    [~,acc2] = n_predict(train,train_scores);
    
    disp(['Training Accuracy = ' num2str(acc2) ' %']);
    disp(['Testing Accuracy = ' num2str(acc1) ' %']);
    acc_table(k,:) = [acc1 acc2];
    k = k + 1;
end

plot(acc_table,'--','LineWidth',2);
hold on;