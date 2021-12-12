% INISTATE - compute initial state for a trajectory

function [xini,res] = inistate(u,y,sys)

% Define constants
[p,m] = size(sys); n = size(sys,'order'); T = size(u,1);

% Compute the extended observability matrix
O = zeros(T*p,n);
O(1:p,:) = sys.c;
for t = 2:T
  O((t-1)*p+1:t*p,:) = O((t-2)*p+1:(t-1)*p,:)*sys.a;
end

% Compute initial consitions
xini = zeros(n,1);
y0   = y - lsim(sys,u);
xini = O \ y0;
res  = norm(y0 - O*xini);