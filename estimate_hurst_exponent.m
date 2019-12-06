function [hurst] = estimate_hurst_exponent(data,no_iterations)

[~,npoints]=size(data);
yvals = zeros(1,no_iterations);
xvals = zeros(1,no_iterations);

k=1;
for i = 10:(npoints/no_iterations):npoints

original_signal= data(1:i);

signal_mean = sum(original_signal)/npoints;
X = original_signal - signal_mean;
Y = cumsum(X);

Rn = max(Y) - min(Y);
original_std = std(original_signal);

yvals(k) = log(Rn/original_std);
xvals(k) = log(i);
k = k+1;

end

p2=polyfit(xvals,yvals,1);
hurst=p2(1);                        % Hurst exponent is the slope of the linear fit of log-log plot

end