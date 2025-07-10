% aim:- find cells that are sig to per but not aperiodic with
%bonferoni correction=6 for periodic
%and 4 for aperiodic

%data read
close all;
clear all;
clc
data= load('sig_data_img_old.mat');% thsi hgas all cells if they responded to any stimuli
data=table2cell(data.sig_data_img_old);

%% do theg same with bleaching correction

%%%%%%%%%%%%%%%
periodic_stimset_4=[1,2,9,10];
aperiodic_stimset_4=[11,12];
periodic_stimset_3=[3,4,5,6,7,8];
aperiodic_stimset_3=[13,14,15,16];
per_set=[1,2,3,4,5,6,7,8,9,10];
aper_set=[11,12,13,14,15,16];
periodic_stimset_3_2f2f1=[3,6,8];
aperiodic_stimset_3_2f2f1=[13,14];
periodic_stimset_3_2f1f2=[4,5,7];
aperiodic_stimset_3_2f1f2=[15,16];
% plan
%split into stimwise  and periodicity wise
%find cumulatve for 3 frames=600ms
%apply ttest and find significant cases amon=g periodic an d aperiodic

%% split into stimwise  and periodicity wise
data_per=data(:,periodic_stimset_3);
%data_per_4=data(:,periodic_stimset_4);
data_aper=data(:,aperiodic_stimset_3);
%data_aper_4=data(:,aperiodic_stimset_4);

%% p3-2f1f2

data_per=data(:,periodic_stimset_3_2f1f2);
data_aper=data(:,aperiodic_stimset_3_2f1f2);

%% p3 - 2f2f1
data_per=data(:,periodic_stimset_3_2f2f1);
data_aper=data(:,aperiodic_stimset_3_2f2f1);
%%
data_per=data(:,periodic_stimset_4);
data_aper=data(:,aperiodic_stimset_4);


%% %% periodicity 3 %%%%%%%%%%%

for i=1:size(data_per,1) %%** 6 stim*5 trials *40 frmaes
    per=[];
    per= cat(1,data_per{i,:});%
    baseline_per=mean(per(:,4:8),2);
    %find mean of all trials across 9:33 frames
    mean_per=mean(per(:,9:33),2);

    %find sig of this cell using ttest2 with alpha value =0.05
    [h, p_value] = ttest2(baseline_per, mean_per, 'Alpha', 0.05);
    %   [h, p_value] = ttest2(baseline_per_3, mean_per_3, 'Alpha', 0.05/bon_corr);

    if h==1
        value_per(i)=mean(mean(per(:,9:33),2));% if significant, then store the mean value of the cell else make it to zero
    else
        value_per(i)=0;
    end

    aper=[];
    aper= cat(1,data_aper{i,:});%
    baseline_aper=mean(aper(:,4:8),2);
    %find mean of all trials across 9:33 frames
    mean_aper=mean(aper(:,9:33),2);
    [h, p_value] = ttest2(baseline_aper, mean_aper, 'Alpha', 0.05);
    % [h, p_value] = ttest2(baseline_aper_3, mean_aper_3, 'Alpha', 0.05/bon_corr);
    if h==1
        value_aper(i)=mean(mean(aper(:,9:33),2));
    else
        value_aper(i)=0;
    end
end

% sort periodic data based on mean values from highest to lowest

sorted_indices_per=[];
sorted_values_per=[];
[sorted_values_per, sorted_indices_per] = sort(value_per, 'descend');
zero_indices_per = sorted_indices_per(sorted_values_per == 0);
% find non zero indices
non_zero_indices_per = sorted_indices_per(sorted_values_per ~= 0);


% sort aperiodic data based on mean values from highest to lowest
sorted_indices_aper=[];
sorted_values_aper=[];
[sorted_values_aper, sorted_indices_aper] = sort(value_aper, 'descend');
zero_indices_aper = sorted_indices_aper(sorted_values_aper == 0);
% find non zero indices
non_zero_indices_aper = sorted_indices_aper(sorted_values_aper ~= 0);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%segment 1 - make the insignificant cells to zero mean data in periodic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_aper_withmeanzero=data_aper;
data_aper_withmeanzero(zero_indices_aper,:) = {0};
zz=data_aper_withmeanzero(sorted_indices_aper,:);
for y = 1:size(zz, 1)
    mean_sorted_data_aper_withmeanzero(y, :) = mean(cat(1, zz{y, :}));
end
subplot(1, 3, 1)
hold on;
bar(mean(mean_sorted_data_aper_withmeanzero(:, 9:33), 2),'r');
title('mean values of sorted Aperiodic cells with zero mean values for insignificant cells');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%segment 3= change teh orderof aperiodic data according to periodic high to low)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sort periodic data based on mean values from highest to lowest
sorted_data_per = data_per(sorted_indices_aper, :);
for y = 1:size(sorted_data_per, 1)
    mean_sorted_data_per(y, :) = mean(cat(1, sorted_data_per{y, :}));
end
%plot it in teh order of periodic high to low
figure
subplot(1, 3, 1)
stem(mean(mean_sorted_data_per(:, 9:33), 2),'Color', [0,0, 0.5]);
title(' all PERIODIC DATA (1821) in the order of Aperiodic indices H > L');

%%%%%%%%%%%%%%%%segment =4%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the Aperiodic significant cells in the order of periodic high to low
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% find f any periodic cells are sig to aperiodic
% find the common indices between zero_indices_per3 and non_zero_indices_aper3
per3.AperInsig_perSig= intersect(zero_indices_aper, non_zero_indices_per);
% find cells sig in periodic ,but not sig in aper
per3.APerSig_perInSig = intersect(non_zero_indices_aper,zero_indices_per);
% number ofd cells in each caseA
numel(per3.AperInsig_perSig)
numel(per3.APerSig_perInSig)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   segment =4    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plopt the aperiodic data of diff cells and common cells in two different colours in the order of periodic high to low
clear diff_data_per;
%declare  mean_diff_data_aper;
mean_diff_data_per=zeros(size(data_per,1),size(data_per{1,1},2));
diff_data_per=data_per;
diff_data_per(zero_indices_per,:) = {0};
%sort it in the order of aperiodic high to low
diff_data_per=diff_data_per(sorted_indices_aper,:);
%diff_data_aper(non_zero_indices_per,:) = {0};
for y = 1:size(diff_data_per, 1)
    mean_diff_data_per(y, :) = mean(cat(1, diff_data_per{y, :}));
end
subplot(1, 3, 2)
stem(mean(mean_diff_data_per(:, 9:33), 2),'Color', [0,0, 0.5]);
xlabel('cells in theorder of Aperiodic high to low');
title('Periodic data- zero mean for periodic insignificant cells , sorted(Aper - H > L)');

%%%%%%%%%%
clear diff_data_per;
%declare  mean_diff_data_aper;
mean_diff_data_per=zeros(size(data_per,1),size(data_per{1,1},2));
diff_data_per=data_per;
diff_data_per(zero_indices_per,:) = {0};
diff_data_per(non_zero_indices_aper,:) = {0};
%sort it in the order of aperiodic high to low
diff_data_per=diff_data_per(sorted_indices_aper,:);
for y = 1:size(diff_data_per, 1)
    mean_diff_data_per(y, :) = mean(cat(1, diff_data_per{y, :}));
end
subplot(1, 3, 3)
bar(mean(mean_diff_data_per(:, 9:33), 2),'r');
stem(mean(mean_diff_data_per(:, 9:33), 2),'Color', [0,0, 0.5]);
xlabel('cells in teh order of Aperiodic high to low');
title('Periodic data (per_insig= 0 + Aper_sig= 0) = exclusively Periodic selctive ');

