for n = 1:3

clear T p q 
syms c

% toeplitz matrix
for i = 1:n
  T(i,i) = c; T(i+1,i) = 1;
end
for i = 0:n
  eval(['syms p_',int2str(i)])
  eval(['p(i+1) = p_',int2str(i),';']); 
  eval(['syms q_',int2str(i)])
  eval(['q(i+1) = q_',int2str(i),';']); 
end
p = conj(p'); q = conj(q');

f  = simplify(trace( conj([p q]') * ( eye(n+1) - T * inv(conj(T')*T) * conj(T') ) * [p q] ));
df = simplify(numden(diff(f,'c'))/2);
cdf = coeffs(df,'c');
%cs = simple(solve(df,'c'));

%disp(['$$',latex(collect(f,'c')),'$$'])
%disp(['$$',latex(collect(df,'c')),'$$'])
%disp(['$$',latex(cs),'$$'])

fprintf('$$\\bmx\n')
for i = 1:length(cdf)
  disp(latex(cdf(i))), fprintf('\\\\\n')
end
fprintf('\\emx$$\n')

end

return

for n = 2:6

clear A b
syms a c

% toeplitz matrix
for i = 1:n
  A(i,i) = a;
  eval(['syms b_',int2str(i)])
  eval(['b(i) = b_',int2str(i),';']); 
end
b = conj(b');
for i = 1:n-1
  A(i,i+1) = c;
  A(i+1,i) = c;
end

x = simplify(inv(A) * b);

disp(['$$',latex(collect(x,'c')),'$$'])

end
