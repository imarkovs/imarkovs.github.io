% MISFIT - misfit computation using image representation (SISO case)

function [m,wh] = misfit(w,sys)

T = size(w,1); wt = w';

% Find an image representation
[q,p] = tfdata(tf(sys),'v'); lp = length(p);
Pf = [p; [q zeros(lp-length(q))]]; P = fliplr(Pf);

% Construct the Toeplitz matrix and solve the LS problem (5)
M  = blktoep([zeros(2,T-1) P zeros(2,T-1)]',T); 
wh = reshape(M*(M\wt(:)),2,T)'; % solve (5)
m  = norm(w-wh,'fro');