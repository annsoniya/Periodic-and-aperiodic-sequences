%load data file
%divideit into each stim category

clc
clear
%run data_classification
%data_classification

load('perrand_gap.mat');
%%
stimdata_per=perrand_gap.data_per_stim_gap_70  ;
stimdata_aper=perrand_gap.data_aper_stim_gap_70  ;
width=30;
period=12;
%[final_p3_csi,final_btsrp_p3_csi]= fn2_selectivity(stimdata_per,stimdata_aper,width,period);
[final_btsrp_per_70,final_btsrp_aper_70]= fn2_selectivity_per_aper_seperate(stimdata_per,stimdata_aper,width,period);
title('Periodic and Aperiodic Data gap70');
%% per4
stimdata_per=perrand_gap.data_per_stim_gap_120;
stimdata_aper=perrand_gap.data_aper_stim_gap_120;
width=45;
period=8;
%[final_p4_csi,final_btsrp_p4_csi]= fn2_selectivity(stimdata_per,stimdata_aper,width,period);
[final_btsrp_per_120,final_btsrp_aper_120]= fn2_selectivity_per_aper_seperate(stimdata_per,stimdata_aper,width,period);
title('Periodic and Aperiodic Data gap120');
%%
stimdata_per=perrand_gap.data_per_stim_gap_170;
stimdata_aper=perrand_gap.data_aper_stim_gap_170;
width=60;
period=6;
[final_btsrp_per_170,final_btsrp_aper_170]= fn2_selectivity_per_aper_seperate(stimdata_per,stimdata_aper,width,period);
title('Periodic and Aperiodic Data gap170');

%% stimdata_per=data_per_3_2f1f2;
stimdata_per=perrand_gap.data_per_stim_gap_270;
stimdata_aper=perrand_gap.data_aper_stim_gap_270;
width=90;
period=4;

[final_btsrp_per_270,final_btsrp_aper_270]= fn2_selectivity_per_aper_seperate(stimdata_per,stimdata_aper,width,period);
title('Periodic and Aperiodic Data gap270');
