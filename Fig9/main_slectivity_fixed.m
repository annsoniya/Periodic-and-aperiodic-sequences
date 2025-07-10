%load data file
%divideit into each stim category
clc
clear
%run data_classification
data_classification
%%
stimdata_per=data_per_3;
stimdata_aper=data_aper_3;
width=30;
period=12;
[final_btsrp_per3,final_btsrp_aper3]= fn2_selectivity_per_aper_seperate(stimdata_per,stimdata_aper,width,period);
title('period3')
%% per4
stimdata_per=data_per_4;
stimdata_aper=data_aper_4;
width=40;
period=9;
[final_btsrp_per4,final_btsrp_aper4]= fn2_selectivity_per_aper_seperate(stimdata_per,stimdata_aper,width,period);
title('period4')

%%
stimdata_per=data_per_3_2f1f2;
stimdata_aper=data_aper_3_2f1f2;
width=30;
period=12;
[final_btsrp_per3_2f1f2,final_btsrp_aper3_2f1f2]= fn2_selectivity_per_aper_seperate(stimdata_per,stimdata_aper,width,period);
title('period3-2f1f2')

%% stimdata_per=data_per_3_2f1f2;
stimdata_aper=data_aper_3_2f2f1;
width=30;
period=12;
[final_btsrp_per3_2f2f1,final_btsrp_aper3_2f2f1]= fn2_selectivity_per_aper_seperate(stimdata_per,stimdata_aper,width,period);
title('period3-2f2f1')
