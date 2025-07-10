

function [noise_corr_all,distance_all] =  find_4_allselectivity_types(roi,num_rois,noisevector,xy,indices1,indices2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize cell arrays to store the noise correlations and distances for each ROI
noise_corr_all = cell(num_rois, 1);
distance_all = cell(num_rois, 1);

for roino=1:size(roi,2) % for all rois
    % get the roi
    % get the number of neurons in the roi
    neurons_indices1=indices1{roino};
    neurons_indices2=indices2{roino};

    data_indices1=noisevector(neurons_indices1,:);% noise data for all neurons in this roi
    data_indices2=noisevector(neurons_indices2,:);

    roi_xypos_indices1=xy(neurons_indices1,:);
    roi_xypos_indices2=xy(neurons_indices2,:);


    noise_corr=zeros(length(neurons_indices1),length(neurons_indices2));
    distance=zeros(length(neurons_indices1),length(neurons_indices2));
    for ii=1:length(neurons_indices1)-1
        for jj=ii+1:length(neurons_indices2)
            % get the data for the neurons in this roi
            neuron1_data=data_indices1(ii,:);% 1*80 of one neuron ( noise vector)
            neuron2_data=data_indices2(jj,:);
            % compute noise correlation and distances
            corr_mat=corrcoef(neuron1_data',neuron2_data');
            noise_corr(ii,jj)=corr_mat(1,2);
            % append it to an array
            % calculate the euclidean distance
            distance(ii,jj)= sqrt((roi_xypos_indices1(ii,1)-roi_xypos_indices2(jj,1))^2+(roi_xypos_indices1(ii,2)-roi_xypos_indices2(jj,2))^2);
        end
    end
    % Store the noise correlations and distances for this ROI
    noise_corr_all{roino} = noise_corr;
    distance_all{roino} = distance;
end
