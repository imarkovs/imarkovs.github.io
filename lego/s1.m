T = ceil(2000 / 50);      % number of samples = RUN_TIME / SAMPLING_TIME
t = (0:T-1)' * 50 / 1000; % time vector in seconds = (0:T-1)' * SAMPLING_TIME / 1000

s100 = load_dat('step100.dat', T);
s75  = load_dat('step75.dat',  T); 
s75_ = load_dat('step75_.dat', T); % for validation
s50  = load_dat('step50.dat',  T);

figure(1), plot(t, s100, 'k-', t, s75, 'r--', t, s50,  'b-.') 
legend('u=100', 'u=75', 'u=50', 'location', 'best')

n = 3; % moving average filter's order
s100f = ma_filter(s100, n);
s75f  = ma_filter(s75,  n); s75_f = ma_filter(s75_, n);
s50f  = ma_filter(s50,  n);

figure(2), plot(t, s100, 'r-', t, s100f, 'b--'), hold on
plot(t, s75,  'r-', t, s75f, 'b--')
plot(t, s50,  'r-', t, s50f, 'b--')

ah = ??; bh = ??; sinih = ??; % <--- Fill in the model parameters
sysh = tf(bh, [1 ah]) * tf(1, [1 0]);
s75h = 75 * (step(sysh, t) + sinih);

figure(4), plot(t, s75f, 'r-', t, s75h, 'b--'), 
legend('filtered data', 'model''s response', 'location', 'best')

s75_h = 75  * step(sysh, t) + s75_f(1);
s100h = 100 * step(sysh, t) + s100f(1);
s50h  = 50  * step(sysh, t) + s50f(1);

figure(5), plot(t, s75_f, 'r-', t, s75_h, 'b--')
figure(6), plot(t, s100f, 'r-', t, s100h, 'b--')
figure(7), plot(t, s50f , 'r-', t, s50h , 'b--')

kp = ??; ki = ??; kd = ??; % <--- fill in the PID controller parameters
pid  = tf([kd kp ki], [1 0]);
sysc = feedback(sysh * pid, 1);
[sc, tc] = step(sysc, t(end));

figure(8), plot(tc, sc)
ts = 0.015; kdp = kd / ts, kip = ki * ts
sc = load_dat('s.dat', T);

yini = ??; ref = ??; % <--- fill in the initial position and reference value 
                     %      in the data collection experiment
sim('s1_cl');

figure(9), plot(t, sc, 'r-', tc_, sc_, 'b--'), 
legend('measured response', 'model''s response', 'location', 'best')
