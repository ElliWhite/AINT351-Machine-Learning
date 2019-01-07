function [ observation ] = findObservation( state_idx )

    observations = [14,14,14,10,10,10,9,5,1,5,3];

    %find current observation based on the state index
    observation = observations(state_idx);

end

