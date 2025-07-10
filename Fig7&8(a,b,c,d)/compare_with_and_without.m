function compare_with_and_without(x1, x2, x3, x4, y1, y2, y3, y4)

% Remove NaN and Inf values if sizes do not match
nanInfIdx_x1 = isnan(x1) | isinf(x1);
nanInfIdx_x3 = isnan(x3) | isinf(x3);
nanInfIdx = nanInfIdx_x1 | nanInfIdx_x3; % Combine NaN and Inf indices
x1(nanInfIdx) = [];
x3(nanInfIdx) = [];


nanInfIdx_y1 = isnan(y1) | isinf(y1);
nanInfIdx_y3 = isnan(y3) | isinf(y3);
nanInfIdx = nanInfIdx_y1 | nanInfIdx_y3; % Combine NaN and Inf indices
y1(nanInfIdx) = [];
y3(nanInfIdx) = [];


nanInfIdx_x2 = isnan(x2) | isinf(x2);
nanInfIdx_x4 = isnan(x4) | isinf(x4);
nanInfIdx = nanInfIdx_x2 | nanInfIdx_x4; % Combine NaN and Inf indices
x2(nanInfIdx) = [];
x4(nanInfIdx) = [];


nanInfIdx_y2 = isnan(y2) | isinf(y2);
nanInfIdx_y4 = isnan(y4) | isinf(y4);
nanInfIdx = nanInfIdx_y2 | nanInfIdx_y4; % Combine NaN and Inf indices
y2(nanInfIdx) = [];
y4(nanInfIdx) = [];


%% Call for comparison between with and without gap
% x1 vs x3 and y1 vs y3
% x2 vs x4 and y2 vs y4
[h.ps_per, p.ps_per] = ttest(x1, x3);
[h.ps_aper, p.ps_aper] = ttest(y1, y3);
[h.as_per, p.as_per] = ttest(x2, x4);
[h.as_aper, p.as_aper] = ttest(y2, y4);

%% Print h and p values
fprintf('ps -per, with and without gap: h = %d, p = %.6f\n', h.ps_per, p.ps_per);
fprintf('ps -aper, with and without gap: h = %d, p = %.6f\n', h.ps_aper, p.ps_aper);
fprintf('AS -per, with and without gap: h = %d, p = %.6f\n', h.as_per, p.as_per);
fprintf('AS -aper, with and without gap: h = %d, p = %.6f\n', h.as_aper, p.as_aper);

end