function [ inputDataSet, outputTargetData ] = DummyDataForSLNRecog(plotOrNot)
%FUNCTION TO CREATE TEST DATA AND TARGET DATA FOR A SLN RECOGNISER
% Student Number:   10467243
% Module:           AINT351
% Date:             18/11/2017

    inputDataX = GenerateUniformData('noplot',1);   %generate uniform X data values
    inputDataY = GenerateUniformData('noplot',1);   %generate unfiorm Y data values

    inputDataX = inputDataX';   %transpose X data
    inputDataY = inputDataY';   %transpose Y data

    inputDataSet = [inputDataX,  inputDataY];   %concatenate data arrays into 2D data matrix


    %generate target vectors based on y = mx + c
    m = 2;          %gradient of the target boundary
    c = -3;         %offset of the target boundary 
    %generate logical vector indicating which point belongs to which class
    outputTargetData = inputDataY > inputDataX.*m+c;    %target class


    decisionBoundary = inputDataX.*m + c;   %decision boundary is defined by y=mx+c

    %decide whether to plot the graph based on plotOrNot input.
    if strcmp(plotOrNot, 'plot')
        %new figure
        figure;
        hold on;  
        plot(inputDataX,decisionBoundary, 'k', 'LineWidth',3); %plot decision boundary against X data
        plot(inputDataSet(:,1), inputDataSet(:,2),'or'); %plot Input Data
        axis([-10 10 -10 10]);       
        xlabel('x-value');           
        ylabel('y-value');            
        title('Input Test Data for Single Layer Network');     
        legend('Decision Boundary','Input Test Data');    
     elseif strcmp(plotOrNot, 'noplot')
        disp('Not plotting test data')
    end

end

