# Periodic-and-aperiodic-sequences
 v1.0.0  annsoniya/Periodic-and-aperiodic-sequences: v1.0.0
 DOI: 10.5281/zenodo.15852474
v1.0.0



This repo contains all codes arranged as per the figures in our paper 
This repository contains scripts and datasets used for classifying neural response data into different stimulus sets based on Fixed-ITI and Multiple-ITI conditions. These scripts support the analysis and figure generation for our paper


 1 data_classification_fixed-iti.m
Purpose: Classifies the neural response data into stimulus sets under the Fixed ITI paradigm.

Main Data Used: data_perrand_gap.mat

2. data_classification_multiple-iti.m
Purpose: Classifies the neural response data into stimulus sets under the Multiple ITI paradigm.

Main Data Used: data_perrand_old.mat

3. Main imaging data :- sig_data_img_old

%%% folders and purpose 

1. Folder- fig_psth_raster
This folder contains scripts to generate PSTH (Peri-Stimulus Time Histogram) and raster plots for selected neurons or stimulus conditions.

Figures Generated:Figure 2A and 2B, Figure 7A and 7B

2. Folder - fig2_7-CRR
This folder contains scripts to generate CRR (Cumulative Response Rate) plots.

To generate CRR (Normalized): run cumulative_analysis4slectivity.m

To find selectivity and generalization tables: run intersection_union.m

3. Folder - Fig2C_Fig3
This folder has scripts to generate Figure 2C (mean cumulative plots) and Figure 3 (scatter plots and histograms).

Required .mat files:

withgap_cum_analysis.mat (for with-ITI data)

withoutgap_cum_analysis.mat (for without-ITI data)

Run main_scatter_call.m to generate the scatter and histogram plots for Figure 3.

Statistical comparisons were performed by compare_with_without.m. For comparing the with-ITI and without-ITI conditions and for comparing the PS- AS CRR.


4. Folder- Fig4

main_prep_all_iters. - to plot figure 4 A and B (example neurons) 
Periodic_data_in_aperiodic_order.m  is used to get fig 4 periodic data panels and table 4 and table 5 information 
Aperiodic_data_in_periodic_order.m  is used to get fig 4 Aperiodic data panels and table 4 and table 5 information 

5. Folder- Fig5

container_map_for_roi.m - creates roi based cell clustering . generated output is rows2.mat and this is used for finding cells in a particular roi
main_nc_bootstrapped.m- main file where the noise vectors and all Nc related calculations and plots are called from 

6. Folder - Fig6

main_spatial_arrangement.m takes data and indices and passes onto the main2_spatial.m , where the spatial arrangement is checked and plotted 

7. Folder - Fig7 

final_for_comparing_with_without_ingapstimuli.m for comparing the with-ITI and without-ITI conditions and for comparing the PS- AS CRR.

final_mean_rate_forfigure.m for CRR(Norm) mean rates plots 

main_scatter_call.m - for fig 8(a,b,c,d) - 

8.Folder -Fig8E
main_csi_gap.m - main function for data preparation and calls compare_with_PSAS.m , which performs CSI calculation and generate plots 

9. Folder - Fig 9
main_slectivity_fixed.m and main_slectivity_multiple.m performs the period wise response rates calculations for fixed-ITI and Multiple-ITI stimulus sets respectively 

10.Fig10
perdiction_fixed_before_period.m calclulates the build up of responses as for the fixed-ITI stimulus set 
perdiction_multiple_before_period.m calclulates the build up of responses as for the multiple-ITI stimulus set .

pred_before_third_token.m shows the build up before the third token in a period 
pred_before_second_token.m shows the build up before the second token in a period

