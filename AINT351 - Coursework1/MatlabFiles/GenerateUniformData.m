function [ uniformData ] = GenerateUniformData(plotOrNot, dimension)
%FUNCTION TO GENERATE A UNIFORM DATASET
% Student Number:   107467243
% Module:           AINT351
% Date:             18/11/2017

    samples = 1000;             %number of data samples to use

    %create range
    lowerInterval = -10;        
    upperInterval = 10;

    %create uniform dataset within the specified range
    uniformData = (upperInterval - lowerInterval).*rand(dimension,samples) + lowerInterval;    

    %decide whether to plot the graph based on plotOrNot input.
    %plots are different based on the dimension given. Limited to one or two
    %dimensions.
    if strcmp(plotOrNot, 'plot')
        if dimension == 1
            % new figure
            figure;
            hold on;
            %plot uniformData
            plot(uniformData, 'o', 'MarkerFaceColor', 'b', 'MarkerSize', 4);
            xlabel('x-value');
            ylabel('y-value');
            title('Uniform Testing Data');
        elseif dimension == 2
            % new figure
            figure;
            hold on;
            %plot first row of uniformData against second row
            plot(uniformData(1,:), uniformData(2,:), 'o', 'MarkerFaceColor', 'b', 'MarkerSize', 4);
            xlabel('x-value');
            ylabel('y-value');
            title('Uniform Testing Data');
        else
            % dimension variable is out of range
            disp('ERROR - Dimension is not 1 or 2');
        end
    elseif strcmp(plotOrNot, 'noplot')
        disp('Not plotting uniform data')
    end


end

