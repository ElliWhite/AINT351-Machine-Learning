function [ QTable ] = QTableUpdatePOMDP( QTable, observation_idx, action_idx, next_observation_idx, next_reward )
    
    global temporalDiscountRate;
    global learningRate;
    
    QTable(observation_idx,action_idx) = QTable(observation_idx,action_idx) + learningRate * (next_reward + temporalDiscountRate* max(QTable(next_observation_idx,:)) - QTable(observation_idx,action_idx));


end