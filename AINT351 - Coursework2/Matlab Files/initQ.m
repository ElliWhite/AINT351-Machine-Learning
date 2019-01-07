function initQTable = initQ( min, max )

    %initialise 11x4 Q-Table
    initQTable = (max - min).*rand(11,4) + min;
    
end