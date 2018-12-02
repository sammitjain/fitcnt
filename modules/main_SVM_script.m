% Vary the tuple size N to see how it affects performance

% Load the train and test sets
load constSplit.mat;
vals = 5:5:20;

rule = 1;

F = 1024;

%N = 18;

T = 100;

L = 2;

K = 10;

acc_table = zeros(size(vals,2),2);

k = 1;
train_ids = train(:,end);
test_ids = test(:,end);

for v = vals
    disp(['####  N = ' num2str(v) '  ####']);
    tuples = n_make_tuples(v,T,F);
    mem = n_create_memory(v,T,L,K,1);
    tic
    mem = n_tuple_train(train,tuples,mem,v,T,L,K);
    toc
    
    train_scores = n_tuple_test(train,tuples,mem,rule,v,T,L,K);
    test_scores = n_tuple_test(test,tuples,mem,rule,v,T,L,K);
    [~,acc1] = n_predict(test,test_scores);
    %[~,acc2] = n_predict(train,train_scores);
    Mdl2 = fitcecoc(train_scores,train_ids);
    Yp2 = predict(Mdl2,test_scores);
    acc2 = 100*sum(Yp2==test_ids)/size(test,1);
    disp(['Accuracy = ' num2str(acc1) ' %']);
    disp(['Accuracy with SVM = ' num2str(acc2) ' %']);
    
    acc_table(k,:) = [acc1 acc2];
    k = k + 1;
end

plot(acc_table,'o-','LineWidth',2);
hold on;