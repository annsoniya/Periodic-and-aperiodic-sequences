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

%%Choose the index separately and run the rest of the code
% inx = ASinx; % Uncomment for aperiodic selective set

%% choose the index and  code

% Exclude units with NaN or Inf in both arrays

inx = ASinx;

periodic=data_per_with(inx,: );
aperiodic=data_aper_with(inx,: );
[mean_allunits_periodic_P,mean_allunits_aperiodic_P]=meanplots_cumulative(periodic,aperiodic);
valid_indices = ~any(isnan(mean_allunits_periodic_P) | isinf(mean_allunits_periodic_P) | isnan(mean_allunits_aperiodic_P) | isinf(mean_allunits_aperiodic_P), 2);
inx=inx(valid_indices==1);
% Exclude units with NaN
mean_allunits_periodic_P = mean_allunits_periodic_P(valid_indices, :);
mean_allunits_aperiodic_P = mean_allunits_aperiodic_P(valid_indices, :);


% without gap
periodic=data_per_without(inx,: );
aperiodic=data_aper_without(inx,: );
[mean_allunits_periodic_N,mean_allunits_aperiodic_N]=meanplots_cumulative(periodic,aperiodic);
%remove NaNs or inf from this
mean_allunits_periodic_N = mean_allunits_periodic_N(~any(isnan(mean_allunits_periodic_N) | isinf(mean_allunits_periodic_N), 2), :);
mean_allunits_aperiodic_N = mean_allunits_aperiodic_N(~any(isnan(mean_allunits_aperiodic_N) | isinf(mean_allunits_aperiodic_N), 2), :);

%% mean rate plots
figure;
hold on;
m = max([max(mean_allunits_periodic_P), max(mean_allunits_aperiodic_P)]);
mmin = min([min(mean_allunits_periodic_P), min(mean_allunits_aperiodic_P)]);
% xlim([mmin m]);
ylim([mmin m]);
plot_mean_rates(mean_allunits_periodic_P,mean_allunits_aperiodic_P);
plot_mean_rates_without(mean_allunits_periodic_N,mean_allunits_aperiodic_N);

% fititng plots
x = [300, 600, 900, 1200, 1500, 1800, 2100, 2400, 2700, 3000, 3300, 3600];

x=450:450:3600;% for 120
x=600:600:3600;
x=900:900:3600;

x=x./1000;

close all;
fit_exponential_shift(mean(mean_allunits_periodic_P),x)
title('periodic')
fit_exponential_shift(mean(mean_allunits_aperiodic_P),x);

title('Aperiodic')

fit_exponential_shift(mean(mean_allunits_periodic_N),x)
title('periodic-without')

fit_exponential_shift(mean(mean_allunits_aperiodic_N),x);
title('Aperiodic-without')

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

%% common indx for generalisation

% Define the gaps
inx_ps_70120=intersect(with.(['periodic', num2str(70)]).index,with.(['periodic', num2str(120)]).index);
inx_ps_70170=intersect(with.(['periodic', num2str(70)]).index,with.(['periodic', num2str(170)]).index);
inx_ps_70270=intersect(with.(['periodic', num2str(70)]).index,with.(['periodic', num2str(270)]).index);

inx_ps_120170=intersect(with.(['periodic', num2str(120)]).index,with.(['periodic', num2str(170)]).index);
inx_ps_120270=intersect(with.(['periodic', num2str(120)]).index,with.(['periodic', num2str(270)]).index);

inx_ps_170270=intersect(with.(['periodic', num2str(170)]).index,with.(['periodic', num2str(270)]).index);

% AS intersecst
inx_as_70120=intersect(with.(['aperiodic', num2str(70)]).index,with.(['aperiodic', num2str(120)]).index);
inx_as_70170=intersect(with.(['aperiodic', num2str(70)]).index,with.(['aperiodic', num2str(170)]).index);
inx_as_70270=intersect(with.(['aperiodic', num2str(70)]).index,with.(['aperiodic', num2str(270)]).index);

inx_as_120170=intersect(with.(['aperiodic', num2str(120)]).index,with.(['aperiodic', num2str(170)]).index);
inx_as_120270=intersect(with.(['aperiodic', num2str(120)]).index,with.(['aperiodic', num2str(270)]).index);

inx_as_170270=intersect(with.(['aperiodic', num2str(170)]).index,with.(['aperiodic', num2str(270)]).index);

% common index for all

inx_ps_70120170=intersect(inx_ps_70120,with.(['periodic', num2str(170)]).index);
inx_ps_all=intersect(inx_ps_70120170,with.(['aperiodic', num2str(270)]).index);

% common for all AS
inx_as_70120170=intersect(inx_as_70120,with.(['aperiodic', num2str(170)]).index);
inx_as_all=intersect(inx_as_70120170,with.(['aperiodic', num2str(270)]).index);

%% %%
%
inx = inx_ps_all;
periodic=data_per_with(inx,: );
aperiodic=data_aper_with(inx,: );
[per,aper]=meanplots_cumulative(periodic,aperiodic);
cx1=per(:,l);
cy1=aper(:,l);
%% for aperiodic selective
%inx=inxp3p4_aper; % or
inx=inx_as_all;

periodic=data_per_with(inx,: );
aperiodic=data_aper_with(inx,: );
[per1,aper1]=meanplots_cumulative(periodic,aperiodic);
cx2=per1(:,l);
cy2=aper1(:,l);
%% go tho this for scatter and histogram
main_scatter_call()

