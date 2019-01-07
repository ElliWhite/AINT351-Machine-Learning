function [ current_action ] = eGreedySelection( QTable, state_idx, action )

    global explorationRate;
    
    %create random number between 0-1
    r = rand;
    
    %if r is more than exploration rate, take action based on largest
    %Q-Value of the given state
    if r>=explorationRate
        %exploitation
        [~,umax]=max(QTable(state_idx,:));
        current_action = action(umax);
    else %take random action
        %exploration
        current_action=datasample(action,1);
    end
   
end