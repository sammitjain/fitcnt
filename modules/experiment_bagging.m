%% Bag B N-tuple classifiers
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


B = 10;
preds = zeros(size(test,1),B);

N = 18;
T = 100;
F = size(test,2)-1;

val = 1; % default value for each entry of table
%mem = n_create_memory(N,T,L,K,val);


for i = 1:B
    mem = n_create_memory(N,T,L,K,val);
    tuples = n_make_tuples(N,T,F);
    tic
    mem = n_tuple_train(train,tuples,mem,N,T,L,K);
    toc
    
    rule = 2; % 1: sum rule (~77% accuracy)
          % 2: product rule (~88% accuracy)
    test_scores = n_tuple_test(test,tuples,mem,rule,N,T,L,K);

    %Predict using max of test scores
    predictions = zeros(size(test,1),1);
        for m = 1:size(test,1)
            [~,predictions(m)] = max(test_scores(m,:));
        end

    accuracy = 100*sum(predictions==test(:,end))/size(test,1);
    disp(['Accuracy = ' num2str(accuracy) ' %']);
    
    preds(:,i) = predictions;
end

%% Aggregating results
superPred = zeros(size(test,1),1);
for i = 1:size(test,1)
    superPred(i) = mode(preds(i,:));
end

superAccuracy = 100*sum(superPred==test(:,end))/size(test,1);
disp(['Super Accuracy = ' num2str(superAccuracy) ' %']);