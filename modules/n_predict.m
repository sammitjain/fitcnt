function [predictions,acc] = n_predict(test,test_scores)
predictions = zeros(size(test,1),1);

for m = 1:size(test,1)
    [~,predictions(m)] = max(test_scores(m,:));
end

acc = 100*sum(predictions==test(:,end))/size(test,1);
end