# N-Tuple Method

The N-Tuple Method has it's humble origins in early Pattern Recognition problems, notably the Hand-written character recognition problem. Developed by Bledsoe and Browning by 1959, as a classification algorithm, it breaks down high-dimensional models into many smaller models, which are easier to handle. The idea is to take T sets of size N subsets of the feature space. Each subset of size N is called a tuple, and becomes one of the many representatives for the data, thus giving this method the name - The N-tuple Method. 

# Why?
This method has some very clear advantages over conventional Deep Learning-based solutions. The algorithm isn't a black box and more importantly, it consumes significantly lesser time to train. This algorithm thus deserves to be experimented with, because we're always surround by constraints of time and memory. 

# What is this?
From what I could find on the internet, there don't seem to be any ready-to-use implementations of the N-tuple method for research. This is a step in that direction. This is a collection of small modules, that each play a role in making the N-tuple method work. 

This is a fairly basic MATLAB implementation of the N-tuple classifier, with my own additional fine-tuning options for better accuracies. I'm also researching on combining various classifiers over the N-tuple network, adding layers, and also Bagging. For this algorithm, I'm using the Kaggle Devanagari Character Dataset https://www.kaggle.com/ashokpant/devanagari-character-dataset-large/home

This work is part of my research work with Prof. Robert M. Haralick, Distinguished Professor of Computer Science at The Graduate Center, City University of New York. 

With a simple implementation of this algorithm, which takes about 8 seconds to train on a normal PC, I get accuracies of ~95% without the additional fine-tuning. 

# HOW TO USE THIS?
- Clone this repository. Work with the modules/ directory. 
- Change the load statement in the main_script.m file (if you're using a different dataset)
- Make sure your data is in a format that's well supported by the N-tuple tables. 
- Experiment with values of N, T, type, val. 
- Check out my experiments (all files that begin with 'experiment_') and see if they help you achieve better performance

Please contact me at sammit.bitspilani@gmail.com if you have any suggestions/queries. 
