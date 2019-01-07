function [ observation_idx ] = findObservationIdx( state_idx )

    %determine the observation index based on the state index
    if (1 <= state_idx)  && (state_idx <= 3)
        observation_idx = 1;
    elseif (4 <= state_idx)  && (state_idx <= 6)
        observation_idx = 2;
    elseif state_idx == 7
        observation_idx = 3;
    elseif state_idx == 8 || state_idx == 10
        observation_idx = 4;
    elseif state_idx == 9
        observation_idx = 5;
    elseif state_idx == 11
        observation_idx = 6;
    end
    
end

