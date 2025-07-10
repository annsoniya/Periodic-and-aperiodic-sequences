function [nofopairs, avg_noise_corr, ncbin, ci_lower, ci_upper] = plot_bootstrapped(bin_width, distance_all, noise_corr_all)

% Calculate the maximum distance across all ROIs to define the bins
%   max_distance = max(cell2mat(cellfun(@(x) max(x(:)), distance_all, 'UniformOutput', false)));
% Define the bins
max_distance=200;
bins = 1:bin_width:max_distance;
% Initialize arrays to store the average noise correlation and SEM for each bin
avg_noise_corr = zeros(size(bins));
sem_noise_corr = zeros(size(bins));
ci_lower = zeros(size(bins));
ci_upper = zeros(size(bins));
num_bootstrap_samples = 1000; % Number of bootstrap samples
confidence_level = 0.95; % Confidence level for the intervals

% Loop over each bin
for i = 1:length(bins)-1
    % Initialize arrays to store the noise correlations for this bin for all ROIs
    noise_corr_bin = [];

    % Loop over each ROI
    for roino = 1:size(noise_corr_all, 1)
        % Get the noise correlations and distances for this ROI
        noise_corr = noise_corr_all{roino};
        distance = distance_all{roino};

        % Find the noise correlations for distances within this bin
        noise_corr_bin_roi = noise_corr(distance >= bins(i) & distance < bins(i+1));

        % Append the noise correlations for this ROI to the array for this bin
        noise_corr_bin = [noise_corr_bin; noise_corr_bin_roi(:)];
    end
    ncbin{1, i} = noise_corr_bin;

    % Calculate the average noise correlation for this bin
    avg_noise_corr(i) = nanmean(noise_corr_bin);
    % Calculate the number of pairs for this bin
    nofopairs(i) = size(noise_corr_bin, 1);

    % Calculate the SEM for this bin
    sem_noise_corr(i) = nanstd(noise_corr_bin) / sqrt(sum(~isnan(noise_corr_bin)));

    % Bootstrap the noise correlation values
    bootstrap_samples = zeros(num_bootstrap_samples, 1);
    for b = 1:num_bootstrap_samples
        sample_indices = randi(length(noise_corr_bin), length(noise_corr_bin), 1);
        bootstrap_samples(b) = nanmean(noise_corr_bin(sample_indices));
    end

    % Calculate the confidence intervals
    ci_lower(i) = prctile(bootstrap_samples, (1 - confidence_level) / 2 * 100);
    ci_upper(i) = prctile(bootstrap_samples, (1 + confidence_level) / 2 * 100);
end

bin_centers = (bins(1:end-1) + bins(2:end)) / 2;

% Plot the average noise correlation against distance with confidence intervals
% figure;
hold on;
errorbar(bin_centers, avg_noise_corr(1:end-1), avg_noise_corr(1:end-1) - ci_lower(1:end-1), ci_upper(1:end-1) - avg_noise_corr(1:end-1), 'o-');
xlabel('Distance (micrometers)');
ylabel('Average noise correlation');
title('Average noise correlation vs. distance');
%hold off;
end