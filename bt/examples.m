q = 3; m = 1; ell = 2; n = 3; Td = 20;

B = randB(q, [m, ell, n]);

wd = ss2w(B, Td);

[~, mh, ellh, nh] = w2c(wd);

[m == mh, ell == ellh, n == nh] % -> [true true true]

T = 2 * ell + 1; BT = w2BT(wd, T, [m ell n]);

IO = BT2IO(BT, q)

ud = wd(:, IO(1, 1:m)); yd = ud = wd(:, IO(:, m+1:end));

[B, R] = randB(q, [m, ell, n]); any(abs(eig(B)) > 1) % -> true

T = 300; w = ss2w(B, T); max(w(:)) % -> large

BT = B2BT(B, T); w = BT * rand(size(BT, 2), 1); max(w) % -> small

dist(wd, B) % -> 0

wd_noisy = wd + randn(size(wd)); [d, wdh] = dist(wd_noisy, B);

[norm(wd - wdh) norm(wd - wd_noisy)] / norm(wd)

Bp = ss2ss(B, rand(n));

B == Bp % -> Operator '==' is not supported for operands of type 'ss'.

norm(Bp - B) % -> 0

Bdist(Bp, B) % -> 0
