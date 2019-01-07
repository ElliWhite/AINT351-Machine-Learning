function [ initQTable ] = initQSTM( min, max )

    %{
    Q Table possible combinations:
    All states will have themselves as a previous observation, this starts us
    off with 12 combinations. All states connected to two other states each
    have two previous states, so there are 2x (states with two connected
    states).
    State with the '1' observation with also only have 2 previous state
    observations due to '5' being two of the three possibilities.

    QTable will have 1 row per possible subsequent observations.

    QTable =  SubsequentObservations =  [ 14  14;
                                          10  10;
                                          9   9;
                                          5   5;
                                          3   3;
                                          1   1;
                                          14  10;
                                          10  14;
                                          10  9;
                                          10  1;
                                          10  3;
                                          9   10;
                                          9   5;
                                          5   9;
                                          5   1;
                                          5   3;
                                          3   10;
                                          3   5;
                                          1   10;
                                          1   5
                                        ];

    %}

    %initialise 20x4 Q-Table
    initQTable = (max - min).*rand(20,4) + min;
end