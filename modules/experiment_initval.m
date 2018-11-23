vals = 0.1:0.1:1;
load default_vals.mat
rule = 1;
N = 18;
T = 100;
acc_table = zeros(size(vals,2),1);

tuples = tuple_setup(N,T);

%% Test-train-crossval split
train_perc = 0.8;
test_perc = 0.2;
crossval_perc = 0;
[train,test,crossval] = n_ttc_split(data,train_perc,test_perc,crossval_perc);
k = 1;
for v = vals
    disp(v);
    mem = n_create_memory(N,T,L,K,v);
    disp(mem{1}{1}(1));
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
    acc_table(k) = accuracy;
    k = k+1;
end
