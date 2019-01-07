function [ rewardMeans, rewardCounts ] = rUpdate( rewardCounts, rewardMeans, state_idx, action_idx, next_reward )

    if next_reward ~= 0
        
        %add 1 to rewardCounts in corresponding location
        rewardCounts(state_idx, action_idx) = rewardCounts(state_idx, action_idx) + 1;
        
        %calculate the average reward of given state and action
        rewardMeans(state_idx, action_idx) = next_reward / rewardCounts(state_idx, action_idx);

    end

end

