function noisevector = data_prep_fornc(data,num_stimuli, num_trials)

% Initialize the result matrix
yy=num_stimuli* num_trials;
noisevector=zeros(size(data,1),yy);
% Loop over each 'n'
for i = 1:size(data,1) % for every neuron
    result = zeros(yy, 1);
    % Extract the 9:33 range and take the mean along the 4th dimension
    subset = squeeze(mean(data(i, :, :, 9:33), 4));

    % For each of the 16 values, subtract the mean of the 5 values
    for j = 1:size(data,2) % for all stim
        subset_afternoise(j, :) = subset(j, :) - mean(subset(j, :),2);
    end
    new_subset_afternoise=subset_afternoise';
    % Reshape the result to a column vector and append it to the result matrix
    result = new_subset_afternoise(:);
    noisevector(i, :) = squeeze(result);
end
end


