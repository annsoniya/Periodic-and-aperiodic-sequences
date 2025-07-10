% spatial analysis
clear ;
clc
close all;

binwidth = 20; % Bin width for distance bins (adjust as needed)
max_distance = 220; % Maximum distance to consider (adjust as needed)
bin_edges = 0:binwidth:max_distance; % Edges of the bins
num_bins = length(bin_edges) - 1; % Number of bins

roi=load('rows2.mat');% 1*27
roi=roi.rows2;
num_rois=size(roi,2);
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

%% load the indices of exclusive selctive PS and AS units
load('per3.mat')
per_3_PS_indices=per3.AperInsig_perSig;
per_3_AS_indices=per3.APerSig_perInSig;
load('per4.mat')
load('p3_2f2f1.mat')
load('per3_2f1f2.mat')
per_4_PS_indices=per4.AperInsig_perSig;
per_4_AS_indices=per4.APerSig_perInSig;
per3_2f1f2_PS_indices=per3_2f1f2.PerSig_AperInSig;
per3_2f1f2_AS_indices=per3_2f1f2.perInsig_aperSig;
p3_2f2f1_PS_indices=p3_2f2f1.PerSig_AperInSig ;
p3_2f2f1_AS_indices=p3_2f2f1.perInsig_aperSig;

%% % give teh indices for each case from the above for each plot
PS_inx=p3_2f2f1_PS_indices;
AS_inx=p3_2f2f1_AS_indices;
%% call
main2_spatial(PS_inx,AS_inx);