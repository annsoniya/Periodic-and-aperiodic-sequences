function plot_mean_rates(per,aper)
 % Current matrix

 columnMeans = nanmean(per, 1); % Column-wise mean ignoring NaNs
 columnSEMs = nanstd(per, 0, 1) ./ sqrt(sum(~isnan(per), 1)); % Standard Error of the Mean ignoring NaNs
 columnMeans2 = nanmean(aper, 1); % Column-wise mean ignoring NaNs
 columnSEMs2 = nanstd(aper, 0, 1) ./ sqrt(sum(~isnan(aper), 1)); % Standard Error of the Mean ignoring NaNs
 
 % Calculating the mean and SEM across columns (ignoring NaNs) for the current matrix
 
 %specifiy plot colour
 %solidlines
 LineStyle = 'none';
 p1 = plot(columnMeans, 'LineWidth', 2,'Color', 'g', 'DisplayName', 'Periodic'); % Use 'DisplayName' for legend
 
 
 errorbar(1:length(columnMeans), columnMeans, columnSEMs, 'LineStyle', 'none', 'Color', 'g');
 p2 = plot(columnMeans2, 'LineWidth', 2 ,'Color', 'r', 'DisplayName', 'Aperiodic'); % Use 'DisplayName' for legend
 
 %          plot(columnMeans2, 'LineWidth', 2,'Color','c'); % Adjust 'LineWidth' as needed
 errorbar(1:length(columnMeans2), columnMeans2, columnSEMs2, 'LineStyle', 'none', 'Color', 'r');
 legend('periodic','Aperiodic');

end