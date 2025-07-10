load('dataSignificant_perrand_gap.mat')
for kk=1:306
    for jj=1:16
        curpst=dataSignificant_perrand_gap{kk,jj};
        for rr=1:5
            rcurpst(rr,:)=mean(reshape(curpst(rr,:),10,500));
        end
        allrdata(kk,jj,:,:)=rcurpst;
        allmrdata(kk,jj,:)=mean(rcurpst);
    end
end


%%%
start=50;
stimend=410;
width=[30,45,60,90];
%declare
prev_bins=cell(16,12);
pred_bins=cell(16,12);
for q=1:4
    kk=50:width(q):410;
    for p=1:length(kk)-1
        pred1{q,p}=[kk(p+1)-4 kk(p+1)];
        prev1{q,p}=[kk(p)+1 kk(p+1)-5]
    end
end

for q=1:4
    for jj=(q-1)*4+1:(q-1)*4+4
        pred_bins(jj,1:size(pred1,2))=pred1(q,:);%
        prev_bins(jj,1:size(prev1,2))=prev1(q,:);%
    end
end

%%%
npers=[12 8 6 4];
for jj=1:16
    gp=fix(jj/4)+1;
    if rem(jj,4)==0
        gp=gp-1;
    end
    perjj=npers(gp);
    for kk=1:perjj
        nrwvals{jj,kk}=squeeze(mean(allmrdata(:,jj,pred_bins{jj,kk}(1):pred_bins{jj,kk}(2)),3))-(squeeze(mean(allmrdata(:,jj,prev_bins{jj,kk}(1):prev_bins{jj,kk}(2)),3)));
    end
end

npredwvals=NaN*ones(306,16,12);
for jj=1:16
    gp=fix(jj/4)+1;
    if rem(jj,4)==0
        gp=gp-1;
    end
    perjj=npers(gp);
    for kk=1:perjj
        npredwvals(:,jj,kk)=nrwvals{jj,kk};
    end
end

clear kk;
for jj=1:4
    pdnwrv2(jj,:,:)=(squeeze(npredwvals(:,4*jj-1,:)))-(squeeze(npredwvals(:,4*jj,:))); % stim3 and 4
    pdnwrv1(jj,:,:)=(squeeze(npredwvals(:,4*jj-3,:)))-(squeeze(npredwvals(:,4*jj-2,:)));% stim 1 & 2
end
for jj=1:4
    subplot(4,1,jj),plot(mean(squeeze(pdnwrv2(jj,:,:)+pdnwrv1(jj,:,:))))
end

%%%%%%%%%%%%% randomised %%%%%%%%%%%%%%%%%
for bs=1:500
    rind(bs,:)=fix(306*rand(1,306))+1;

    bpdnw=pdnwrv1(:,rind(bs,:),:)+pdnwrv2(:,rind(bs,:),:); % 4*306*12
    for kk=1:306
        for jj=1:4
            ppp(jj,kk,bs,:)=polyfit(1:npers(jj),squeeze(bpdnw(jj,kk,1:npers(jj)))',1); % 4*306*500*2
        end
    end
end
%% ppp has randoimised coefficients
popp=squeeze(mean(ppp,2)); % across all neurons 4*500*2 extractn gteh intercept - pop level
slopes = squeeze(popp(:,:,1)); % Slopes, dimensions [4, 500]
intercepts = squeeze(popp(:,:,2)); % Intercepts, dimensions [4, 500]
% Create boxplots
figure;
% Boxplot for slopes
subplot(2, 1, 1);
boxplot(slopes', 'Labels', {'70', '120', '170', '270'});
title('Boxplot of Slopes');
xlabel('Groups');
ylabel('Slope');

% Boxplot for intercepts
subplot(2, 1, 2);
boxplot(intercepts', 'Labels', {'70', '120', '170', '270'});
title('Boxplot of Intercepts');
xlabel('Groups');
ylabel('Intercept');