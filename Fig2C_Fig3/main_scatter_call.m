function main_scatter_call()

% Call scatterplot function for all datasets in a single plot
close all;
figure;
hold on;
m = max([max(x1), max(y1), max(x2), max(y2), max(x3), max(y3), max(x4), max(y4)]);
mmin = min([min(x1), min(y1), min(x2), min(y2), min(x3), min(y3), min(x4), min(y4)]);
xlim([mmin m]);
ylim([mmin m]);

% Plot the identity line at 45 degrees
plot([mmin, m], [mmin, m], '-k', 'LineWidth', 2);
axis image;

scatterplot(x1, y1, 'g', 'o'); %PS with
scatterplot(x2, y2, 'r', 'o'); %AS with

scatterplot(x3, y3, 'g', '+');%PS withotu
scatterplot(x4, y4, 'r', '+');%AS without

scatterplot(cx1,cy1,'b','o');%PS common
scatterplot(cx2,cy2,'k','o');% AS common

%% to find teh generalisated units and save those indices
% Generate histograms
figure;
num_bins = 10; % Specify the number of bins
subplot(4, 2, 1);
histogram(x1, 'NumBins', num_bins);
title('PS- periodic-with');
xlim([mmin m]);
ylim([mmin m]);

subplot(4, 2, 2);
histogram(y1, 'NumBins', num_bins);
title('PS- aperiodic-with');
xlim([mmin m]);
ylim([mmin m]);
subplot(4, 2, 3);
histogram(x3, 'NumBins', num_bins);
title('PS- periodic-without');
xlim([mmin m]);
ylim([mmin m]);
subplot(4, 2, 4);
histogram(y3, 'NumBins', num_bins);
title('PS- aperiodic-without');
xlim([mmin m]);
ylim([mmin m]);

subplot(4, 2, 5);
histogram(x2, 'NumBins', num_bins);
title('AS- periodic-with');
xlim([mmin m]);
ylim([mmin m]);

subplot(4, 2, 6);
histogram(y2, 'NumBins', num_bins);
title('AS- aperiodic-with');
xlim([mmin m]);
ylim([mmin m]);
subplot(4, 2, 7);
histogram(x4, 'NumBins', num_bins);
title('AS- periodic-without');
xlim([mmin m]);
ylim([mmin m]);
subplot(4, 2, 8);
histogram(y4, 'NumBins', num_bins);
title('AS- aperiodic-without');
xlim([mmin m]);
ylim([mmin m]);

sgtitle('p32f2f1-hist')
%% hiostograms combined

end