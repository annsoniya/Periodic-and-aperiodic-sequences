%% ann _prediction analysis
%% ann _prediction analysis
clc
clear
%run data_classification 
data_classification()

%% 
stimdata_per=data_per_3;
stimdata_aper=data_aper_3;
width=30;
period=12;
per3= fn2_norm_andpred(stimdata_per,stimdata_aper,width,period);
%% per4
stimdata_per=data_per_4;
stimdata_aper=data_aper_4;
width=40;
period=9;
per4=fn2_norm_andpred(stimdata_per,stimdata_aper,width,period);
%%
stimdata_per=data_per_3_2f1f2;
stimdata_aper=data_aper_3_2f1f2;
width=30;
period=12;
per3_2f1f2= fn2_norm_andpred(stimdata_per,stimdata_aper,width,period);

%% stimdata_per=data_per_3_2f1f2;
stimdata_aper=data_aper_3_2f2f1;
width=30;
period=12;
per3_2f2f1= fn2_norm_andpred(stimdata_per,stimdata_aper,width,period);
%% 
combined_matrix = cat(1, reshape(per3, [1, 500, 2]), ...
                         reshape(per4, [1, 500, 2]), ...
                         reshape(per3_2f1f2, [1, 500, 2]), ...
                         reshape(per3_2f2f1, [1, 500, 2]));
reshaped_matrix = reshape(combined_matrix, [4, 500, 2]);

slopes = squeeze(reshaped_matrix(:,:,1)); % Slopes, dimensions [4, 500]
intercepts = squeeze(reshaped_matrix(:,:,2)); % Intercepts, dimensions [4, 500]
% Create boxplots
figure;
% Boxplot for slopes
subplot(2, 1, 1);
boxplot(slopes', 'Labels', {'p3', 'p4', 'p32f1f2', 'p32f2f1'});
title('Boxplot of Slopes');
xlabel('Groups');
ylabel('Slope');

% Boxplot for intercepts
subplot(2, 1, 2);
boxplot(intercepts', 'Labels', {'p3', 'p4', 'p32f1f2', 'p32f2f1'});
title('Boxplot of Intercepts');
xlabel('Groups');
ylabel('Intercept');