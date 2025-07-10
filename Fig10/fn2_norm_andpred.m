function final= fn2_norm_andpred(stimdata_per,stimdata_aper,width,period)
for kk=1:132
    for jj=1:size(stimdata_per,2)
        curpst=stimdata_per{kk,jj};
        for rr=1:5
            rcurpst(rr,:)=mean(reshape(curpst(rr,:),10,500));
        end
        allmrdata_per(kk,jj,:)=mean(rcurpst);% 136*16*500 (bins of 10 each)
    end
end
clear rcurpst curpst
for kk=1:132
    for jj=1:size(stimdata_aper,2)
        curpst=stimdata_aper{kk,jj};
        for rr=1:5
            rcurpst(rr,:)=mean(reshape(curpst(rr,:),10,500));
        end
        allmrdata_aper(kk,jj,:)=mean(rcurpst);% 136*16*500 (bins of 10 each)
    end
end
start=50;
stimend=410;
kk=50:width:410;
for p=1:length(kk)-1
    pred1{1,p}=[kk(p+1)-4 kk(p+1)];
    prev1{1,p}=[kk(p)+1 kk(p+1)-5];
end
%% 
% nw for all stim subtract prev from pred
for stim=1:size(allmrdata_per,2)
    for p=1:length(pred1)
        per_norm(:,stim,p)=squeeze(mean(allmrdata_per(:,stim,pred1{1,p}(1):pred1{1,p}(2)),3))-squeeze(mean(allmrdata_per(:,stim,prev1{1,p}(1):prev1{1,p}(2)),3));
    end
end
for stim=1:size(allmrdata_aper,2)
    for p=1:length(pred1)
        aper_norm(:,stim,p)=squeeze(mean(allmrdata_aper(:,stim,pred1{1,p}(1):pred1{1,p}(2)),3))-squeeze(mean(allmrdata_aper(:,stim,prev1{1,p}(1):prev1{1,p}(2)),3));
    end
end
per_aper=squeeze(mean(per_norm,2))-squeeze(mean(aper_norm,2));
for bs=1:500
    rind(bs,:)=fix(132*rand(1,132))+1;
    bpdnw=per_aper(rind(bs,:),:);
    for kk=1:132
        ppp(kk,bs,:)=polyfit(1:length(pred1),bpdnw(kk,:),1);% 132*500*2
    end
end
final = squeeze(mean(ppp,1));%500*2
end
