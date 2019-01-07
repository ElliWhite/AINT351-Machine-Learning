function [] = SingleLayerNetworkTest(finalWeights)
%FUNCTION TO TEST A SINGLE LAYER NETWORK
% Student Number:   10467243
% Module:           AINT351
% Date:             18/11/2017

    %generate class 1 & class 2 testing data
    [ class1Data, class2Data ] = GenerateTrainingAndTestData('test');

    %number of data points
    dataPoints = 1000;

    %weights are the final weights used from the training
    weights = finalWeights;
    
    %create augmented bias vector. One point for every input data point
    biasVector = ones(1, dataPoints);

    %concatenate classData and biasVector into 1000x3 matrix. Do this for
    %class 1 and class 2
    class1Data = [class1Data', biasVector'];
    class2Data = [class2Data', biasVector'];

    %concatenate both classDatas into inputData which is now a 3x2000 matrix
    inputData = [class1Data', class2Data'];
    %transpose inputData into 2000x3
    inputData = inputData';

    %network sum function of the network
    NetworkSumFunction = inputData*weights;

    %extract the class 1 points
    Class1Points = NetworkSumFunction > 0.5;        %find class 1 data points
    class1DataPoints = inputData(Class1Points,:);   %create vector containing class 1 points

    %extract the class 2 points
    Class2Points = NetworkSumFunction <= 0.5;       %find class 2 data points
    class2DataPoints = inputData(Class2Points,:);   %create vector containing class 2 points

    %count number points in the first 1000 of NetworkSumFunction that are
    %bigger than 0.5. This indicates the number of correctly classed
    %Class1 points
    numberOfClass1Correct = sum(NetworkSumFunction(1:1000) > 0.5);
    %count number points in the second 1000 of NetworkSumFunction that are
    %less than or equal to 0.5. This indicates the number of correctly classed
    %Class2 points
    numberOfClass2Correct = sum(NetworkSumFunction(1001:2000) <= 0.5);
    %calculate overal percentage of correctly classed points
    percentageOfClassesCorrect = ((numberOfClass1Correct + numberOfClass2Correct) / 2000) * 100;

    %print to console 
    fprintf('Percentage of correctly classified data: %d%%', percentageOfClassesCorrect);

    %new figure
    figure;
    hold on;
    plot(class1DataPoints(:,1), class1DataPoints(:,2), 'bo');   %plot class1 X against Y in blue crosses
    plot(class2DataPoints(:,1), class2DataPoints(:,2), 'r+');   %plot class2 X against Y in red crosses
    axis([-10 10 -10 10]);
    xlabel('x-value');
    ylabel('y-value');
    legend('Class 1', 'Class 2');   %create legend
    title('Output Single Layer Network Tested on Guassian Data');

end

