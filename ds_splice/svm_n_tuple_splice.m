%%  N-tuple + SVM implementation
%   By - Sammit Jain | Visiting Research Scholar, CUNY
%   Dataset - Splice-junction gene sequences


%% Import and prepare data

data = csvread('splice3.csv');

num_classes = 3;

fv_length = size(data,2)-1; % 60

N = 4;  % length of each tuple

M = 240;    % number of tuples

base = 4; % Each feature can take values 1,2,3 or 4
random_indices = randperm(size(data,1));

train = data(random_indices(1:round(0.5*size(data,1))),:);

crossval = data(random_indices(round(0.5*size(data,1))+1:round(0.75*size(data,1))),:);

test = data(random_indices(round(0.75*size(data,1))+1:end),:);

disp("Completed: Data preprocesing + partitioning");

%% Create tuples (random)

tuples = zeros(M,N);

for i = 1:M
    tuples(i,:) = randperm(fv_length,N);
end

disp("Completed: Tuple generation");

%% Initialize memory structure
mem = cell([1 M]);

table_mk = zeros(base^N,1);

for i = 1:M
    for k = 1:num_classes+1
    mem{i}{k} = table_mk;
    end
end

disp("Completed: Memory structure init");
%% Training the network
tic
for i = 1:M % loop across all tuples
     %disp(['Tuple number: ' num2str(i)]);
    for j = 1:size(train,1) % loop across all data points
        linear_address = tuple_to_linear(train(j,tuples(i,:)),N,base);
        mem{i}{num_classes+1}(linear_address) = mem{i}{num_classes+1}(linear_address)+1;
        k = train(j,end); % class of jth data point
        mem{i}{k}(linear_address) = mem{i}{k}(linear_address) + 1;
    end
end
toc

disp("Completed: Network training");

tdata = tabulate(train(:,end));
for i = 1:M
    for k = 1:num_classes
        mem{i}{k} = mem{i}{k}/tdata(k,2);
    end
end

disp("Completed: Normalization of values");

%% Training SVM on CV data points
svm_scores = zeros(size(crossval,1),num_classes);

predicted_class = zeros(size(test,1),1);

 for d = 1:size(crossval,1)
     tuple_scores = zeros(M,num_classes);
    for i = 1:M
        linear_address = tuple_to_linear(crossval(d,tuples(i,:)),N,base);
    
        if mem{i}{num_classes+1}(linear_address)>0
            for k = 1:num_classes
                tuple_scores(i,k) = mem{i}{k}(linear_address);
            end
        end     
    end
    svm_scores(d,:) = sum(tuple_scores);

 end
 
disp("Completed: Calculation of crossval scores");
 X = svm_scores;
 Y = crossval(:,end);
 
 Mdl = fitcecoc(X,Y);
 
 disp("Completed: SVM modelling of crossval set");
 
 %% Test scores
test_scores = zeros(size(test,1),num_classes);

 for d = 1:size(test,1)
     tuple_scores = zeros(M,num_classes);
    for i = 1:M
        linear_address = tuple_to_linear(test(d,tuples(i,:)),N,base);
    
        if mem{i}{num_classes+1}(linear_address)>0
            for k = 1:num_classes
                tuple_scores(i,k) = mem{i}{k}(linear_address);
            end
        end     
    end
    test_scores(d,:) = sum(tuple_scores);

 end

 Yp = predict(Mdl,test_scores);

 disp("Completed: Prediction using SVM");
accuracy = 100*sum(Yp==test(:,end))/size(test,1);
disp(['Accuracy = ' num2str(accuracy) ' %']);