% GTLS - Global total least squares
%        (SISO case only)

function [sys,m] = gtls(w,l,sys)

% Initial approximation
if nargin < 3
  [U,S,V] = svd(blkhank(w,l+1),0);
  r0 = U(:,end)'; % [q -p]
  r0 = r0 / r0(end);
else
  [q,p] = tfdata(tf(sys),'v');
  q = fliplr([q zeros(length(p)-length(q))]); p = fliplr(p);
  r0 = zeros(1,length(p)*2); 
  r0(1:2:end) = q; r0(2:2:end) = -p;
end

% Misfit minimization
opt = optimset('maxiter',1000,'disp','off');
[r,m] = fminsearch(@(r) misfit_r(w,r)',r0,opt);
q = fliplr(r(1:2:end));
p = -fliplr(r(2:2:end));
sys = tf(q,p,-1);