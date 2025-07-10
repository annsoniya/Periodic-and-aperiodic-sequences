
clear
clc
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
start=50;
stimend=410;
width=[30,45,60,90];%for every previous token to period onl;y
width=width./3;%
prev_bins=cell(16,12);
pred_bins=cell(16,12);
for q=1:4
    kk=50:width(q):410;
    for p=1:length(kk)-1
        pred1{q,p}=[kk(p+1)-5 kk(p+1)];% 50ms before
        prev1{q,p}=[kk(p) kk(p+1)-5];
    end
end
% fro seeing tokens before the  for period only
for q=1:4
    for jj=(q-1)*4+1:(q-1)*4+4
        pred_bins(jj,1:size(pred1,2))=pred1(q,:);% 40 ms before every period
        prev_bins(jj,1:size(prev1,2))=prev1(q,:);% from start of periodi till 40ms previous
    end
end
% %% for checking each token trend
b=1:3:36;
npred1=cell(4,length(b));
nprev1=cell(4,length(b));
for yy=1:4%
    for inv=1:length(b)
        d=b(inv);
        npred1{yy,inv}=pred1{yy,d};
        nprev1{yy,inv}=prev1{yy,d};
    end
end
for q=1:4
    for jj=(q-1)*4+1:(q-1)*4+4
        pred_bins(jj,1:size(npred1,2))=npred1(q,:);%
        prev_bins(jj,1:size(nprev1,2))=nprev1(q,:);%
    end
end
npers=[12 8 6 4];
for jj=1:16
    gp=fix(jj/4)+1;
    if rem(jj,4)==0
        gp=gp-1;
    end
    perjj=npers(gp);
    for kk=1:perjj
        nrwvals{jj,kk}=squeeze(mean(allmrdata(:,jj,pred_bins{jj,kk}(1):pred_bins{jj,kk}(2)),3));
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
%%
clear kk;
for jj=1:4
    pdnwrv2(jj,:,:)=(squeeze(npredwvals(:,4*jj-1,:)))-(squeeze(npredwvals(:,4*jj,:))); % stim3 and 4= f2-2f1
    pdnwrv1(jj,:,:)=(squeeze(npredwvals(:,4*jj-3,:)))-(squeeze(npredwvals(:,4*jj-2,:)));% stim 1 & 2= f1-2f2
end

%% adding two conditions of f1 and f2
for jj=1:4
    subplot(4,1,jj),plot(mean(squeeze(pdnwrv2(jj,:,:)+pdnwrv1(jj,:,:)))) % this shud be teh values fed to newdata according to teh gap
end
%% Run this seg for three cases of stimuli combination
clc
for jj = 1:4
    subplot(4, 1, jj);
    data = squeeze(pdnwrv2(jj, :, :) + pdnwrv1(jj, :, :)); %for combined
    nanCols = any(isnan(data), 1);
    meanData = mean(data(:, ~nanCols), 1);
    semData = std(data(:, ~nanCols), 0, 1) / sqrt(size(data, 1));
    x = 1:length(meanData);
    p = polyfit(x, meanData, 1);
    fitted_data = polyval(p,x);
    disp(p)
    hold on;
    plot(x, meanData, 'b', 'LineWidth', 1.5);

    fill([x, fliplr(x)], [meanData + semData, fliplr(meanData - semData)], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    plot(x, fitted_data, 'r--', 'LineWidth', 1.5); % Plot the fitted curve

end

%% %%%%%%%%%%% randomised %%%%%%%%%%%%%%%%%choose stim set here also
for bs=1:500
    rind(bs,:)=fix(306*rand(1,306))+1;

    bpdnw=pdnwrv1(:,rind(bs,:),:)+pdnwrv2(:,rind(bs,:),:); % 4*306*12
    =    for kk=1:306
        for jj=1:4
            ppp(jj,kk,bs,:)=polyfit(1:npers(jj),squeeze(bpdnw(jj,kk,1:npers(jj)))',1); % 4*306*500*2
        end
    end
end
=popp=squeeze(mean(ppp,2)); % across all neurons 4*500*2 extractn gteh intercept - pop level
slopes = squeeze(popp(:,:,1)); % Slopes, dimensions [4, 500]
intercepts = squeeze(popp(:,:,2)); % Intercepts, dimensions [4, 500]
figure;
subplot(2, 1, 1);
boxplot(slopes', 'Labels', {'70', '120', '170', '270'}, 'Notch', 'on');
title('Boxplot of Slopes');
xlabel('Groups');
ylabel('Slope');

subplot(2, 1, 2);
boxplot(intercepts', 'Labels', {'70', '120', '170', '270'}, 'Notch', 'on');
title('Boxplot of Intercepts');
xlabel('Groups');
ylabel('Intercept');


