%% Two-layered N-tuple method
% (Will add details soon)

load deva_final.mat;

%% First layer:
[train,test,crossval] = n_ttc_split(data,0.4,0.1,0.5);

K = 10; % number of classes
N = 12; % tuple length
T = 100; % number of tuples
F = size(data,2)-1; % number of features
L = 2;
tuples = n_make_tuples(N,T,F);

val = 1; % default value for each entry of table
mem = n_create_memory(N,T,L,K,val);

tic
mem = n_tuple_train(train,tuples,mem,N,T,L,K);
toc

%% Predicting on the cross-validation set
rule = 2;
cross_scores = n_tuple_test(crossval,tuples,mem,rule,N,T,L,K);

predictions = zeros(size(crossval,1),1);
    for m = 1:size(crossval,1)
        [~,predictions(m)] = max(cross_scores(m,:));
    end
a_cross = 100*sum(predictions==crossval(:,end))/size(crossval,1)

%% Adding cross-validation predictions as features to crossval

layer2data = [crossval(:,1:end-1) dummyvar(predictions) crossval(:,end)];

%% Second Layer

%[train2,test2,crossval2] = n_ttc_split(layer2data,0.75,0.25,0);

K2 = 10; % number of classes
N2 = 12; % tuple length
T2 = 100; % number of tuples
F2 = size(layer2data,2)-1; % number of features
L2 = 2;
tuples2 = n_make_tuples(N2,T2,F2);

val2 = 1; % default value for each entry of table
mem2 = n_create_memory(N2,T2,L2,K2,val2);

tic
mem2 = n_tuple_train(layer2data,tuples2,mem2,N2,T2,L2,K2);
toc

%% TESTING. FIRST LAYER 1, THEN LAYER 2
rule2 = 2;
test_scores = n_tuple_test(test,tuples,mem,rule,N,T,L,K);

t1 = zeros(size(test,1),1);
    for m = 1:size(test,1)
        [~,t1(m)] = max(test_scores(m,:));
    end
A1 = 100*sum(t1==test(:,end))/size(test,1)

testN = [test(:,1:end-1) dummyvar(t1) test(:,end)];

testN_scores = n_tuple_test(testN,tuples2,mem2,rule2,N2,T2,L2,K2);

t2 = zeros(size(testN,1),1);
    for m = 1:size(testN,1)
        [~,t2(m)] = max(testN_scores(m,:));
    end
A2 = 100*sum(t2==testN(:,end))/size(testN,1)
