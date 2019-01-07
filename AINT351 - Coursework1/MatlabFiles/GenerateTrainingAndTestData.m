function [ class1Data, class2Data ] = GenerateTrainingAndTestData(trainOrTest)
%FUNCTION TO GENERATE A TRAINING AND TEST DATASET
% Student Number:   10467243
% Module:           AINT351
% Date:             18/11/2017
% Generate a training dataset of 1000 samples and a testing dataset of 1000
% samples

    % set the mean and covariance for class 0 data points for training data
    Mean1 = [3; -1;];
    Sigma1 = [0.5 0.95; 0.95 4];

    % set the mean and covariance for class 1 data points for training data
    Mean2 = [-3; -1;];
    Sigma2 = [0.5 0.95; 0.95, 4];
    
    % set the mean and covariance for class 0 data points for testing data
    Mean3 = [5; 2;];
    Sigma3 = [0.6 0.9; 0.25 3];

    % set the mean and covariance for class 1 data points for testing data
    Mean4 = [-6; 1;];
    Sigma4 = [0.1 0.3; 0.35, 1];
    
    % generate the training dataset
    trainingSamples = 1000;
    [trainingData, trainingTarget] = GenerateGaussianData(trainingSamples, Mean1, Sigma1, Mean2, Sigma2);

    % generate the testing dataset
    testingSamples = 1000;
    [testingData, testingTarget] = GenerateGaussianData(testingSamples, Mean3, Sigma3, Mean4, Sigma4);

    if strcmp(trainOrTest, 'train')
        % extract all class 1 patterns
        % examine first dimension which is 1 for class 1
        fidx = find(trainingTarget(1,:) == 1);
        class1Data = trainingData(:,fidx);

        % extract all class 2 patterns
        % examine first dimension which is 0 for class 2
        fidx = find(trainingTarget(1,:) == 0);
        class2Data = trainingData(:,fidx);
        
        % now plot separated classes on a figure
        figure;
        hold on;
        plot(class1Data(1,:), class1Data(2,:), 'yo');
        plot(class2Data(1,:), class2Data(2,:), 'g+');
        axis([-10 10 -10 10]);
        xlabel('x-value');
        ylabel('y-value');
        legend('Class 1', 'Class 2');
        title('Training Data');
    elseif strcmp(trainOrTest, 'test')
         % extract all class 1 patterns
        % examine first dimension which is 1 for class 1
        fidx = find(testingTarget(1,:) == 1);
        class1Data = testingData(:,fidx);

        % extract all class 2 patterns
        % examine first dimension which is 0 for class 2
        fidx = find(testingTarget(1,:) == 0);
        class2Data = testingData(:,fidx);
        
        % now plot separated classes on a figure
        figure;
        hold on;
        plot(class1Data(1,:), class1Data(2,:), 'yo');
        plot(class2Data(1,:), class2Data(2,:), 'g+');
        axis([-10 10 -10 10]);
        xlabel('x-value');
        ylabel('y-value');
        legend('Class 1', 'Class 2');
        title('Testing Data');
    end
            
    

end

