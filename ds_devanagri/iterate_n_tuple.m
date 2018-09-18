function perf = iterate_n_tuple(num_iter)

    perf = zeros(1,num_iter);

    load devanagri_all_digits.mat data;

    num_samples = 500;  % of each digit out of 2000

    data = digit_sampling(num_samples,data); %get data from .mat file

    quantized_data = [data(:,1:end-1)<128 data(:,end)];

    num_classes = 4;

    data = quantized_data;

    fv_length = size(data,2)-1; % 1024

    N = 5;  % length of each tuple

    M = 600;    % number of tuples

    base = 2; % Each feature can take values 1,2,3 or 4

    for l = 1:num_iter
        random_indices = randperm(size(data,1));
        train = data(random_indices(1:round(0.75*size(data,1))),:);
        test = data(random_indices(round(0.75*size(data,1))+1:end),:);

        tuples = zeros(M,N);

        for i = 1:M
            tuples(i,:) = randperm(fv_length,N);
        end

        save tuples_splice.mat tuples

        mem = cell([1 M]);

        table_mk = zeros(base^N,1);

        for i = 1:M
            for k = 1:num_classes+1
            mem{i}{k} = table_mk;
            end
        end
        tic
        for i = 1:M % loop across all tuples
             %disp(['Tuple number: ' num2str(i)]);
            for j = 1:size(train,1) % loop across all data points
                linear_address = tuple_to_linear_generic(train(j,tuples(i,:)),N,base);
                mem{i}{num_classes+1}(linear_address) = mem{i}{num_classes+1}(linear_address)+1;
                k = train(j,end); % class of jth data point
                mem{i}{k}(linear_address) = mem{i}{k}(linear_address) + 1;
            end
        end

        %disp('Normalizations of class fractions');

        tdata = tabulate(train(:,end));
        for i = 1:M
            for k = 1:num_classes
                mem{i}{k} = mem{i}{k}/tdata(k,2);
            end
        end
        toc

        predicted_class = zeros(size(test,1),1);

         for d = 1:size(test,1)
           tuple_scores = zeros(M,num_classes);  
            for i = 1:M
                linear_address = tuple_to_linear_generic(test(d,tuples(i,:)),N,base);

                if mem{i}{num_classes+1}(linear_address)>0
                    for k = 1:num_classes
                        tuple_scores(i,k) = mem{i}{k}(linear_address);
                    end
                end

            end

            [~,flags] = max(tuple_scores,[],2);
            predicted_class(d) = mode(flags);

         end

        accuracy = 100*sum(predicted_class==test(:,end))/size(test,1);
        disp(['Accuracy = ' num2str(accuracy) ' %']);
        perf(l) = accuracy;
    end
end