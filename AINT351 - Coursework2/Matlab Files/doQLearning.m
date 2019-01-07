function [ numberOfSteps, finalQTable ] = doQLearning( QTable )

    global doDynaQ;
    global doPOMDP;
    global goalState;
    global doSTM;
    
    %array of states
    state = [1,2,3,4,5,6,7,8,9,10,11];
   
    %array of actions
    action = [1,2,3,4];
    
    %number of steps taken to reach goal
    stepCounter = 0;        
    
    %find a random starting state and its associated index
    startingState = randomStartingState(state);
    state_idx = find(state==startingState);
    
    if doPOMDP == true || doSTM ==true
        %find observation index for POMDPs
        observation_idx = findObservationIdx(state_idx);

        %find observation give the state index
        observation = findObservation(state_idx);
        %initial previous obersavation is same as current observation
        previous_observation = findObservation(state_idx);
        %find index of the combination of the previous and current observation
        currentSubsequentObservationIdx = findSubsequentObservationIdx(observation,previous_observation);
    end
    
    if doDynaQ == true
        %create empty matrices for Dyna-Q algorithm
        TCount = zeros(11, 4, 11);
        TProbability = zeros(11, 4, 11);
        rewardMeans = zeros(11, 4);
        rewardCounts = zeros(11, 4);

        %loops for Dyna-Q modelling
        modelLoopCount = 10;
    end

    while state_idx ~= goalState
    
        if doPOMDP == true
            current_action = eGreedySelection(QTable,observation_idx,action);
        elseif doSTM == true
            current_action = eGreedySelection(QTable,currentSubsequentObservationIdx,action);
        else
            current_action = eGreedySelection(QTable,state_idx,action);
        end
        
        %index of the chosen action
        action_idx = find(action==current_action);

        %determine next state and reward
        [next_state, next_reward] =  nextState(state(state_idx),action(action_idx));

        %index of next state
        next_state_idx = find(state==next_state);
        
        if doDynaQ == true
            
            %update transfer function
            [TCount, TProbability] = tUpdate(TCount, TProbability, state_idx, action_idx, next_state_idx);

            %update reward function
            [rewardMeans, rewardCounts] = rUpdate( rewardCounts, rewardMeans, state_idx, action_idx, next_reward );

            for i=0:modelLoopCount
                
                % take random previously observed state and action previously
                % taken in s
                [state_find,~,~] = ind2sub( size(TCount),find(TCount > 0) );

                %generate a random state based on previously observed
                %states
                random_state = datasample(state_find,1);

                TCount_row_extracted = squeeze(TCount(random_state,:,:));
                
                %rows now are the actions, columns are the next states
                [action_find, next_state_find] = ind2sub( size(TCount_row_extracted),find(TCount_row_extracted > 0) );
                
                %take random previously observed action in s
                random_action = datasample(action_find,1);

                random_action_idx = find(random_action == action_find);

                %generate next state given random action
                next_state = next_state_find(random_action_idx);
                
                %update transfer function based on randomly previously
                %observed state and action
                [TCount, TProbability] = tUpdate( TCount, TProbability, random_state, random_action, next_state );

                %generate reward
                next_reward = rewardGen( random_state, random_action );

                %update reward function
                [rewardMeans, rewardCounts] = rUpdate( rewardCounts, rewardMeans, random_state, random_action, next_reward );

                %update Q-Table
                QTable = QTableUpdate( QTable,  random_state, random_action, next_state, next_reward );

            end
                   
        
        elseif doPOMDP == true
        
            %find current observation and its associated index
            observation = findObservation(state_idx);
            observation_idx = findObservationIdx(state_idx);
            
            %determine the next observation and its associated index
            [~, next_reward] = nextObservation(observation,state(state_idx),action(action_idx));
            next_observation_idx = findObservationIdx(next_state_idx);
            
            %update Q-Table accordingly
            QTable = QTableUpdatePOMDP(QTable, observation_idx, action_idx, next_observation_idx, next_reward);
            
        
        elseif doSTM == true 
            
            %find current observation
            observation = findObservation(state_idx);
           
            %calculate the next observation and reward based on current
            %observation, state and action
            [next_observation, next_reward] = nextObservation(observation,state(state_idx),action(action_idx));
           
            %find the index of the current subsequent observations and next
            %subsequent observations
            currentSubsequentObservationIdx = findSubsequentObservationIdx(observation,previous_observation);
            nextSubsequentObservationIdx = findSubsequentObservationIdx(next_observation,observation);
            
            %update Q-Table accordinly
            QTable = QTableUpdateSTM(QTable, currentSubsequentObservationIdx, nextSubsequentObservationIdx, action_idx, next_reward);
            
            %remember previous observation
            previous_observation = findObservation(state_idx);
            
            
        else
            
            %update Q-Table for regular Q-Learning
            QTable = QTableUpdate(QTable, state_idx, action_idx, next_state_idx, next_reward);
            
        end
        
        %new current state is assigned calculated next state
        state_idx = next_state_idx;
        
        %new current observation based on the new state
        observation_idx = findObservationIdx(state_idx);

        %increase step counter
        stepCounter = stepCounter + 1;
        
      
    end
    
    %return final Q-Table 
    finalQTable = QTable;
   
    %return total number of steps for episode
    numberOfSteps = stepCounter;

end