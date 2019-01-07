function [ QTable ] = QTableUpdateSTM( QTable, SubsequentObservation_idx, nextSubsequentObservation_idx, action_idx, next_reward )
    
    global temporalDiscountRate;
    global learningRate;
        
    QTable(SubsequentObservation_idx,action_idx) = QTable(SubsequentObservation_idx,action_idx) + learningRate * (next_reward + temporalDiscountRate* max(QTable(nextSubsequentObservation_idx,:)) - QTable(SubsequentObservation_idx,action_idx));


end