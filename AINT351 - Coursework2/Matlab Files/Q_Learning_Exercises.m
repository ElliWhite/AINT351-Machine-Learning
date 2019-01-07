%================================================================
%{
TOP LEVEL FILE TO EXECUTE VARIATIONS OF Q-LEARNING
    Author:            Elliott White
    Student Number:    10467243
    Date:              04/12/2017
    Module:            AINT351
%}
%================================================================

close all;

global episodeTrack;
global episodeStepMeanSTD;
global doDynaQ;
global doPOMDP;
global doSTM;
global goalState;
global numberOfTrials;
global numberOfEpisodes;
global temporalDiscountRate;
global explorationRate;
global learningRate;
global doComparison;
global doTTest;
global doUTest;
global doQuarPerf;

%select main training algorithm
%only one of these can be true based on which task to execute
%if all are false then we execute normal Q-learning
doDynaQ = false;  
doPOMDP = false;
doSTM = false;

%logic to decide if comparing two algorithms or not
doComparison = false;
%logic to decide which comparison test to do
doTTest = false;
doUTest = true;

%logic to decide to do quartile performance plotting
doQuarPerf = false;      

numberOfTrials = 50;        
numberOfEpisodes = 200; 

goalState = 2;

temporalDiscountRate = 0.9;
explorationRate = 0.1;
learningRate = 0.2;

%array of episode numbers used to store mean and standard deviation for these episodes only
episodeTrack = [1 2 5 10 15 20 30 50 75 100 150 200]; 

%matrix to store means and standard deviations for the episodes on
%episodeTrack
%first row is means, second row is standard deviation
episodeStepMeanSTD = zeros(2, size(episodeTrack,2));

%array to store to total number of steps per episode of every trial. This
%is used to calculate the average number of steps per episode
totalStepsPerTrial = zeros(1,numberOfEpisodes);

%matrix to store all steps for every episode for every trial
rawData = zeros(numberOfTrials,numberOfEpisodes);

%matrices to store the number of steps of every trial for the episopdes in
%episodeTrack. This will be used to compare the two algorithms using
%test algorithms and also used to plot the quartile performances
rawDataForEpisodeTrackAlg1 = zeros(numberOfTrials,size(episodeTrack,2));
rawDataForEpisodeTrackAlg2 = zeros(numberOfTrials,size(episodeTrack,2));
rawDataForEpisodeTrackAlg3 = zeros(numberOfTrials,size(episodeTrack,2));
  

%============================================================================
%INITIAL Q-LEARNING
for i=1:numberOfTrials
    
    disp('Trial Number');
    disp(i);
    
    %initialise the Q-Table for each trial. Q-Table is different size
    %depending on which algorithm is implemented
    if doDynaQ == true
        QTable = initQ(0.01,0.1);   
    elseif doPOMDP == true
        QTable = initQPOMDP(0.01,0.1);
    elseif doSTM == true
        QTable = initQSTM(0.01,0.1);
    else %normal Q-Learning
        QTable = initQ(0.01,0.1);
    end
    
    %used to set limits on the surf plot
    QTableSize = size(QTable);
    QTableSizeCol = QTableSize(1);
    
    %begin a trial of the selected Q-Learning algorithm
    [stepsPerEpisode,finalQTable] = trialTrainer(QTable,numberOfEpisodes);

    %store the number of steps it took per episode 
    totalStepsPerTrial = totalStepsPerTrial + stepsPerEpisode;
    
    %put the number of steps per episode into the rawData matrix
    rawData(i,:) = stepsPerEpisode;
        
    %store the mean number of steps for an episode in episodeTrack into the
    %rawData..Alg1 matrix
    rawDataForEpisodeTrackAlg1(i,:) = episodeStepMeanSTD(1,:);
    
    if (i ~= 1)
        for j=2:i
            %as episodeStepMeanSTD is accumulative, so the means can be
            %calculated, we need to find out the difference in step count
            %between two trials and adjust the matrix accordingly
            rawDataForEpisodeTrackAlg1(i,:) = rawDataForEpisodeTrackAlg1(i,:) - rawDataForEpisodeTrackAlg1(j-1,:);
        end
    end
    
end


%calculate the average number of steps per episode
averageStepsPerEpisode = totalStepsPerTrial / numberOfTrials;

%calculate the means and standard deviations for the episodes in
%episodeTrack
episodeStepMeanSTD(1,:) = episodeStepMeanSTD(1,:) / numberOfTrials;
episodeStepMeanSTD(2,:) = std(rawDataForEpisodeTrackAlg1);

%create cell matrix to store the means and standard deviations
meanAndSTD = cell(3, size(rawDataForEpisodeTrackAlg1,2) + 1);
cellRowTitles = {'Episode Number', 'Mean', 'Standard Deviation'};

 for i=1:3  
     meanAndSTD{i,1} = cellRowTitles{i};
 end
 for i=2:size(episodeTrack,2)+1
     meanAndSTD{1,i} = episodeTrack(i-1);
 end
 for i=2:size(episodeTrack,2)+1
     meanAndSTD{2,i} = episodeStepMeanSTD(1,i-1);
 end
 for i=2:size(episodeTrack,2)+1
     meanAndSTD{3,i} = episodeStepMeanSTD(2,i-1);
 end
 meanAndSTD = meanAndSTD';

%plot the intial and final Q-Table on surf plots
figure;
subplot(1,2,1);
surf(QTable);
zlim([0 1]);
ylim([0 QTableSizeCol]);
title('Initial Q Table');
xlabel('Action');
ylabel('State')

pause(0.1);

subplot(1,2,2);
max1 = max(finalQTable);
max2 = max(max1);
surf(finalQTable);
zlim([0 max2]);
ylim([0 QTableSizeCol]);
title('Final Q Table');
xlabel('Action');
ylabel('State')

pause(0.1);

%plot the Q-Learning performance improvement of the last trial
figure;
plot(stepsPerEpisode);
if doDynaQ == true
    title('Dyna-Q-Learning Performance Improvement (of last trial)');
elseif doPOMDP == true
    title('Q-Learning for POMDP Performance Improvement (of last trial)');
elseif doSTM == true
    title('Q-Learning for STM Performance Improvement (of last trial)');
else
    title('Q-Learning Performance Improvement (of last trial)');
end
xlabel('Episode Number');
ylabel('Number of Steps');

%plot the average number of steps per episode to see the improvement over
%time
figure;
x=1:size(averageStepsPerEpisode,2);
shadedErrorBar(x,averageStepsPerEpisode,std(rawData),'lineprops','r');
ylim([0 (max(averageStepsPerEpisode))+50]);
if doDynaQ == true
    title(['Mean and Standard Deviation of Dyna-Q-Learning Performance Over ' num2str(numberOfTrials) ' Trials']);
elseif doPOMDP == true
    title(['Mean and Standard Deviation of Q-Learning for POMDP Performance Over ' num2str(numberOfTrials) ' Trials']);
elseif doSTM == true
    title(['Mean and Standard Deviation of Q-Learning for STM Performance Over ' num2str(numberOfTrials) ' Trials']);
else
    title(['Mean and Standard Deviation of Q-Learning Performance Over ' num2str(numberOfTrials) ' Trials']);
end
xlabel('Episode Number');
ylabel('Number of Steps');

pause(0.1)
%============================================================================



%============================================================================
%SECONDARY Q-LEARNING FOR COMPARISION USING TTEST()
if doComparison == true
    
    %select which comparison to do. If all false compare algorithm 1 with
    %normal Q-Learning
    doDynaQ = false;
    doPOMDP = false;
    doSTM = false;

    %matrix to store means and standard deviations for the episodes on
    %episodeTrack
    %first row is means, second row is standard deviation
    episodeStepMeanSTD = zeros(2, size(episodeTrack,2));

    %array to store to total number of steps per episode of every trial. This
    %is used to calculate the average number of steps per episode
    totalStepsPerTrial = zeros(1,numberOfEpisodes);

    %matrix to store all steps for every episode for every trial
    rawData = zeros(numberOfTrials,numberOfEpisodes);

    for i=1:numberOfTrials

        disp('Trial Number');
        disp(i);

        %initialise the Q-Table for each trial. Q-Table is different size
        %depending on which algorithm is implemented
        if doDynaQ == true
            QTable = initQ(0.01,0.1);   
        elseif doPOMDP == true
            QTable = initQPOMDP(0.01,0.1);
        elseif doSTM == true
            QTable = initQSTM(0.01,0.1);
        else    %normal Q-Learning
            QTable = initQ(0.01,0.1);
        end

        %begin a trial of the selected Q-Learning algorithm
        [stepsPerEpisode,finalQTable] = trialTrainer(QTable,numberOfEpisodes);

        %store the number of steps it took per episode 
        totalStepsPerTrial = totalStepsPerTrial + stepsPerEpisode;

        %put the number of steps per episode into the rawData matrix
        rawData(i,:) = stepsPerEpisode;

        %store the mean number of steps for an episode in episodeTrack into the
        %rawData..Alg2 matrix
        rawDataForEpisodeTrackAlg2(i,:) = episodeStepMeanSTD(1,:);

        if (i ~= 1)
            for j=2:i
                %as episodeStepMeanSTD is accumulative, so the means can be
                %calculated, we need to find out the difference in step count
                %between two trials and adjust the matrix accordingly
                rawDataForEpisodeTrackAlg2(i,:) = rawDataForEpisodeTrackAlg2(i,:) - rawDataForEpisodeTrackAlg2(j-1,:);
            end
        end

    end

    %calculate the average number of steps per episode
    averageStepsPerEpisode = totalStepsPerTrial / numberOfTrials;

    %calculate the means and standard deviations for the episodes in
    %episodeTrack
    episodeStepMeanSTD(1,:) = episodeStepMeanSTD(1,:) / numberOfTrials;
    episodeStepMeanSTD(2,:) = std(rawDataForEpisodeTrackAlg2);
          
    %test that the pairwise difference between the two Mean vectors have a mean equal to zero
    p = zeros(1,size(rawDataForEpisodeTrackAlg2,2));
    h = zeros(1,size(rawDataForEpisodeTrackAlg2,2));
    
    %create cell matrix to store H and P from the test algorithms
    hypAndSig = cell(3, size(rawDataForEpisodeTrackAlg2,2) + 1);
    cellRowTitles = {'Episode Number', 'Accept/Reject Null Hypothesis', 'Significance Level'};
    for i=1:3  
        hypAndSig{i,1} = cellRowTitles{i};
    end
    for i=2:size(episodeTrack,2)+1
        hypAndSig{1,i} = episodeTrack(i-1);
    end
    
    %decide which test algorithm to use
    if doTTest == true
        %we want to look at the columns of rawDataForEpisodeTrack as our
        %samples and compare this to the rawDataForEpisodeTrack of the previous
        %algorithm
        for i=1:size(rawDataForEpisodeTrackAlg2,2)
            [h(i), p(i)] = ttest2(rawDataForEpisodeTrackAlg1(:,i), rawDataForEpisodeTrackAlg2(:,i));
        end
    elseif doUTest == true
        for i=1:size(rawDataForEpisodeTrackAlg2,2)
            [p(i), h(i)] = ranksum(rawDataForEpisodeTrackAlg1(:,i), rawDataForEpisodeTrackAlg2(:,i));
        end
    end
    
    %put the results from the test algorithm into the hypothesis and
    %significance cell matrix
    for i=2:size(episodeTrack,2)+1
        hypAndSig{2,i} = h(i-1);
    end
    for i=2:size(episodeTrack,2)+1
        hypAndSig{3,i} = p(i-1);
    end
    
    hypAndSig = hypAndSig';
    
    %plot the average number of steps per episode to see the improvement over
    %time
    figure;
    x=1:size(averageStepsPerEpisode,2);
    shadedErrorBar(x,averageStepsPerEpisode,std(rawData),'lineprops','r');
    ylim([0 (max(averageStepsPerEpisode))+50]);
    if doDynaQ == true
        title(['Mean and Standard Deviation of Dyna-Q-Learning Performance Over ' num2str(numberOfTrials) ' Trials']);
    elseif doPOMDP == true
        title(['Mean and Standard Deviation of Q-Learning for POMDP Performance Over ' num2str(numberOfTrials) ' Trials']);
    elseif doSTM == true
        title(['Mean and Standard Deviation of Q-Learning for STM Performance Over ' num2str(numberOfTrials) ' Trials']);
    else
        title(['Mean and Standard Deviation of Q-Learning Performance Over ' num2str(numberOfTrials) ' Trials']);
    end
    xlabel('Episode Number');
    ylabel('Number of Steps');
    
end
%============================================================================





%============================================================================
%QUARTILE PERFORMANCE PLOT
if doQuarPerf == true
    
    %select which performance plot to do. If all false then plot normal 
    %Q-Learning
    doDynaQ = false;
    doPOMDP = false;
    doSTM = true;

    %matrix to store means and standard deviations for the episodes on
    %episodeTrack
    %first row is means, second row is standard deviation
    episodeStepMeanSTD = zeros(2, size(episodeTrack,2));

    %array to store to total number of steps per episode of every trial. This
    %is used to calculate the average number of steps per episode
    totalStepsPerTrial = zeros(1,numberOfEpisodes);

    %matrix to store all steps for every episode for every trial
    rawData = zeros(numberOfTrials,numberOfEpisodes);

    for i=1:numberOfTrials

        disp('Trial Number');
        disp(i);

        %initialise the Q-Table for each trial. Q-Table is different size
        %depending on which algorithm is implemented
        if doDynaQ == true
            QTable = initQ(0.01,0.1);   
        elseif doPOMDP == true
            QTable = initQPOMDP(0.01,0.1);
        elseif doSTM == true
            QTable = initQSTM(0.01,0.1);
        else    %normal Q-Learning
            QTable = initQ(0.01,0.1);
        end

        %begin a trial of the selected Q-Learning algorithm
        [stepsPerEpisode,finalQTable] = trialTrainer(QTable,numberOfEpisodes);

        %store the number of steps it took per episode 
        totalStepsPerTrial = totalStepsPerTrial + stepsPerEpisode;

        %put the number of steps per episode into the rawData matrix
        rawData(i,:) = stepsPerEpisode;

        %store the mean number of steps for an episode in episodeTrack into the
        %rawData..Alg2 matrix
        rawDataForEpisodeTrackAlg3(i,:) = episodeStepMeanSTD(1,:);

        if (i ~= 1)
            for j=2:i
                %as episodeStepMeanSTD is accumulative, so the means can be
                %calculated, we need to find out the difference in step count
                %between two trials and adjust the matrix accordingly
                rawDataForEpisodeTrackAlg3(i,:) = rawDataForEpisodeTrackAlg3(i,:) - rawDataForEpisodeTrackAlg3(j-1,:);
            end
        end

    end

    %calculate the average number of steps per episode
    averageStepsPerEpisode = totalStepsPerTrial / numberOfTrials;

    %calculate the means and standard deviations for the episodes in
    %episodeTrack
    episodeStepMeanSTD(1,:) = episodeStepMeanSTD(1,:) / numberOfTrials;
    episodeStepMeanSTD(2,:) = std(rawDataForEpisodeTrackAlg3);
    
    %calculate the median steps per episode of all trials
    medianStepsPerEpisode = median(rawData);
    
    %create empty matrix to store the upper and lower quartile performances
    quartilePerformance = zeros(2,size(rawData,2));
    
    for i=1:size(rawData,2)
        %sort data by size
        sortedData = sort(rawData(:,i));
        % compute 25th percentile (first quartile). Row 2 for
        % shadedErrorBar needs to be lower bar
        quartilePerformance(2,i) = median(sortedData(find(sortedData<median(sortedData))));
        % compute 75th percentile (third quartile). Row 1 for
        % shadedErrorBar needs to be upper bar
        quartilePerformance(1,i) = median(sortedData(find(sortedData>median(sortedData))));
    end
    
    %if I plot the quartilePerformance without the following algorithm then
    %it will plot the quartiles above and below the median. e.g median = 5.
    %lower quartile = 2, upper quartile = 6. shadedErrorBar would then plot
    %5+6=11 as the upper quartile, and 5-2=3 as the lower quartile, which is
    %incorrect. We want to actually plot 2 and 6, not 2 below and 6 above
    %the median.
    quartilePerformance(1,:) = quartilePerformance(1,:) - medianStepsPerEpisode;
    quartilePerformance(2,:) = medianStepsPerEpisode - quartilePerformance(2,:);
    
    %plot the median number of steps per episode to see the improvement over
    %time, this time with the shaded bar being the upper and lower quartile
    figure;
    x=1:size(medianStepsPerEpisode,2);
    shadedErrorBar(x,medianStepsPerEpisode,quartilePerformance,'lineprops','r');
    ylim([0 max(medianStepsPerEpisode)+50]);
    if doDynaQ == true
        title(['Median and Quartile Performance of Dyna-Q-Learning Performance Over ' num2str(numberOfTrials) ' Trials']);
    elseif doPOMDP == true
        title(['Median and Quartile Performance of Q-Learning for POMDP Performance Over ' num2str(numberOfTrials) ' Trials']);
    elseif doSTM == true
        title(['Median and Quartile Performance of Q-Learning for STM Performance Over ' num2str(numberOfTrials) ' Trials']);
    else
        title(['Median and Quartile Performance of Q-Learning Performance Over ' num2str(numberOfTrials) ' Trials']);
    end
    xlabel('Episode Number');
    ylabel('Number of Steps');
    
end
%============================================================================
