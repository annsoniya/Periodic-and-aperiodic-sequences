

function main2_spatial(PS_inx,AS_inx)
% Assuming 'roi' is a cell array where each cell contains the indices of all neurons in each ROI
% Initialize cell arrays to store the indices for each category in each ROI
PS_indices_roi = cell(size(roi));
AS_indices_roi = cell(size(roi));
non_PS_AS_indices_roi = cell(size(roi));


for i = 1:length(roi)
    % Get the indices for this ROI
    roi_indices = roi{i};

    % Find the indices for each category
    PS_indices_roi{i} = intersect(roi_indices, PS_inx);
    AS_indices_roi{i} = intersect(roi_indices, AS_inx);

    % Find the indices for neurons that do not fall into any of the above categories
    non_PS_AS_indices_roi{i} = setdiff(roi_indices, union(PS_inx, AS_inx));
end

%% %%%%%%%%%%%%%%%%%%%%%%%%% bootstrapped version %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_bootstrap_samples = 500;
% Initialize arrays to store bootstrap samples
bootstrap_prob_periodic = zeros(num_bootstrap_samples, num_bins);
bootstrap_prob_aperiodic = zeros(num_bootstrap_samples, num_bins);
bootstrap_prob_nonselective = zeros(num_bootstrap_samples, num_bins);

% Generate bootstrap samples
for b = 1:num_bootstrap_samples
    % Resample ROIs with replacement
    resampled_rois = randi(num_rois, [1, num_rois]);

    % Initialize counts for this bootstrap sample
    counts_periodic = zeros(1, num_bins);
    counts_aperiodic = zeros(1, num_bins);
    counts_nonselective = zeros(1, num_bins);
    counts_total = zeros(1, num_bins);

    % Process each resampled ROI
    for roino = resampled_rois
        % Get the ROI
        roi_neurons = roi{roino}; % indices of cells in that ROI
        num_neurons_in_this_roi = size(roi_neurons, 1);
        %%%%%%%%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % input - the index you want to try
        N = non_PS_AS_indices_roi{roino}; % PS_indices_roi, AS_indices_roi,non_PS_AS_indices_roi
        %%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%
        % Compute pairwise distances between neurons
        for neuron_idx = 1:length(N)
            % Get distances to all other neurons
            x = N(neuron_idx);
            distances = D(x, :); % 1xN vector of distances
            distances(x) = []; % Remove self-distance (distance to itself)
            neighbor_categories = categories;
            neighbor_categories(x) = []; % Remove self-category

            % For each distance bin
            for bin_idx = 1:num_bins
                % Define the start and end of the bin
                bin_start = bin_edges(bin_idx);
                bin_end = bin_edges(bin_idx + 1);


                in_bin = distances > bin_start & distances <= bin_end;

                categories_in_bin = neighbor_categories(in_bin);

                num_in_bin = sum(in_bin);
                % Count number of neurons of each type in this bin
                num_periodic = sum(strcmp(categories_in_bin, 'periodic'));
                num_aperiodic = sum(strcmp(categories_in_bin, 'aperiodic'));
                num_nonselective = sum(strcmp(categories_in_bin, 'nonselective'));

                counts_periodic(bin_idx) = counts_periodic(bin_idx) + num_periodic;
                counts_aperiodic(bin_idx) = counts_aperiodic(bin_idx) + num_aperiodic;
                counts_nonselective(bin_idx) = counts_nonselective(bin_idx) + num_nonselective;
                counts_total(bin_idx) = counts_periodic(bin_idx) + counts_aperiodic(bin_idx) + counts_nonselective(bin_idx);
            end
        end
    end

    prob_periodic = counts_periodic ./ counts_total;
    prob_aperiodic = counts_aperiodic ./ counts_total;
    prob_nonselective = counts_nonselective ./ counts_total;

    prob_periodic(counts_total == 0) = NaN;
    prob_aperiodic(counts_total == 0) = NaN;
    prob_nonselective(counts_total == 0) = NaN;

    bootstrap_prob_periodic(b, :) = prob_periodic;
    bootstrap_prob_aperiodic(b, :) = prob_aperiodic;
    bootstrap_prob_nonselective(b, :) = prob_nonselective;
end

mean_prob_periodic = mean(bootstrap_prob_periodic, 1);
mean_prob_aperiodic = mean(bootstrap_prob_aperiodic, 1);
mean_prob_nonselective = mean(bootstrap_prob_nonselective, 1);

ci_low_periodic = prctile(bootstrap_prob_periodic, 2.5, 1);
ci_high_periodic = prctile(bootstrap_prob_periodic, 97.5, 1);
ci_low_aperiodic = prctile(bootstrap_prob_aperiodic, 2.5, 1);
ci_high_aperiodic = prctile(bootstrap_prob_aperiodic, 97.5, 1);
ci_low_nonselective = prctile(bootstrap_prob_nonselective, 2.5, 1);
ci_high_nonselective = prctile(bootstrap_prob_nonselective, 97.5, 1);

% Plot the mean probabilities with confidence intervals
figure;
bin_centers = bin_edges(1:end-1) + binwidth / 2; % Calculate bin centers for plotting

% Plot periodic probabilities with error bars
errorbar(bin_centers, mean_prob_periodic, mean_prob_periodic - ci_low_periodic, ci_high_periodic - mean_prob_periodic, 'g', 'LineWidth', 2);
hold on;

% Plot aperiodic probabilities with error bars
errorbar(bin_centers, mean_prob_aperiodic, mean_prob_aperiodic - ci_low_aperiodic, ci_high_aperiodic - mean_prob_aperiodic, 'r', 'LineWidth', 2);

% Plot non-selective probabilities with error bars
errorbar(bin_centers, mean_prob_nonselective, mean_prob_nonselective - ci_low_nonselective, ci_high_nonselective - mean_prob_nonselective, 'b', 'LineWidth', 2);

xlabel('Distance');
ylabel('Probability');
legend('Periodic', 'Aperiodic', 'Non-selective');
title('Probability ');
grid on;

set(gca, 'XTick', bin_centers);
end