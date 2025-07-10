% we have two mats stored. one is rows2 mat for roi and it has all indices .
% then sig_data_img_old has all 1821 neurons data seperateed as 1821*16 (For 16 stimuli)
% every time we have to map teh neurons in each roi to each row in sig_data_img_old
clear ;
clc
close all;
bin_width = 20;  % in micrometers

%%
% total_elements = sum(cellfun(@numel, rows2));
% load the data
roi=load('rows2.mat');% 1*27
roi=roi.rows2;
data_allneurons=load('sig_data_img_old.mat');
data_all=table2cell(data_allneurons.sig_data_img_old);  % 1821*16 cell

stimset_4=[1,2,9,10,11,12];
stimset_3=[3,4,5,6,7,8,13,14,15,16];% periodic , periodic ty =3

periodic_stimset_4=[1,2,9,10];% periodic , periodicyt=4
%
aperiodic_stimset_4=[11,12];% aperiodic , periodicity =4
%
periodic_stimset_3=[3,4,5,6,7,8];% periodic , periodicty =3
%
aperiodic_stimset_3=[13,14,15,16]; % aperiodic , periodicity =3

periodic_stimset_3_2f2f1=[3,6,8];
aperiodic_stimset_3_2f2f1=[13,14];
periodic_stimset_3_2f1f2=[4,5,7];
aperiodic_stimset_3_2f1f2=[15,16];

db= load('db_sig_cells_only.mat');
db=db.db_sig_cells_only;

xy=zeros(size(db,1),2);
xy(:,1)=db{:,8};
xy(:,2)=db{:,9};% xy matrix has teh x and y positions if all 1821 cells

%% load th indices of eclusive selctive PS adn AS units
load('per4.mat')
load('per3.mat')

load('per3_2f1f2.mat')

load('p3_2f2f1.mat')

per_3_PS_indices=per3.AperInsig_perSig;
per_3_AS_indices=per3.APerSig_perInSig;

per_4_PS_indices=per4.AperInsig_perSig;
per_4_AS_indices=per4.APerSig_perInSig;

per3_2f1f2_PS_indices=per3_2f1f2.PerSig_AperInSig;
per3_2f1f2_AS_indices=per3_2f1f2.perInsig_aperSig;


p3_2f2f1_PS_indices=p3_2f2f1.PerSig_AperInSig ;
p3_2f2f1_AS_indices=p3_2f2f1.perInsig_aperSig;


%% %%%%%%%%%%%%%%% choose the required dataset independently and run the rest  %%%%%%%%%%%%%%%
data_allneurons=data_all(:,stimset_3);

% for periodicty =4
data_allneurons=data_all(:,stimset_4);

data_allneurons=data_all(:,periodic_stimset_3);

data_allneurons=data_all(:,aperiodic_stimset_3);

data_allneurons=data_all(:,periodic_stimset_4);

data_allneurons=data_all(:,aperiodic_stimset_4);


%%categories of p3

data_allneurons=data_all(:,periodic_stimset_3_2f1f2);

data_allneurons=data_all(:,aperiodic_stimset_3_2f1f2);
%

data_allneurons=data_all(:,periodic_stimset_3_2f2f1);

data_allneurons=data_all(:,aperiodic_stimset_3_2f2f1);

%% % give the indices for each case

PS_inx=per_3_PS_indices;

AS_inx=per_3_AS_indices;

%% call main2_nc.m
main2_nc(data_allneurons,PS_inx,AS_inx)