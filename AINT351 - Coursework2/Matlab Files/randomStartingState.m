function [ startingState ] = randomStartingState( x )

    %return random starting state
    startingState = randsample(x,1);
    
end