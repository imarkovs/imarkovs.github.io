function yf = ma_filter(y, n);
b  = ones(1, n) / n; a = 1;      % filter's numerator and denominator's coefficients
y  = [y(1) * ones(n - 1, 1); y]; % extend the signal with the initial conditions  
yf = filter(b, a, y); 
yf = yf(n:end);                  % remove the first n-1 values  
