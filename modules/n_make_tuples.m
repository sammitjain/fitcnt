function tuples = n_make_tuples(N,T,F)
    tuples = zeros(T,N);
    for i = 1:T
        tuples(i,:) = randperm(F,N);
    end
end