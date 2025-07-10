function main_scatter_call()
% Call scatterplot function for all datasets in a single plot
close all;
figure;
hold on;
% Calculate the maximum value from the datasets, excluding Inf values
mmax = max([max(x1(~isinf(x1))), max(y1(~isinf(y1))), max(x2(~isinf(x2))), max(y2(~isinf(y2))), max(x3(~isinf(x3))), max(y3(~isinf(y3))), max(x4(~isinf(x4))), max(y4(~isinf(y4)))]);

% Calculate the minimum value from the datasets, excluding Inf values
mmin = min([min(x1(~isinf(x1))), min(y1(~isinf(y1))), min(x2(~isinf(x2))), min(y2(~isinf(y2))), min(x3(~isinf(x3))), min(y3(~isinf(y3))), min(x4(~isinf(x4))), min(y4(~isinf(y4)))]);

% Now you can use m and mmin for setting the axis limits
xlim([mmin mmax]);
ylim([mmin mmax]);

% Plot the identity line at 45 degrees
plot([mmin, mmax], [mmin, mmax], '-k', 'LineWidth', 2);
axis image;

scatterplot(x1, y1, 'g', 'o'); %PS with
scatterplot(x2, y2, 'r', 'o'); %AS with

scatterplot(x3, y3, 'g', '+');%PS withotu
scatterplot(x4, y4, 'r', '+');%AS without

scatterplot(cx1,cy1,'b','o');%PS common
scatterplot(cx2,cy2,'k','o');% AS common
% Generate histograms
figure;
hold on;
% Calculate the maximum value from the datasets, excluding Inf values
%mmax = max([max(x1(~isinf(x1))), max(y1(~isinf(y1))), max(x2(~isinf(x2))), max(y2(~isinf(y2))), max(x3(~isinf(x3))), max(y3(~isinf(y3))), max(x4(~isinf(x4))), max(y4(~isinf(y4)))]);

% Calculate the minimum value from the datasets, excluding Inf values
%mmin = min([min(x1(~isinf(x1))), min(y1(~isinf(y1))), min(x2(~isinf(x2))), min(y2(~isinf(y2))), min(x3(~isinf(x3))), min(y3(~isinf(y3))), min(x4(~isinf(x4))), min(y4(~isinf(y4)))]);

% Now you can use m and mmin for setting the axis limits
%xlim([0 5]);
%ylim([mmin mmax]);
mmin=0.1;
mmax=4.2;
numBins = 10; % Specify the number of bins
binEdges = linspace(mmin, mmax, numBins+1);
binCenters = binEdges(1:end-1) + diff(binEdges)/2;
plotMultiHistSeparate(x1,y1,x3,y3,binEdges,binCenters);
title('Ps');
figure;
plotMultiHistSeparate(x2, y2,x4,y4,binEdges,binCenters);
title('As');
end