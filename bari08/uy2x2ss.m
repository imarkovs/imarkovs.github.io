% UY2X2SS - From time series W to an I/S/O representation of the MPUM.
%           LMAX is an upper bound for the system lag.
%
% [sys,a,b,c,d] = uy2x2ss(u,y,lmax)

function [sys,a,b,c,d] = uy2x2ss(u,y,lmax)

m = size(u,2); p = size(y,2);
tol = 1e-8; % tolerance for numerical rank computation

% (u,y) -> y0
U  = blkhank(u,2*lmax);
Up = U(1:lmax*m,:);
Uf = U(1+lmax*m:end,:);
Y  = blkhank(y,2*lmax);
Yp = Y(1:lmax*p,:);
Yf = Y(1+lmax*p:end,:);
Y0 = Yf * pinv([Up;Yp;Uf]) * [Up;Yp;zeros(size(Uf))]; 

% y0 -> x
[U,S,V] = svd(Y0,0);
n = sum(diag(S) > tol); % order selection from the singular values of Y0
x = V(:,1:n)';

% (u,y,x) -> (a,b,c,d)
j  = size(x,2) - 1;
M = [x(:,2:end); y(lmax+1:lmax+j,:)'] / [x(:,1:end-1); u(lmax+1:lmax+j,:)'];
a = M(1:n,1:n);     b = M(1:n,n+1:end);
c = M(n+1:end,1:n); d = M(n+1:end,n+1:end);
sys = ss(a,b,c,d,-1);