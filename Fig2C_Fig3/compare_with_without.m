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


%% choose the x seperately and run rest of the code
inx = PSinx;
%%%
inx=ASinx;% for aperiodic selective set
%% now get the data wihtout and get indices form the with  structs
periodic=data_per_with(inx,: );
aperiodic=data_aper_with(inx,: );
[mean_allunits_periodic_P.with,mean_allunits_aperiodic_P.with]=meanplots_cumulative2(periodic,aperiodic);
periodic=data_per_without(inx,: );
aperiodic=data_aper_without(inx,: );
[mean_allunits_periodic_P.without,mean_allunits_aperiodic_P.without]=meanplots_cumulative2(periodic,aperiodic);
%% for scatter - this has final segment values
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
%%
compare_with_and_without(x1,x2,x3,x4,y1,y2,y3,y4); % comapre with and without
compare_with_PSAS(x1,y1,x2,y2,x3,y3,x4,y4);

