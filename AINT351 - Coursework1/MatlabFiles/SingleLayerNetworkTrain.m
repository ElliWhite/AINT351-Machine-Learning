function [] = SingleLayerNetworkTrain()
%FUNCTION TO TRAIN A SINGLE LAYER NETWORK
% Student Number:   10467243
% Module:           AINT351
% Date:             18/11/2017

    %generate uniform input data
    [inputData, outputTargetData] = DummyDataForSLNRecog('plot');

    %number of samples
    dataPoints = 1000;

    %randomise initial weights vector
    weights = rand(3,1);

    %learning rate
    alpha = 0.0005;

    %create augmented bias vector. One point for every input data point
    biasVector = ones(dataPoints,1);

    %concatenate inputData and biasVector into 1000x3 matrix
    inputData = [inputData, biasVector];


    %Delta rule for a single layer network
    for i = 1:dataPoints    %iterate through all data points
 
        %determine output based on input and weights
        actualOutput =  inputData(i,:)*weights;
 
        %cost function gradient. deltaError / deltaWeights
        dEdW = -(outputTargetData(i)-actualOutput)*(inputData(i,:));

        %update the weights based on the delta rule
        weights = weights - alpha.*dEdW';

    end

    %network sum function of the network based on final weights
    NetworkSumFunction = inputData*weights;

    %extract the class 1 points
    xClassPoints = NetworkSumFunction > 0.5;
    class1DataPoints = inputData(xClassPoints,:);
    
    %extract the class 2 points
    yClassPoints = NetworkSumFunction <= 0.5;
    class2DataPoints = inputData(yClassPoints,:);

    %new figure
    figure;
    hold on;
    axis([-10 10 -10 10]);        
    xlabel('x-value');            
    ylabel('y-value');            
    title('Test Data Classified');
    plot(class1DataPoints(:,1),class1DataPoints(:,2),'bx')  %plot class1 X against Y in blue crosses
    plot(class2DataPoints(:,1),class2DataPoints(:,2),'rx')  %plot class2 X against Y in red crosses
    legend('Class 1', 'Class 2');                           %create legend


end

