function mem = n_create_memory(N,T,L,K)
mem = cell([1 T]);

table_tk = zeros(L^N,1);

for t = 1:T
    for k = 1:K+1
        mem{t}{k} = table_tk;
    end
end

end