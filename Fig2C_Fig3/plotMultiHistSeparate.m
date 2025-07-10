function plotMultiHistSeparate(x1, x2, x3, x4, numBins)
% Function to plot histograms for four variables in one figure
% Input:
%   x1, x2, x3, x4: vectors containing data for four different variables
%   numBins: number of bins for the histogram

% Concatenate all the data to determine bin edges
%%
numBins=10;
allData = [x1; y1];
binEdges = linspace(min(allData), max(allData), numBins+1);
binCenters = binEdges(1:end-1) + diff(binEdges)/2;

% Compute histograms for each variable
histX1 = histcounts(x1, binEdges);
histX2 = histcounts(y1, binEdges);
barWidth = 0.2;
% Plot histograms as non-overlapping bars
figure;
hold on;
bar(binCenters - 2 * barWidth, histX1, barWidth, 'FaceColor', 'r', 'EdgeColor', 'none'); % Red for x1
bar(binCenters - 0.5 * barWidth, histX2, barWidth, 'FaceColor', 'g', 'EdgeColor', 'none'); % Green for x2
xlabel('Bins');
ylabel('Counts');
legend({'x1', 'x2', 'x3', 'x4'});
hold off;
end
