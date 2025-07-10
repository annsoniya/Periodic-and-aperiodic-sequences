function [final_btsrp,lowerBound,upperBound]=bootstrap_chk(data)
numBootstraps = 1000;

% Initialize matrix to store bootstrap samples
bootstrapSamples = zeros(numBootstraps, size(data, 2));

% Perform bootstrapping
for i = 1:numBootstraps
    % Sample with replacement
    sampleIndices = randi(size(data, 1), size(data, 1), 1);
    bootstrapSample = data(sampleIndices, :);
    
    % Calculate the statistic of interest (e.g., mean)
    bootstrapSamples(i, :) = nanmean(bootstrapSample);
end

% Calculate confidence intervals (e.g., 95% CI)
alpha = 0.05;
lowerBound = prctile(bootstrapSamples, 100 * (alpha / 2));
upperBound = prctile(bootstrapSamples, 100 * (1 - alpha / 2));

% Display the results
disp('Lower Bound of 95% CI:');
disp(lowerBound);
disp('Upper Bound of 95% CI:');
disp(upperBound);
final_btsrp=nanmean(bootstrapSamples);
% % Plot the selectivity 
% %figure;
% plot (1:size(bootstrapSamples,2),nanmean(bootstrapSamples));
% %mark ci as error bars
% errorbar(1:size(bootstrapSamples,2), lowerBound, upperBound);
% hold on;

end
