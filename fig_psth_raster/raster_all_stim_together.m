% lets grp per_3 and per_4(periodic and aperiodic
%run data classification
clear
clc
data=load('perrand_gap.mat');
db=data.perrand_gap;
figHandle=figure;

mainCell_per = cat(2, db.data_per_stim_gap_70, db.data_per_stim_gap_120, db.data_per_stim_gap_170, db.data_per_stim_gap_270);
mainCell_aper = cat(2, db.data_aper_stim_gap_70, db.data_aper_stim_gap_120, db.data_aper_stim_gap_170, db.data_aper_stim_gap_270);

for i=1:length(mainCell_per)
    clf(figHandle);

    subplot(2,1,1);
    per=cat(1,mainCell_per{i,:});
    raster_plot(per);
    % aperiodic plots
    subplot(2,1,2)
    aper=cat(1,mainCell_aper{i,:});
    raster_plot(aper);
    % Assuming ii ranges from 1 to 4 and corresponds to per_3, aper_3, per_4, aper_4 respectively
    titleStr = sprintf('cell number %d', i); % Format the title string
    subtitle(titleStr); % Set the title
    %hold off;
    pause;

end

