function mem = n_tuple_train(train,tuples,mem,N,T,L,K)
    for t = 1:T % loop across all tuples
     disp(['Tuple number: ' num2str(t)]);
        for m = 1:size(train,1) % loop across all data points
            linear_address = tuple_to_linear(train(m,tuples(t,:)),N,L);
            k = train(m,end); % class of jth data point
            mem{t}{k}(linear_address) = mem{t}{k}(linear_address) + 1;
        end
    end
    
    tdata = tabulate(train(:,end));
    for t = 1:T
        for k = 1:K
            mem{t}{k} = mem{t}{k}/tdata(k,2);
        end
    end
end