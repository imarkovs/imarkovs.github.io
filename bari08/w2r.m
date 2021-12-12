% W2R - From time series W to a kernel representation R of the MPUM.
%       SISO systems only. LMAX is an upper bound for the system lag.
%
% [sysh,r] = w2r(w,lmax)

function [sysh,r] = w2r(w,lmax)

% Determine the order = lag (in the SISO case)
tol = 1e-8; % tolerance for numerical rank computation
l = rank(blkhank(w,lmax+1),tol) - lmax - 1;

% Left kernel of the Hankel matrix with L+1 block rows
[U,S,V] = svd(blkhank(w,l+1),0); 
r = U(:,end)';

sysh = tf(fliplr(r(1:2:end)),-fliplr(r(2:2:end)),-1);