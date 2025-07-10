function [final_btsrp_per,final_btsrp_aper]= fn2_selectivity_per_aper_seperate(stimdata_per,stimdata_aper,width,period)
for kk=1:138
    for jj=1:size(stimdata_per,2)
        curpst=stimdata_per{kk,jj};
        for rr=1:5
            rcurpst(rr,:)=nanmean(reshape(curpst(rr,:),10,500));
        end
        allmrdata_per(kk,jj,:)=nanmean(rcurpst);% 306*16*500 (bins of 10 each)
    end
end
clear rcurpst curpst
for kk=1:138
    for jj=1:size(stimdata_aper,2)
        curpst=stimdata_aper{kk,jj};
        for rr=1:5
            rcurpst(rr,:)=nanmean(reshape(curpst(rr,:),10,500));
        end
        allmrdata_aper(kk,jj,:)=nanmean(rcurpst);% 306*16*500 (bins of 10 each)
    end
end
start=50;
stimend=410;
kk=50:width:410;
for p=1:length(kk)-1
    anal_bins{1,p}=[kk(p) kk(p+1)-1];
end

%% nw for all stim subtract prev from pred
for stim=1:size(allmrdata_per,2)
    for p=1:length(anal_bins)
        per_norm(:,stim,p)=squeeze(nanmean(allmrdata_per(:,stim,anal_bins{1,p}(1):anal_bins{1,p}(2)),3));
    end
end % MEaN OF ALL PERIODS of all periodic stimuli

for stim=1:size(allmrdata_aper,2)
    for p=1:length(anal_bins)
        %  aper_norm(:,stim,p)=squeeze(mean(allmrdata_aper(:,stim,pred1{1,p}(1):pred1{1,p}(2)),3))-squeeze(mean(allmrdata_aper(:,stim,prev1{1,p}(1):prev1{1,p}(2)),3));
        aper_norm(:,stim,p)=squeeze(nanmean(allmrdata_aper(:,stim,anal_bins{1,p}(1):anal_bins{1,p}(2)),3));
    end
end
per=squeeze(nanmean(per_norm,2));
aper=squeeze(nanmean(aper_norm,2));

% Assuming 'per' and 'aper' are defined and contain the data

% Perform bootstrapping and calculate confidence intervals for 'per'
[final_btsrp_per, lowerBound_per, upperBound_per] = bootstrap_chk(per);

% Perform bootstrapping and calculate confidence intervals for 'aper'
[final_btsrp_aper, lowerBound_aper, upperBound_aper] = bootstrap_chk(aper);

% Plotting the results
figure;

% Plot 'per' data
%plot(1:size(final_btsrp_per, 2), final_btsrp_per, 'g');
hold on;
% Mark CI as error bars for 'per'
errorbar(1:size(final_btsrp_per, 2), final_btsrp_per, lowerBound_per, upperBound_per, 'g');

% Plot 'aper' data
%plot(1:size(final_btsrp_aper, 2), final_btsrp_aper, 'r');
% Mark CI as error bars for 'aper'
errorbar(1:size(final_btsrp_aper, 2), final_btsrp_aper, lowerBound_aper, upperBound_aper, 'r');
legend( 'Periodic','Aperiodic');
hold off;

end

