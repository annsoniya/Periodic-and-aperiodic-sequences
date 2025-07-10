function plotMultiHistSeparate(x1,y1,x3,y3,binEdges,binCenters)
% Function to plot histograms for four variables in one figure
% Input:
%   x1, x2, x3, x4: vectors containing data for four different variables
%   numBins: number of bins for the histogram

histX1 = hist(x1, binCenters);
histX2 = hist(y1, binCenters);
histX3= hist(x3,binCenters);
histX4=hist(y3,binCenters);
histMatrix = [histX1; histX2;histX3;histX4]';

% Set colors for each group
b = bar(binCenters, histMatrix, 'grouped');
b(1).FaceColor = 'g'; % Red for x1
b(2).FaceColor = 'r'; % Green for y1
% give a texture to the box with same coulour as abov e
b(3).FaceColor = 'none';
b(3).EdgeColor = 'g';
% Blue for x3
b(4).FaceColor = 'none'; % Black for y3
b(4).EdgeColor = 'r';
% Set axes labels and legend
xlabel('Bins');
ylabel('Counts');
xticks(round(binCenters, 1));
title('Grouped Histogram for x1 and y1');
legend({'x1', 'x2', 'x3', 'x4'});
end


