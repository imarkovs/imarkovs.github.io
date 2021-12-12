p = [2 -3 1]'; q = [-3 2 0]';

S = [ [p;0] [0;p] -[q;0] -[0;q] ];
pdes = [0 0 0 1]';

pqc = S\pdes;

pc = pqc(1:2); qc = pqc(3:4); 

% check

conv(p,pc) - conv(q,qc)




