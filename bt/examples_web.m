clc, echo on

%% Finding the number of inputs

q = 3; m = 1; ell = 2; n = 3; Td = 20;

Rp = randB(q, [m, ell, n]);

wd = R2w(Rp, q, Td);

[~, mh, ellh, nh] = w2c(wd);

[m == mh, ell == ellh, n == nh] % -> [true true true]

pause

%% Finding an input/output partitioning of the variables

T = 2 * ell + 1; BT = w2BT(wd, T, [m ell n]);

IO = BT2IO(BT, q)

ud = wd(:, IO(1, 1:m)); yd = wd(:, IO(:, m+1:end));

pause

%% The data-generating system may be unstable (but it's OK)

any(abs(eig(B)) > 1) % -> true

T = 300; 
u = rand(T, m); y = lsim(B, u, [], rand(n, 1)); 
w = [u y]; max(w(:)) % -> large

BT = R2BT(Rp, q, T); w = BT * rand(size(BT, 2), 1); max(w) % -> small

pause

%% Distance of a signal to a system

dist(wd, B) % -> 0

wn = randn(size(wd)); wd_noisy = wd + 0.1 * norm(wd) * wn / norm(wd);

100 * [norm(wd - wd_noisy) norm(wd - wdh)] / norm(wd)

pause

%% Distance between systems

Bp = ss2ss(B, rand(n));

try 
    B == Bp % -> Operator '==' is not supported for operands of type 'ss'.
catch me
    me
end

norm(Bp - B)

Bdist(Bp, B) % -> 0

echo off
