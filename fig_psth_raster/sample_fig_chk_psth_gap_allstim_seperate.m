

 %% % clear
 clear
 clc
 data=load('dataSignificant_perrand_gap_auv.mat');
 db=data.dataSignificant_perrand_gap_auv;
 % poot imagesc for each sti mulus and each cell seperataelty and choose teh best stimulus
 % also olot teh olots with 10ms bins and smotthening
 binsize = 25; % 10 ms bins
 no_bins = 4200/binsize;     % 5000 ms total time
 figHandle = figure;
 
 % Initialize global max and min values
 global_max_val = -inf;
 global_min_val = inf;
 
 %% First pass to determine global max and min values
 for i=1:length(db)
     for stim=1:16
         x = mean(cell2mat(db(i,stim)));
         xx = x(:,1:4500); % Assuming xx is 1x5000
         for ii=1:no_bins
             yy(ii) = sum(xx((ii-1)*binsize+1:ii*binsize));
             yy(ii) = yy(ii) * (1000 / binsize);
         end
         yy = gaussmoth(yy, 1);
         global_max_val = max(global_max_val, max(yy));
         global_min_val = min(global_min_val, min(yy));
     end

 
 % Second pass to plot with global ylim
     clf(figHandle)
     for stim=1:16
         subplot(4,4,stim);
         x = mean(cell2mat(db(i,stim)));
         xx = x(:,1:4500); % Assuming xx is 1x5000
         for ii=1:no_bins
             yy(ii) = sum(xx((ii-1)*binsize+1:ii*binsize));
             yy(ii) = yy(ii) * (1000 / binsize);
         end
          
         xlim([1 no_bins+10]);
        % xticks(1:8:no_bins);
         xline(20,'g','LineWidth',1.5,'LineStyle','--'); % start of the strim
         xline(no_bins-16,'g','LineWidth',1.5,'LineStyle','--'); % end of the strim
 
         hold on;
        % title(['cell number ' num2str(i) ' stimulus number ' num2str(stim)]);
        title([ 'stimulus number ' num2str(stim)])
         plot(gaussmoth(yy,1),'k','LineWidth',1,'LineStyle','-');
          ylim([global_min_val global_max_val ]);

     
     end
   %  ylim([global_min_val global_max_val]);
     pause; % Pause to view each figure before continuing
 end