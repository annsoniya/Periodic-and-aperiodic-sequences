clear
clc
load('withoutgap_cum_perrand_gap_norm_avgtrials.mat');
without=cum_perrand_gap;
load('withgap_cum_perrand_gap_norm_avgtrials');
with=cum_perrand_gap;

%%
gaps=[70,120,170,270];

% Dynamically access the fields for the current gap
gap=gaps(4);


data_per_with = with.(['per_', num2str(gap)]);
data_aper_with = with.(['aper_', num2str(gap)]);

data_per_without = without.(['per_', num2str(gap)]);
data_aper_without = without.(['aper_', num2str(gap)]);

% Accessing the index fields
PSinx = with.(['periodic', num2str(gap)]).index;
ASinx = with.(['aperiodic', num2str(gap)]).index;

% Choose the index separately and run the rest of the code
inx = PSinx;

%%
inx = ASinx; % Uncomment for aperiodic selective set

%% choose the index and  code
periodic=data_per_with(inx,: );
aperiodic=data_aper_with(inx,: );
[mean_allunits_periodic_P,mean_allunits_aperiodic_P]=meanplots_cumulative2(periodic,aperiodic);

% without gap
periodic=data_per_without(inx,: );
aperiodic=data_aper_without(inx,: );
[mean_allunits_periodic_N,mean_allunits_aperiodic_N]=meanplots_cumulative2(periodic,aperiodic);
%%
%% for scatter
l=size(mean_allunits_periodic_P,2);
x1=mean_allunits_periodic_P(:,l);
y1=mean_allunits_aperiodic_P(:,l);
x3=mean_allunits_periodic_N(:,l);
y3=mean_allunits_aperiodic_N(:,l);

%% for AS
x2=mean_allunits_periodic_P(:,l);
y2=mean_allunits_aperiodic_P(:,l);

% AS- wihtoutgap
x4=mean_allunits_periodic_N(:,l);
y4=mean_allunits_aperiodic_N(:,l);

csi.gap170 = compare_with_PSAS(x1,y1,x2,y2,x3,y3,x4,y4);
%% aftter saving csi , we take
with_ps=[mean(csi.gap70.ps_with_b) mean(csi.gap120.ps_with_b  ) mean(csi.gap170.ps_with_b  ) mean(csi.gap270.ps_with_b  ) ];
with_as=[mean(csi.gap70.as_with_b) mean(csi.gap120.as_with_b  ) mean(csi.gap170.as_with_b  ) mean(csi.gap270.as_with_b  ) ];
without_ps=[mean(csi.gap70.ps_without_b) mean(csi.gap120.ps_without_b  ) mean(csi.gap170.ps_without_b  ) mean(csi.gap270.ps_without_b  ) ];
without_as=[mean(csi.gap70.as_without_b) mean(csi.gap120.as_without_b  ) mean(csi.gap170.as_without_b  ) mean(csi.gap270.as_without_b  ) ];
%%

%% %%%%%%%%%%%%%%%%
figure
subplot(2,2,1)
%plot([70,120,170,270],with_ps,'-o')
%confidence interval
hold on
errorbar([1:4],[mean(csi.gap70.ps_with_ci) mean(csi.gap120.ps_with_ci  ) mean(csi.gap170.ps_with_ci  ) mean(csi.gap270.ps_with_ci  ) ],[csi.gap70.ps_with_ci(2)-mean(csi.gap70.ps_with_ci) csi.gap120.ps_with_ci(2)-mean(csi.gap120.ps_with_ci) csi.gap170.ps_with_ci(2)-mean(csi.gap170.ps_with_ci) csi.gap270.ps_with_ci(2)-mean(csi.gap270.ps_with_ci) ],'r')
%slope and intercept
%sl_with_ps=polyfit([70,120,170,270],with_ps,1);
sl_with_ps=polyfit(1:4,with_ps,1);
disp(sl_with_ps)
%plotfit
plot([1:4],polyval(sl_with_ps,1:4),'b')
%plot([70,120,170,270],[mean(csi.gap70.ps_with_ci) mean(csi.gap120.ps_with_ci  ) mean(csi.gap170.ps_with_ci  ) mean(csi.gap270.ps_with_ci  ) ],'r')
title('PS neurons with gap and without gap CSi across all gaps')
%plot([70,120,170,270],without_ps,'-o')
%confidence interval
hold on
errorbar([1:4],[mean(csi.gap70.ps_without_ci) mean(csi.gap120.ps_without_ci  ) mean(csi.gap170.ps_without_ci  ) mean(csi.gap270.ps_without_ci  ) ],[csi.gap70.ps_without_ci(2)-mean(csi.gap70.ps_without_ci) csi.gap120.ps_without_ci(2)-mean(csi.gap120.ps_without_ci) csi.gap170.ps_without_ci(2)-mean(csi.gap170.ps_without_ci) csi.gap270.ps_without_ci(2)-mean(csi.gap270.ps_without_ci) ],'r')
sl_without_ps=polyfit(1:4,without_ps,1);
disp(sl_without_ps)
plot(1:4,polyval(sl_without_ps,1:4),'b')
legend('with gap','without gap','slope_with','slope_without')
xticks([70,120,170,270])

subplot(2,2,2)
%plot([70,120,170,270],with_as,'-o')
%confidence interval
hold on
errorbar([1:4],[mean(csi.gap70.as_with_ci) mean(csi.gap120.as_with_ci  ) mean(csi.gap170.as_with_ci  ) mean(csi.gap270.as_with_ci  ) ],[csi.gap70.as_with_ci(2)-mean(csi.gap70.as_with_ci) csi.gap120.as_with_ci(2)-mean(csi.gap120.as_with_ci) csi.gap170.as_with_ci(2)-mean(csi.gap170.as_with_ci) csi.gap270.as_with_ci(2)-mean(csi.gap270.as_with_ci) ],'r')
sl_with_as=polyfit(1:4,with_as,1);
disp(sl_with_as)
plot(1:4,polyval(sl_with_as,1:4),'b')
title('AS neurons with gap and without gap CSi across all gaps')
%plot([70,120,170,270],without_as,'-o')
%confidence interval
hold on
errorbar([1:4],[mean(csi.gap70.as_without_ci) mean(csi.gap120.as_without_ci  ) mean(csi.gap170.as_without_ci  ) mean(csi.gap270.as_without_ci  ) ],[csi.gap70.as_without_ci(2)-mean(csi.gap70.as_without_ci) csi.gap120.as_without_ci(2)-mean(csi.gap120.as_without_ci) csi.gap170.as_without_ci(2)-mean(csi.gap170.as_without_ci) csi.gap270.as_without_ci(2)-mean(csi.gap270.as_without_ci) ],'r')
sl_without_as=polyfit(1:4,without_as,1);
disp(sl_without_as)
plot(1:4,polyval(sl_without_as,1:4),'b')

legend('with gap','without gap')
xticks([70,120,170,270])
%calculate teh slopes and intercept for each plot and display it
