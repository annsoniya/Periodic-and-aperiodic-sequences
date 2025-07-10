function data3D = organizeData(data, num_neurons, num_stimuli, num_trials, num_bins)
    data3D = zeros(num_neurons, num_stimuli, num_trials, num_bins);
    for neuron = 1:num_neurons
        for stim = 1:num_stimuli
            data3D(neuron, stim, :, :) = data{neuron, stim};
        end
    end
end

