function [Yp,tuples,mem,accuracy] = fitnt(data,K,L,type,d_range,trp,tep,crp,N,T,val,rule)

[data,level_vals] = n_quantize(data,d_range,L,type);

[train,test,crossval] = n_ttc_split(data,trp,tep,crp);

F = size(data,2)-1; % number of features
tuples = n_make_tuples(N,T,F);

mem = n_create_memory(N,T,L,K,val);

tic
mem = n_tuple_train(train,tuples,mem,N,T,L,K);
toc

test_scores = n_tuple_test(test,tuples,mem,rule,N,T,L,K);

%Predict using max of test scores
Yp = zeros(size(test,1),1);
    for m = 1:size(test,1)
        [~,Yp(m)] = max(test_scores(m,:));
    end

accuracy = 100*sum(Yp==test(:,end))/size(test,1);
disp(['Accuracy = ' num2str(accuracy) ' %']);
end