
function scatterplot(x, y, color, marker)
x=x(~isinf(x));
y=y(~isinf(y));
scatter(x, y, 'MarkerEdgeColor', color, 'MarkerFaceColor', color, 'Marker', marker);
[h, p, ci, stats] = ttest(x, y);

t_stat = stats.tstat;
df = stats.df;

% Determine p-value string based on thresholds
if (p < 0.0001)
    p_str = 'p < 10^{-4}';
elseif (p < 0.001)
    p_str = 'p < 0.001';
elseif (p < 0.01)
    p_str = 'p < 0.01';
else
    p_str = sprintf('p = %.4f', p);
end
text(min(x), max(y), sprintf('%s t(%d) = %.3f,%s\nActual p = %.4f', marker, df, t_stat, p_str, p), 'FontSize', 12, 'Color', color, 'Interpreter', 'latex');
end