
function scatterplot(x, y, color, marker)
x=x(~isinf(x));
y=y(~isinf(y));
    scatter(x, y, 'MarkerEdgeColor', color, 'MarkerFaceColor', color, 'Marker', marker);
     % Keep the scatter plot

    % Perform t-test
    [h, p, ci, stats] = ttest(x, y);

    % Display t-statistic and p-value
    t_stat = stats.tstat;
    df = stats.df;

%     % Fit linear regression model
%     mdl = fitlm(x, y);
% %     slope = mdl.Coefficients.Estimate(2);
%     intercept = mdl.Coefficients.Estimate(1);

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

    % Display the t-statistic, p-value, slope, and intercept on the plot
  %  text(min(x), max(y), sprintf('t(%d) = %.3f,%s\nActual p = %.4f', df, t_stat, p_str, p), 'FontSize', 12, 'Color', color);
    text(min(x), max(y), sprintf('%s t(%d) = %.3f,%s\nActual p = %.4f', marker, df, t_stat, p_str, p), 'FontSize', 12, 'Color', color, 'Interpreter', 'latex');

end