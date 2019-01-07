function [ SubsequentObservationIdx ] = findSubsequentObservationIdx( current_observation, previous_observation )

    %find the subsequent observation index based on the current and previous
    %observation
    X = [current_observation previous_observation];

    %all posibilities of the current and previous observations
    SubsequentObservations =  [ 14  14;
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

    %find row index of X      
    [~,SubsequentObservationIdx] = ismember(X,SubsequentObservations,'rows');

end

