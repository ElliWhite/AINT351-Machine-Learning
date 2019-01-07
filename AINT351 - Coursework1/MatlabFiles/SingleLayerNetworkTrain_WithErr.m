function [ finalWeights ] = SingleLayerNetworkTrain_WithErr()
%FUNCTION TO TRAIN A SINGLE LAYER NETWORK AND PLOT THE ERROR
% Student Number:   10467243
% Module:           AINT351
% Date:             18/11/2017

    %generate class 1 & class 2 training data
    [ class1Data, class2Data ] = GenerateTrainingAndTestData('train');

    %number of data points
    dataPoints = 1000;

    %randomise initial weights vector
    weights = rand(3,1);

    %learning rate
    alpha = 0.0001;
    
    %create augmented bias vector. One point for every input data point
    biasVector = ones(1, dataPoints);

    %concatenate classData and biasVector into 1000x3 matrix. Do this for
    %class 1 and class 2
    class1Data = [class1Data', biasVector'];
    class2Data = [class2Data', biasVector'];

    %create target data. 1s for class 1. 0s for class 2
    c1Target = ones(1,dataPoints);
    c2Target = zeros(1,dataPoints);

    %concatenate both classDatas into inputData which is now a 3x2000 matrix
    inputData = [class1Data', class2Data'];
    %transpose inputData into 2000x3
    inputData = inputData';
    %concatenate the target data into outputTargetData which is now 1000x2
    %matix
    outputTargetData = [c1Target'; c2Target'];
    
    %create empty vector of error values. The index corresponds to the time
    %we iterate over the dataset
    finalError = [];

    %for loop to iterate over the whole dataset
    for j = 1:20

        %reset the error for the current iteration
        networkError = 0;

        %iterate over all the data points
        for i = 1:2000

            %determine output based on input and weights
            actualOutput =  inputData(i,:)*weights;

            %cost function gradient. deltaError / deltaWeights
            dEdW = -(outputTargetData(i)- actualOutput)*(inputData(i,:));

            %update the weights based on the delta rule
            weights = weights - (alpha.*dEdW');

            %calculate the sum squared error
            networkError = networkError + (outputTargetData(i) -  actualOutput)^2;

        end

        %put the error for this iteration into the finalError array
        finalError(j) = networkError;
        
        %check if the difference between the current error and the last
        %error is small (less than 2)
        %if it is, then break out of overall for-loop
        if j > 1
            if finalError(j) > (finalError(j-1) - 2)
                break
            end
        end

    end

    %output our final weights so we can use them to test on other datasets
    finalWeights = weights;

    %new figure
    figure;
    hold on;
    plot(finalError,'r')    %plot our finalError array
    xlabel('Iterations Over Dataset');
    ylabel('Mean Square Error');
    title(['Mean Square Error Over Dataset. Alpha = ' num2str(alpha)]);


end

