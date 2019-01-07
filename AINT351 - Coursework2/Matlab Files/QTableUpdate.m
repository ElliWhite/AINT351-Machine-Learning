function [ QTable ] = QTableUpdate( QTable, state_idx, action_idx, next_state_idx, next_reward )
    
    global temporalDiscountRate;
    global learningRate;
    
    QTable(state_idx,action_idx) = QTable(state_idx,action_idx) + learningRate * (next_reward + temporalDiscountRate* max(QTable(next_state_idx,:)) - QTable(state_idx,action_idx));


end