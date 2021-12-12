% Polynomial approach

function yf = pol_predict(yp,p,Tf)

T = length(yp);
L = length(p) - 1;

y = yp;
for i = 1:Tf
  y(T+i) = - fliplr(p(2:end)) * y(T+i-L:T+i-1);
end
yf = y(T+1:end);
