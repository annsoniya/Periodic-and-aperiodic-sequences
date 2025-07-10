function [final,final_btsrp]= fn2_selectivity(stimdata_per,stimdata_aper,width,period)

for kk=1:size(stimdata_per,1)
    for jj=1:size(stimdata_per,2)
        curpst=stimdata_per{kk,jj};
        for rr=1:5
            rcurpst(rr,:)=nanmean(reshape(curpst(rr,:),10,500));
        end
        allmrdata_per(kk,jj,:)=nanmean(rcurpst);% 306*16*500 (bins of 10 each)
    end
end
clear rcurpst curpst
for kk=1:size(stimdata_aper,1)
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
        aper_norm(:,stim,p)=squeeze(nanmean(allmrdata_aper(:,stim,anal_bins{1,p}(1):anal_bins{1,p}(2)),3));
    end
end
per_aper=squeeze(nanmean(per_norm,2))-squeeze(nanmean(aper_norm,2));
per_aper2=squeeze(nanmean(per_norm,2))+squeeze(nanmean(aper_norm,2));
sel=per_aper./per_aper2;
final=sel;
final_btsrp=bootstrap_chk(final);
%plot per and aperiodic seperate

end

