%% Simulation parameters

m = 2; p = 1; q = m + p; n = 3; B = drss(n, p, m);

%% The restricted behavior

T = 10; BT = B2BT(B, T);

check(size(BT, 2) == m * T + n) % -> PASS

w = B2w(B, T); check(w_in_B(w, B)) % -> PASS

W = BT2W(BT, q); check(all(w_in_B(W, B))) % -> PASS

%% Input/output partitionings

io = flip(1:q); BTp = BT2BT(BT, q, io);

check(w_in_B(w(:, io), BTp)) % -> PASS

[UT, YT] = BT2UYT(BT, m, p);

check(norm(BT - UYT2BT(UT, YT, m, p)) == 0) % -> PASS

Bp = ss(tf([0 1], [1 1], 1));

BpT = B2BT(Bp, T);
check(is_io(BpT, 2, [1 2]) == true)  % -> PASS 
check(is_io(BpT, 2, [2 1]) == false) % -> PASS
check(all(BT2IO(BpT, 2) == [1 2]))   % -> PASS

%% Subbehaviors

Y0 = BT2Y0(BT, q);
U0 = BT2U0(BT, q);
B0 = BT2B0(BT, q);
BC = BT2BC(BT, q);

y0 = initial(B, rand(n, 1), T-1); check(w_in_B(y0, Y0)) % -> PASS

u0 = reshape(U0 * rand(size(U0, 2), 1), m, T)';
w0 = [u0 zeros(T, p)]; check(w_in_B(w0, BT)) % -> PASS

T0 = size(B0, 1) / q;
w0 = reshape(B0 * rand(size(B0, 2), 1), q, T0)'; 
xini = w2xini(w0, B); check(norm(xini) < tol) % -> PASS

[HT, T] = BT2HT(BT, q);

check(norm(HT - convm(B, T)) < tol) % -> PASS

%% Analysis

[ch, mh, ellh, nh] = BT2c(BT, q); check(all([mh nh] == [m n])) % -> PASS

ell = lag(B); check(ellh == ell) % -> PASS

Bp = B; Bp.a = Bp.a + 0.01 * randn(n); d = Bdist(B, Bp);

Bp = ss2ss(B, rand(n)); check(equal(B, Bp)) % -> PASS

Bp = ss([0.5 1; 0 0.25], [1; 0], [1 1], 1, -1); 
n_unctr = isunctr(Bp); check(n_unctr == 1)  % -> PASS

Bp = ss([0.5 1; 0 0.25], [1; 1e-5], [1 1], 1, -1); 
d = distunctr(Bp); % -> 1e-7

[Hinf, ~, uinf] = BT2Hinf(BT, q); C = convm(B, T);
check(abs(Hinf - norm(C)) / norm(C) < tol) % -> PASS

%% Parametric representations

R = B2R(B); R = BT2R(BT, q);

BT_ = R2BT(B2R(B), q, T); check(equal(B, BT_)) % -> PASS
BT_ = ss2BT(B, T);        check(equal(B, BT_)) % -> PASS

check(equal(B, BT2ss(BT, q))) % -> PASS

check(equal(B, R2ss(R, q))) % -> PASS

Rmin = BT2Rmin(BT, q); check(equal(BT, R2BT(Rmin, q, T), q)) % -> PASS
Rmin = R2Rmin(R, q);   check(equal(BT, R2BT(Rmin, q, T), q)) % -> PASS

%% Signal processing and open-loop control

[d, wh] = dist(w, B);

[xini, e] = w2xini(w, B); check(norm(w - B2w(B, T, xini, w(:, 1:m))) < tol)  % -> PASS

BT = B2BT(B, ell + size(w,1));
[wini, e] = w2wini(w, BT, ell); check(w_in_B([wini; w], B)) % -> PASS

yf = u2y(BT, q, w(:, 1:m), wini); check(w(:, m+1:end) - yf) % -> PASS

Tf = 3; u1 = [[1; zeros(q * Tf - 1, 1)] zeros(q * Tf, m - 1)];
h1 = u2y(BT, q, u1); h = lsim(B, u1); check(h1 - h < tol) % -> PASS

qg = 2; qm = 2; q = qm + qg; m = 1; p = q - m; n = 5; B = drss(n, p, m);
T = 20; w = B2w(B, T); wg = w(:, 1:qg); wm = w(:, qg+1:q);
wmh = wgiven2wmissing(wg, B); check(norm(wm - wmh) / norm(wm) < tol) % -> PASS

m = 1; p = 1; n = 3; q = m + p; B = drss(n, p, m); 
Tr = 10; wr = [zeros(Tr, m) ones(Tr, p)]; ell = lag(B);
v = [1e-2 * ones(Tr, m), ones(Tr, p)]; wh = lqctr(B, wr, v);

if ~isunctr(B)
  Tr = ell; wr = zeros(Tr, q);
  wp = B2w(B, ell); wf = zeros(ell, q); 
  wh = lqctr(B, wr, [], wp, wf);
  check(w_in_B([wp; wh; wf], B))
end

%% Identification

Td = 100; wd = B2w(B, Td);

ch = c_mpum(wd); check(all(ch == [m, lag(B), n])) % -> PASS

BhT = w2BT(wd, T);

R = w2R(wd); check(w_in_B(wd, R2BT(R, q, Td))) % -> PASS

Bh = w2ss(wd); check(w_in_B(wd, Bh)) % -> PASS

R_ = mpum(wd); check(w_in_B(wd, R2BT(R_, q, Td))) % -> PASS
