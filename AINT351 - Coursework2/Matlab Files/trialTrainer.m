function [ stepsPerEpisode, finalQTable ] = trialTrainer( QTable, numberOfEpisodes )

    global episodeTrack;
    global episodeStepMeanSTD;
    
    y = 1;
    
    %create empty array to store the number of steps per episode
    stepsPerEpisode = zeros(1,numberOfEpisodes);
 
    %execute Q-Learning algorithm. This is done outside the later for-loop
    %so the original QTable is not altered. This is done for visualy
    %comparing the intitial and final Q-Table later
    [stepCounter,finalQTable] = doQLearning(QTable);
    
    %store number of steps of current episode
    stepsPerEpisode(1) = stepCounter;
    
    %store number of steps into the means and standard deviation matrix
    episodeStepMeanSTD(1,y) = episodeStepMeanSTD(1,y) + stepCounter;
    
    y = y + 1;
    
    for x = 2:numberOfEpisodes

        %execute Q-Learning algorithm
        [stepCounter,finalQTable] = doQLearning(finalQTable);
    
        %store number of steps of current episode
        stepsPerEpisode(x) = stepCounter;
        
        %check if the episode number is a member of episodeTrack. If it is
        %then store the number of steps for that episode
        if (ismember(x, episodeTrack))
            episodeStepMeanSTD(1,y) = episodeStepMeanSTD(1,y) + stepCounter;
            y = y + 1;
        end
   
    end

end