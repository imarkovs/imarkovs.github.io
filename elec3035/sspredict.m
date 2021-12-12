% Prediction of an scalar autonomous response, using a model
% State-space approach

function yf = ss_predict(yp,a,c,Tf)

T = length(yp);
n = size(c,2);

% Construct the extended observability matrix
O = c;
for i = 1:T+Tf-1
  O = [O; O(end,:)*a];
end

Op = O(1:T,:);
Of = O(T+1:end,:);

yf = Of * inv(Op'*Op) * Op' * yp;
