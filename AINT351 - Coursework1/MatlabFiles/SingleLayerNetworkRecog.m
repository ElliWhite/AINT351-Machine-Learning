function [] = SingleLayerNetworkRecog()
%FUNCTION TO IMPLEMENT A SINGLE LAYER NETWORK RECOGNISER
% Student Number:   10467243
% Module:           AINT351
% Date:             18/11/2017

    %generate uniform input data
    [inputData, ~] = DummyDataForSLNRecog('noplot');

    %randomise weights vector
    weights = rand(3,1);

    %create augmented bias vector. One point for every input data point
    biasVector = ones(1000,1);

    %concatenate inputData and biasVector into 1000x3 matrix
    inputData = [inputData, biasVector];

    %network sum function of the network
    NetworkSumFunction = inputData*weights;

    %extract the class 1 points
    Class1Points = NetworkSumFunction > 0.5;        %find class 1 data points
    class1DataPoints = inputData(Class1Points,:);   %create vector containing class 1 points

    %extract the class 2 points
    Class2Points = NetworkSumFunction <= 0.5;       %find class 2 data points
    class2DataPoints = inputData(Class2Points,:);   %create vector containing class 2 points

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

