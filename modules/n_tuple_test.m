function test_scores = n_tuple_test(test,tuples,mem,N,T,L,K)

test_scores = zeros(size(test,1),K);
 for m = 1:size(test,1)
     tuple_scores = zeros(T,K);
     
    for t = 1:T
        linear_address = tuple_to_linear(test(m,tuples(t,:)),N,L);
            for k = 1:K
                tuple_scores(t,k) = mem{t}{k}(linear_address);
            end    
    end
    
    test_scores(m,:) = sum(tuple_scores); 
 end
 
 
end