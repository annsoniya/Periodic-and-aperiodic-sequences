function main2_nc(data_allneurons,PS_inx,AS_inx)
% Assuming 'roi' is a cell array where each cell contains the indices of all neurons in each ROI
% Initialize cell arrays to store the indices for each category in each ROI
PS_indices_roi = cell(size(roi));
AS_indices_roi = cell(size(roi));
non_PS_AS_indices_roi = cell(size(roi));

% Loop over each ROI
for i = 1:length(roi)
    % Get the indices for this ROI
    roi_indices = roi{i};

    % Find the indices for each category
    PS_indices_roi{i} = intersect(roi_indices, PS_inx);
    AS_indices_roi{i} = intersect(roi_indices, AS_inx);

    % Find the indices for neurons that do not fall into any of the above categories
    non_PS_AS_indices_roi{i} = setdiff(roi_indices, union(PS_inx, AS_inx));
end
num_neurons=size(data_allneurons,1);
num_stimuli=size(data_allneurons,2);
num_trials=5;
num_bins=40;

data3D = organizeData(data_allneurons, num_neurons, num_stimuli, num_trials, num_bins);

noisevector = data_prep_fornc(data3D,num_stimuli, num_trials);
% 1821*50 matrix with noise calculated
% noisevector is the matrix with noise calculated for all 1821 neurons
% get the number of rois
num_rois=size(roi,2);
% Initialize cell arrays to store the noise correlations and distances for each ROI
noise_corr_all = cell(num_rois, 1);
distance_all = cell(num_rois, 1);
for roino=1:num_rois % for all rois
    % get the roi
    roi_neurons=roi{roino};% indices of cells in that roi % all cell indices
    % get the number of neurons in the roi
    num_neurons_in_this_roi=size(roi_neurons,1);
    roi_data=noisevector(roi_neurons,:);% noise data for all neurons in this roi
    roi_xypos=xy(roi_neurons,:);
    noise_corr=zeros(num_neurons_in_this_roi,num_neurons_in_this_roi);
    distance=zeros(num_neurons_in_this_roi,num_neurons_in_this_roi);
    for ii=1:(num_neurons_in_this_roi-1)
        for jj=ii+1:num_neurons_in_this_roi
            % get the data for the neurons in this roi
            neuron1_data=roi_data(ii,:);% 1*80 of one neuron ( noise vector)
            neuron2_data=roi_data(jj,:);
            % compute noise correlation and distances
            corr_mat=corrcoef(neuron1_data',neuron2_data');
            noise_corr(ii,jj)=corr_mat(1,2);
            % append it to an array
            % calculate teh euclidean diastance
            distance(ii,jj)= sqrt((roi_xypos(ii,1)-roi_xypos(jj,1))^2+(roi_xypos(ii,2)-roi_xypos(jj,2))^2);
        end
    end
    % Store the noise correlations and distances for this ROI
    noise_corr_all{roino} = noise_corr;
    distance_all{roino} = distance;

end
%% (1,-1)
clear indices1 indices2 noise_corr_all distance_all;
%  non_PS_AS_indices_roi
%%%%%% user - choose the indices according to teh plot to be generated%%%%
indices1= PS_indices_roi;
indices2= PS_indices_roi ;

indices1= AS_indices_roi;
indices2= AS_indices_roi ;

indices1=non_PS_AS_indices_roi;
indices2=non_PS_AS_indices_roi;

[noise_corr_all,distance_all] = find_4_allselectivity_types(roi,num_rois,noisevector,xy,indices1,indices2);

%% periodic stimuli set
per.psps.nc=noise_corr_all;per.psps.dis=distance_all;

per.asas.nc=noise_corr_all;per.asas.dis=distance_all;

per.nsns.nc=noise_corr_all;per.nsns.dis=distance_all;

per.psns.nc=noise_corr_all;per.psns.dis=distance_all;

per.asps.nc=noise_corr_all;per.asps.dis=distance_all;

per.nsas.nc=noise_corr_all;per.nsas.dis=distance_all;

%% for aper stimuli set
aper.psps.nc=noise_corr_all;aper.psps.dis=distance_all;

aper.asas.nc=noise_corr_all;aper.asas.dis=distance_all;


aper.nsns.nc=noise_corr_all;aper.nsns.dis=distance_all;

aper.psns.nc=noise_corr_all;aper.psns.dis=distance_all;

aper.asps.nc=noise_corr_all;aper.asps.dis=distance_all;

aper.nsas.nc=noise_corr_all;aper.nsas.dis=distance_all;


%% for periodic stimuli set
close all

figure;
hold on;
nc=per.psps.nc;
di=per.psps.dis;
[nofopairs_per, avg_noise_corr_per, ncbin_per, ci_lower_per, ci_upper_per] = plot_bootstrapped(bin_width, di, nc);
x= nofopairs_per;
x_t=avg_noise_corr_per;
% for aperiodic stimuli
nc=aper.asas.nc;
di=aper.asas.dis;

[nofopairs_aper, avg_noise_corr_aper, ncbin_aper, ci_lower_aper, ci_upper_aper] = plot_bootstrapped(bin_width, di, nc);
y= nofopairs_aper;
y_t=avg_noise_corr_aper;

% plotting no of pairs
figure
bar(y);

%perform tttest2 to mean zero for all bins periodic and aperiodi separately

clc
for i=1:size(ncbin_per,2)
    [h, p, ci, stats] = ttest(ncbin_per{1, i}, 0); % for mean noise correlation values
    fprintf('mean test stats for periodic bin %d: h = %d, p = %.4f\n', i, h, p);

    [h, p, ci, stats] = ttest(ncbin_aper{1, i}, 0); % for mean noise correlation values
    fprintf('mean test stats for aperiodic bin %d: h = %d, p = %.4f\n', i, h, p);
end

%%
%% rum after running periodic atimset and aperiuodic atim set for same category
%
clc
s1
s2

[h, p, ci, stats] = ttest2(x_t, y_t); % for mean noise correlation values
fprintf('mean test overall stats: h = %d, p = %.4f\n', h, p);

% Plot histograms for periodic and aperiodic pair numbers
% Compare every bin with ttest
for i = 1:size(ncbinPer, 2)
    % Ttest
    [h, p, ci, stats] = ttest2(ncbinPer{1, i}, ncbinaper{1, i});
    fprintf('ttest test stats: h = %d, p = %.4f\n', h, p);
end
end