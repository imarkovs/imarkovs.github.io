% MISFIT - misfit computation using an image representation (SISO case)

function [m,wh] = misfit(w,sys)

T = size(w,1);

% Find an image representation
[q,p] = tfdata(tf(sys),'v'); lp = length(p); l = lp - 1;
Pf    = [p; [q zeros(lp-length(q))]];
P     = fliplr(Pf);
Pv    = Pf(:)';

% A = blktoep([zeros(2,T-1) P zeros(2,T-1)]',T); wt = w'; r_ = A'*wt(:);
Xp = blktoep([zeros(2,l-1) P(:,1:l)]',l)';   % past induced state map
Xf = blktoep([P(:,2:l+1) zeros(2,l-1)]',l)'; % future induced state map

wi = w(1:l,:)';
ri = Xp * wi(:); 

wf = w(end-lp+2:end,:)';
rf = Xf * wf(:); 

rm = Pv * blkhank(w,lp);
r  = [ri; rm'; rf]; % norm(r-r_)

% Construct F - the upper band of A
F11 = Xp*Xp';
F23 = Xp*Xf';
F33 = Xf*Xf';
F233 = [F23; F33];
fm = flipud(corr(P)');
F = zeros(lp,T+l);
F(:,lp:T)  = fm(:,ones(1,T-l));
for i = 0:l-1
  F(lp-i,i+1:l) = diag(F11,i)';
  F(:,T+i+1) = F233(i+1:i+lp,i+1);
end
yr = zpbsv(F,r);
wh = reshape(P * blkhank(yr,lp),2,T)';
m  = norm(w-wh,'fro');

function f = corr(P)

lp = size(P,2);
f  = zeros(1,lp);
for i = 1:lp
  Pi1 = P(:,i:lp);
  Pi2 = P(:,1:lp-i+1);
  f(i) = Pi1(:)' * Pi2(:);
end


