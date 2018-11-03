function [train,test,crossval] = n_ttc_split(data,train_perc,test_perc,crossval_perc)

    random_indices = randperm(size(data,1));
    train    = data(random_indices(1:round(train_perc*size(data,1))),:);
    crossval = data(random_indices(round(train_perc*size(data,1))+1:round((train_perc+crossval_perc)*size(data,1))),:);
    test     = data(random_indices(round((train_perc+crossval_perc)*size(data,1))+1:round((train_perc+crossval_perc+test_perc)*size(data,1))),:);
end