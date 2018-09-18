function [tuples,accuracy] = find_best_tuple(num_iter)
    [tuples,accuracy] = svm_n_tuple_splice(240,4);
    
    for i = 2:num_iter
        
        [temp_tuples,temp_accuracy] = svm_n_tuple_splice(240,4);
        if temp_accuracy > accuracy
            tuples = temp_tuples;
            accuracy = temp_accuracy;
        end
        
        disp([' I T E R A T I O N # : ' num2str(i) ' Accuracy: ' num2str(temp_accuracy) ' %']);
    end
end