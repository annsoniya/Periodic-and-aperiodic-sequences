clear
clc
load('withoutgap_cum_perrand_gap_norm_avgtrials.mat');
without=cum_perrand_gap;
load('withgap_cum_perrand_gap_norm_avgtrials');
with=cum_perrand_gap;

%%
gaps=[70,120,170,270];
% Dynamically access the fields for the current gap
gap=gaps(3);
data_per_with = with.(['per_', num2str(gap)]);
data_aper_with = with.(['aper_', num2str(gap)]);

data_per_without = without.(['per_', num2str(gap)]);
data_aper_without = without.(['aper_', num2str(gap)]);

% Accessing the index fields
PSinx = with.(['periodic', num2str(gap)]).index;
ASinx = with.(['aperiodic', num2str(gap)]).index;

% Choose the index separately and run the rest of the code
inx = PSinx;
%
% inx = ASinx; % Uncomment for aperiodic selective set

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
% AS- withoutgap
x4=mean_allunits_periodic_N(:,l);
y4=mean_allunits_aperiodic_N(:,l);

%%
compare_with_and_without(x1,x2,x3,x4,y1,y2,y3,y4);

compare_with_PSAS(x1,y1,x2,y2,x3,y3,x4,y4)
