function [ next_observation, reward ] = nextObservation( inputObservation, inputState, inputAction )

    %calculate the next observation and reward depending on the given state and
    %action

    %needs to be assigned so if the state doesn't change then we sit in that state
    next_observation = inputObservation; 

    switch inputObservation

        case 1
            if (inputAction == 2) || (inputAction == 4)
                next_observation = inputObservation + 4;
            elseif inputAction == 3
                next_observation = inputObservation + 9;
            end        
        case 3
            if inputAction == 3
                next_observation = inputObservation + 7;
            elseif inputAction == 4
                next_observation = inputObservation + 2;
            end
        case 5
            if inputState == 8
                if inputAction == 2
                    next_observation = inputObservation - 4;
                elseif inputAction == 4
                    next_observation = inputObservation + 4;
                end
            elseif inputState == 10
                if inputAction == 2
                    next_observation = inputObservation - 2;
                elseif inputAction == 4
                    next_observation = inputObservation - 4;
                end
            end  
        case 9
            if inputAction == 2
                next_observation = inputObservation - 4;
            elseif inputAction == 3
                next_observation = inputObservation + 1;
            end
        case 10
            if inputAction == 3
                next_observation = inputObservation + 4;
            elseif inputAction == 1
                if inputState == 4
                   next_observation = inputObservation - 1;
                elseif inputState == 5
                   next_observation = inputObservation - 9;
                elseif inputState == 6
                   next_observation = inputObservation - 7;
                end
            end  
        case 14
            if inputAction == 1
                next_observation = inputObservation - 4;
            end

    end  

    %Create a reward function that takes a state and an action and returns
    %10 if the state is 5 and the action is 3. In all other cases it should
    %return 0 >>
    if (inputObservation == 10) && (inputAction == 3) && (inputState == 5)
            reward = 10;
        else
            reward = 0;
    end


    
end