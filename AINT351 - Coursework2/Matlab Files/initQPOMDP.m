function initQTable = initQPOMDP( min, max )

    %initialise 6x4 Q-Table
    initQTable = (max - min).*rand(6,4) + min;
    
end