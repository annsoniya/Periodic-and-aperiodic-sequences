function scatterplot_fit(x, y)

    figure;
    subplot()
    scatter(x, y, 'filled');
    hold on; % Keep the scatter plot
%    xlabel('periodic');
 %   ylabel('aperiodic');
 

    % Plot the line y = x
m=max(max(x),max(y));
mmin=min(min(x),min(y));
x_fit = linspace(mmin, m, 100);
    y_fit = x_fit; % y = x
    plot(x_fit, y_fit, '-r', 'LineWidth', 2);

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
    text(min(x), max(y), sprintf('t(%d) = %.3f, %s\nSlope = %.3f\nIntercept = %.3f\nActual p = %.8f', df, t_stat, p_str, slope, intercept, p), 'FontSize', 12, 'Color', 'b');

    % Set the same limits for x and y axes
    axis_limits = [min([x; y]), max([x; y])];
    xlim(axis_limits);
    ylim(axis_limits);
    axis image;
% 
%     % Display results in command window
%     disp(['t(', num2str(df), ') = ', num2str(t_stat), ', ', p_str]);
%     disp(['Slope: ', num2str(slope)]);
%     disp(['Intercept: ', num2str(intercept)]);
%     disp(['Actual p-value: ', num2str(p)]);

    hold off; % Release the plot

end