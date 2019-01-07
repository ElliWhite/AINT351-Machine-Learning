function [] = SingleLayerNetworkTestOnUniformData(finalWeights)
%FUNCTION TO TEST A SINGLE LAYER NETWORK ON UNIFORM DATA
% Student Number:   10467243
% Module:           AINT351
% Date:             18/11/2017

    %generate uniform data with 2 dimensions
    [ uniformData ] =  GenerateUniformData('noplot', 2);

    %number of data points
    dataPoints = 1000;

    %weights are the final weights used from the training
    weights = finalWeights;

    %create augmented bias vector. One point for every input data point
    biasVector = ones(1, dataPoints);

    %concatenate uniformData and biasVector into 1000x3 matrix
    inputData = [uniformData', biasVector'];

    %network sum function of the network
    NetworkSumFunction = inputData*weights;

    %extract the class 1 points
    Class1Points = NetworkSumFunction > 0.5;        %find class 1 data points
    class1DataPoints = inputData(Class1Points,:);   %create vector containing class 1 points

    %extract the class 2 points
    Class2Points = NetworkSumFunction <= 0.5;       %find class 2 data points
    class2DataPoints = inputData(Class2Points,:);    %create vector containing class 2 points

    %new figure
    figure;
    hold on;
    plot(class1DataPoints(:,1), class1DataPoints(:,2), 'bo');   %plot class1 X against Y in blue crosses
    plot(class2DataPoints(:,1), class2DataPoints(:,2), 'r+');   %plot class2 X against Y in red crosses
    axis([-10 10 -10 10]);
    xlabel('x-value');
    ylabel('y-value');
    legend('Class 1', 'Class 2');
    title('Output Single Layer Network Tested on Uniform Data');

end

