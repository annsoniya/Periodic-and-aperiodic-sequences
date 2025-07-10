function fit_exponential_shift(y,x)
% Assuming x values are indices
%  x = 1:length(y);
V=y(end);
delta=0.01;
a=(1 -(V + delta));
c= V + delta;

% Define the exponential function
f = fittype('a*exp(-b*x) +c', 'independent', 'x', 'dependent', 'y');

% Define the options for the fit
opts = fitoptions(f);
opts.StartPoint = [V delta 0.1];  % Initial guesses for V, delta, and b
opts.Lower = [-Inf, 0, 0];  % b ? 0, c ? 0
opts.Upper = [Inf, Inf, 1]; % c ? 1


% Fit the function to the data

[fit1, gof1] = fit(x', y', f, opts);
%[fit2, gof2] = fit(x', y2', f, opts);
r21 = gof1.rsquare;
% r22 = gof2.rsquare;
coeffs1 = coeffvalues(fit1);

a1 = coeffs1(1);
b1 = coeffs1(2);
c1 = coeffs1(3);

% Plot the original data and the fit
figure;
plot(x, y, 'o');
hold on;
plot(fit1);
legend('Data', ['Fit: y = ' num2str(a1) 'e^{(' num2str(-b1) 'x)} + ' num2str(c1) ' R^2 = ' num2str(r21)]);
hold off;
end
