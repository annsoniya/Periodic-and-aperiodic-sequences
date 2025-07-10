clear all;
clc
data=load('sig_data_img_old.mat');
data=table2cell(data.sig_data_img_old);
periodic_stimset_4=[1,2,9,10];
aperiodic_stimset_4=[11,12];
periodic_stimset_3=[3,4,5,6,7,8];
aperiodic_stimset_3=[13,14,15,16];
per_set=[1,2,3,4,5,6,7,8,9,10];
aper_set=[11,12,13,14,15,16];
%seperate data
data_per_3=data(:,periodic_stimset_3);
data_per_4=data(:,periodic_stimset_4);
data_aper_3=data(:,aperiodic_stimset_3);
data_aper_4=data(:,aperiodic_stimset_4);

% function to plot psth one by one

figHandle = figure;

for u = 1:length(data)
    % Initialize variables to store min and max y-values for the current unit
    unitMin = inf;
    unitMax = -inf;

    % First pass: Calculate min and max y-values for the current unit
    for stim = 1:16
        x = mean(cell2mat(data(u, stim)));
        xx = x(:, 4:33); % Assuming xx is 1x40
        yy = gaussmoth(xx, 0.7); % Apply your smoothing function

        % Update unit min and max
        unitMin = min(unitMin, min(yy));
        unitMax = max(unitMax, max(yy));
    end

    % Second pass: Plot with unit-specific y-limits
    clf(figHandle)
    for stim = 1:16
        subplot(4, 4, stim);
        x = cell2mat(data(u, stim));

        xx = x(:, 4:33); % Assuming xx is 1x40

        % Create shaded area for stimulus with unit-specific height
        fill([6 6 24 24], [unitMin unitMax unitMax unitMin], [0.8 0.8 0.8], 'EdgeColor', 'k', 'FaceAlpha', 0.5);
        hold on;

        % Plot the data over the shaded area
        yy = gaussmoth(xx, 0.7); % Apply your smoothing function
        %  plot(yy, 'k', 'LineWidth', 1, 'LineStyle', '-');
        plot(1:length(yy),yy);

        % Set unit-specific y-limits
        ylim([unitMin-.2 unitMax+.2]);
        xticks(1:5:33);

        % Title for each subplot
        title(['cell number ' num2str(u) ' stimulus number ' num2str(stim)]);
    end

    pause(); % Pause to view each figure before continuing
end