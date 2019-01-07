function [ next_state, reward ] = nextState( inputState, inputAction )

    %calculate the next observation and reward depending on the given state and
    %action

    %needs to be assigned so if the state doesn't change then we sit in that state
    next_state = inputState;   

    switch inputState

        case {1,2,3}
            if inputAction == 1
                next_state = inputState + 3;
            end        
        case 4
            if inputAction == 1
                next_state = inputState + 3;
            elseif inputAction == 3
                next_state = inputState - 3;
            end
        case 5
            if inputAction == 1
                next_state = inputState + 4;
            elseif inputAction == 3
                next_state = inputState - 3;
            end
        case 6
            if inputAction == 1
                next_state = inputState + 5;
            elseif inputAction == 3
                next_state = inputState - 3;
            end
        case 7
            if inputAction == 2
                next_state = inputState + 1;
            elseif inputAction == 3
                next_state = inputState - 3;
            end
        case {8,10}
            if inputAction == 2
                next_state = inputState + 1;
            elseif inputAction == 4
                next_state = inputState - 1;
            end
        case 9
            if inputAction == 2
                next_state = inputState + 1;
            elseif inputAction == 3
                next_state = inputState - 4;
            elseif inputAction == 4
                next_state = inputState - 1;
            end
        case 11
            if inputAction == 3
                next_state = inputState - 5;
            elseif inputAction == 4
                next_state = inputState - 1;
            end

    end  

    %Create a reward function that takes a state and an action and returns
    %10 if the state is 5 and the action is 3. In all other cases it should
    %return 0 >>
    if (inputState == 5) && (inputAction == 3)
            reward = 10;
        else
            reward = 0;
    end

    %When the following code is uncommented, it creates a new figure with a
    %dot moving around the McCallum's grid world.
    
    %{
    points = [0,0;2,0;4,0;0,1;2,1;4,1;0,2;1,2;2,2;3,2;4,2];
    minX = min(points(:,1)) - 0.5;
    maxX = max(points(:,1)) + 0.5;
    minY = min(points(:,2)) - 0.5;
    maxY = max(points(:,2)) + 0.5;

    plot(points(inputState,1), points(inputState, 2), 'b*', ...
    'MarkerSize', 10, 'LineWidth', 3);
    grid on;
    xlim([minX, maxX]);
    ylim([minY, maxY]);
    pause(0.00001);
    %}

    
end