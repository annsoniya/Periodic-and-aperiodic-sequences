clear all;
clc;
close all;
data= load('dataSignificant_perrand_old.mat');
data=data.dataSignificant_perrand_old;

% classify teh data into periodic and aperiodic and periodicities 
% 1. periodic whoel set0.

periodic_stimset_4=[1,2,9,10];
aperiodic_stimset_4=[11,12];
periodic_stimset_3=[3,4,5,6,7,8];
aperiodic_stimset_3=[13,14,15,16];
per_set=[1,2,3,4,5,6,7,8,9,10];
aper_set=[11,12,13,14,15,16];
% based on spectral energies
peperiodic_stimset_3_2f2f1=[3,6,8];
aperiodic_stimset_3_2f2f1=[13,14];
periodic_stimset_3_2f1f2=[4,5,7];
aperiodic_stimset_3_2f1f2=[15,16];
% plan 
%split into stimwise  and periodicity wise
%find cumulatve for 3 frames=600ms
%apply ttest and find significant cases amon=g periodic an d aperiodic

%split into stimwise  and periodicity wise
data_per_3=data(:,periodic_stimset_3);
data_per_4=data(:,periodic_stimset_4);
data_aper_3=data(:,aperiodic_stimset_3);
data_aper_4=data(:,aperiodic_stimset_4);
data_per_3_2f2f1=data(:,peperiodic_stimset_3_2f2f1);
data_aper_3_2f2f1=data(:,aperiodic_stimset_3_2f2f1);
data_per_3_2f1f2=data(:,periodic_stimset_3_2f1f2);
data_aper_3_2f1f2=data(:,aperiodic_stimset_3_2f1f2);

% stm starts from 500 to 4100 foir 3600ms 
% now classify into segments 



