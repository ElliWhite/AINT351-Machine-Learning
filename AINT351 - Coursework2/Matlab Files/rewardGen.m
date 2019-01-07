function [ reward ] = rewardGen( state, action )

    %return reward
    if (state == 5) && (action == 3)
        reward = 10;
    else
        reward = 0;
    end
    
end
