clear all;
clc;
close all;
% load database all cells in database after significance test
data= load('dataSignificant_perrand_gap.mat');
data=data.dataSignificant_perrand_gap;

% classify teh data into periodic and aperiodic and periodicities 
% 1. periodic whoel set0.

periodic_stimset_all=[1,3,5,7,9,11,13,15];
aperiodic_stimset_all=[2,4,6,8,10,12,14,16];
% based on gap
stims_gap_70=[1,2,3,4];
stims_gap_120=[5,6,7,8];
stims_gap_170=[9,10,11,12];
stims_gap_270=[13,14,15,16];

% periodic and aperiodic based on gaps
per_stim_gap_70=[1,3];
aper_stim_gap_70=[2,4];

per_stim_gap_120=[5,7];
aper_stim_gap_120=[6,8];

per_stim_gap_170=[9,11];
aper_stim_gap_170=[10,12];


per_stim_gap_270=[13,15];
aper_stim_gap_270=[14,16];

% classify data based on teh above stimsets (1*5000)


perrand_gap.data_periodic_stimset_all=data(:,periodic_stimset_all);
perrand_gap.data_aperiodic_stimset_all=data(:,aperiodic_stimset_all);

perrand_gap.data_stims_gap_70=data(:,stims_gap_70);
perrand_gap.data_stims_gap_120=data(:,stims_gap_120);
perrand_gap.data_stims_gap_170=data(:,stims_gap_170);
perrand_gap.data_stims_gap_270=data(:,stims_gap_270);

perrand_gap.data_per_stim_gap_70=data(:,per_stim_gap_70);
perrand_gap.data_aper_stim_gap_70=data(:,aper_stim_gap_70);

perrand_gap.data_per_stim_gap_120=data(:,per_stim_gap_120);
perrand_gap.data_aper_stim_gap_120=data(:,aper_stim_gap_120);

perrand_gap.data_per_stim_gap_170=data(:,per_stim_gap_170);
perrand_gap.data_aper_stim_gap_170=data(:,aper_stim_gap_170);


perrand_gap.data_per_stim_gap_270=data(:,per_stim_gap_270);
perrand_gap.data_aper_stim_gap_270=data(:,aper_stim_gap_270);
save('perrand_gap.mat', 'perrand_gap', '-v7.3');




