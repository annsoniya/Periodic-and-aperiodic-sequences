% find teh cmulative seg
%for each gap seperatey% 
    % each gap 
  clear ;
  load('perrand_gap.mat')
  
    % find cumulative segemnts in teh order of 300 added to 501 lie 501-800, 501-1100, 501-1400, 501-1700, 501-2000, 501-2300, 501-2600, 501-2900, 501-3200, 501-3500, 501-3800, 501-4100, 501-4400
startBin = 500;
tokend=4100;
%change according to teh gaps 
gaps=[70,120,170,270];
for i=1:length(gaps)
    gap=gaps(i);
    if gap==70
        data_per=perrand_gap.data_per_stim_gap_70;
        data_aper=perrand_gap.data_aper_stim_gap_70;
        tok1=800;
        tok2=300 ;
        endBins = tok1:tok2:tokend; % Creates an array [800, 1100, ..., 4400]
        cum_perrand_gap_70= cum_analysis_psoras(data_per, data_aper, startBin, endBins, gap);
    elseif gap==120
        data_per=perrand_gap.data_per_stim_gap_120;
        data_aper=perrand_gap.data_aper_stim_gap_120;
        tok1=950;
        tok2=450 ;
        endBins = tok1:tok2:tokend; % Creates an array [800, 1100, ..., 4400]
        cum_perrand_gap_120= cum_analysis_psoras(data_per, data_aper, startBin, endBins, gap);
    elseif gap==170
        data_per=perrand_gap.data_per_stim_gap_170;
        data_aper=perrand_gap.data_aper_stim_gap_170;
          tok1=1100;
        tok2=600 ;
        endBins = tok1:tok2:tokend; % Creates an array [800, 1100, ..., 4400]
      
        cum_perrand_gap_170= cum_analysis_psoras(data_per, data_aper, startBin, endBins, gap);
    elseif gap==270
        data_per=perrand_gap.data_per_stim_gap_270;
        data_aper=perrand_gap.data_aper_stim_gap_270;
         tok1=1400;
        tok2=900 ;
        endBins = tok1:tok2:tokend; % Creates an array [800, 1100, ..., 4400]
       
        cum_perrand_gap_270 = cum_analysis_psoras(data_per, data_aper, startBin, endBins, gap);
    end
end

    %% declare all the variable in proper sizes


save cum_perrand_gap_70 cum_perrand_gap_70
save cum_perrand_gap_120 cum_perrand_gap_120
save cum_perrand_gap_170 cum_perrand_gap_170
save cum_perrand_gap_270 cum_perrand_gap_270