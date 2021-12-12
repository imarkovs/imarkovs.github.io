function [a,c] = comp(p)

p = p/p(1); 
p = p(2:end);
n = length(p);

a = zeros(n);
a(1,:) = -p;
a(2:end,1:end-1) = eye(n-1);
c = -p;