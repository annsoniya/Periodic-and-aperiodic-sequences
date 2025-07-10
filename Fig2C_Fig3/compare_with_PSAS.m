function compare_with_PSAS(x1,y1,x2,y2,x3,y3,x4,y4)

% Remove NaN and Inf values if sizes do not match
nanInfIdx_x1 = isnan(x1) | isinf(x1);
nanInfIdx_y1 = isnan(y1) | isinf(y1);
nanInfIdx = nanInfIdx_x1 | nanInfIdx_y1; % Combine NaN and Inf indices
x1(nanInfIdx) = [];
y1(nanInfIdx) = [];


nanInfIdx_x2 = isnan(x2) | isinf(x2);
nanInfIdx_y2 = isnan(y2) | isinf(y2);
nanInfIdx = nanInfIdx_x2 | nanInfIdx_y2; % Combine NaN and Inf indices
x2(nanInfIdx) = [];
y2(nanInfIdx) = [];

nanInfIdx_x3 = isnan(x3) | isinf(x3);
nanInfIdx_y3 = isnan(y3) | isinf(y3);
nanInfIdx = nanInfIdx_x3 | nanInfIdx_y3; % Combine NaN and Inf indices
x3(nanInfIdx) = [];
y3(nanInfIdx) = [];


nanInfIdx_x4 = isnan(x4) | isinf(x4);
nanInfIdx_y4 = isnan(y4) | isinf(y4);
nanInfIdx = nanInfIdx_x4 | nanInfIdx_y4; % Combine NaN and Inf indices
x4(nanInfIdx) = [];
y4(nanInfIdx) = [];


%% Call for comparison between with and without gap
% x1 vs x3 and y1 vs y3
% x2 vs x4 and y2 vs y4
[h.ps_per, p.ps_per] = ttest(x1, y1);
[h.ps_aper, p.ps_aper] = ttest(x2, y2);
[h.as_per, p.as_per] = ttest(x3, y3);
[h.as_aper, p.as_aper] = ttest(x4, y4);

%% Print h and p values
fprintf('PS set, periodic vs aperiodic with gap : h = %d, p = %.6f\n', h.ps_per, p.ps_per);
fprintf('AS set, periodic vs aperiodic with gap: h = %d, p = %.6f\n', h.ps_aper, p.ps_aper);
fprintf('PS set, periodic vs aperiodic without gap: h = %d, p = %.6f\n', h.as_per, p.as_per);
fprintf('AS set, periodic vs aperiodic without gap: h = %d, p = %.6f\n', h.as_aper, p.as_aper);

end