function [ TCount, TProbability ] = tUpdate( TCount, TProbability, state_idx, action_idx, next_state_idx )

    % T matrix is the probablity that we go to next state based on input state
    % and action

    % initialise Tcount[] = 0.000001
    % Tcount[] is a 3d matrix
    % observe s,a,s'
    % increment T[s,a,s'] by adding one

    %increment by one in the position of [s,a,s']
    TCount(state_idx, action_idx, next_state_idx) = TCount(state_idx, action_idx, next_state_idx) + 1;

    %create second table of probabilities based on TCount.
    %i.e probability of going to next state given action and state
    %add up values of next_state_idx given current state and action
    %divide current value in TCount by previous addition
    stepsSum = sum(TCount(state_idx, action_idx, :));

    TProbability(state_idx, action_idx, next_state_idx) = TCount(state_idx, action_idx, next_state_idx) / stepsSum;

end

