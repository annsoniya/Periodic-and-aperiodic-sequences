% load

clear
clc

without=load('withoutgap_cum_analysis.mat');
with=load('withgap_cum_analysis_normaliseddata.mat');

%% for periodicity =4 / choose each sepecrately and run rest of teh codes
suffix = '_3_';
suffix = '_3_2f1f2_';
suffix = '_3_2f2f1_';
suffix = '_4_';

%% Accessing the data fields
data_per_with = with.cum_analysis.(sprintf('cum_per%speriodicData', suffix));
data_aper_with = with.cum_analysis.(sprintf('cum_per%sAperiodicData', suffix));

data_per_without = without.cum_analysis.(sprintf('cum_per%speriodicData', suffix));
data_aper_without = without.cum_analysis.(sprintf('cum_per%sAperiodicData', suffix));

% Accessing the index fields
periodicField = sprintf('cum_per%speriodic', suffix);
aperiodicField = sprintf('cum_per%sAperiodic', suffix);

PSinx = with.cum_analysis.(periodicField).index;
ASinx = with.cum_analysis.(aperiodicField).index;


%% choose the  inx sepertae;y adn run rest fo teh code based on the index
inx = PSinx;
inx=ASinx;% for aperiodic slective set
%% now get teh dat afrom wihtoiut and get teh indices form teh with  structs
periodic=data_per_with(inx,: );
aperiodic=data_aper_with(inx,: );
[mean_allunits_periodic_P.with,mean_allunits_aperiodic_P.with]=meanplots_cumulative(periodic,aperiodic);
periodic=data_per_without(inx,: );
aperiodic=data_aper_without(inx,: );
[mean_allunits_periodic_P.without,mean_allunits_aperiodic_P.without]=meanplots_cumulative(periodic,aperiodic);
%% mean rate plots
figure;
hold on;
m = max([max(mean_allunits_periodic_P.with), max(mean_allunits_aperiodic_P.with)]);
mmin = min([min(mean_allunits_periodic_P.with), min(mean_allunits_aperiodic_P.with)]);
% xlim([mmin m]);
ylim([mmin m]);
plot_mean_rates(mean_allunits_periodic_P.with,mean_allunits_aperiodic_P.with);
plot_mean_rates_without(mean_allunits_periodic_P.without,mean_allunits_aperiodic_P.without);

%% fititng plots
% x=300:300:3600
x=400:400:3600;
x=x./1000;

fit_exponential_shift(mean(mean_allunits_periodic_P.with),x)
title('periodic')

fit_exponential_shift(mean(mean_allunits_aperiodic_P.with),x);
title('Aperiodic')
fit_exponential_shift(mean(mean_allunits_periodic_P.without),x)
title('periodic-without')
fit_exponential_shift(mean(mean_allunits_aperiodic_P.without),x);
title('Aperiodic-without')

%% for scatter
l=size(mean_allunits_periodic_P.with,2);
x1=mean_allunits_periodic_P.with(:,l);
y1=mean_allunits_aperiodic_P.with(:,l);
x3=mean_allunits_periodic_P.without(:,l);
y3=mean_allunits_aperiodic_P.without(:,l);


%% for AS
x2=mean_allunits_periodic_P.with(:,l);
y2=mean_allunits_aperiodic_P.with(:,l);

% AS- wihtoutgap
x4=mean_allunits_periodic_P.without(:,l);
y4=mean_allunits_aperiodic_P.without(:,l);

%% common indx for generalisation
inxp3p4_per=intersect(with.cum_analysis.cum_per_3_periodic.index,with.cum_analysis.cum_per_4_periodic.index  );
inxp3p4_aper=intersect(without.cum_analysis.cum_per_3_Aperiodic.index ,with.cum_analysis.cum_per_4_Aperiodic.index);


inxp3_sub_per=intersect(with.cum_analysis.cum_per_3_2f2f1_periodic.index,with.cum_analysis.cum_per_3_2f1f2_periodic.index  );
inxp3_sub_aper=intersect(with.cum_analysis.cum_per_3_2f2f1_Aperiodic.index,with.cum_analysis.cum_per_3_2f1f2_Aperiodic.index  );

%for periodic selective neurons
%inx=inxp3p4_per; % or

%
inx = inxp3_sub_per;
periodic=data_per_with(inx,: );
aperiodic=data_aper_with(inx,: );
[per,aper]=meanplots_cumulative(periodic,aperiodic);
cx1=per(:,l);
cy1=aper(:,l);


%% for aperiodic selective neurons
%inx=inxp3p4_aper; % or

inx=inxp3_sub_aper;

periodic=data_per_with(inx,: );
aperiodic=data_aper_with(inx,: );
[per1,aper1]=meanplots_cumulative(periodic,aperiodic);
cx2=per1(:,l);
cy2=aper1(:,l);
%% scatter function call
main_scatter_call()

