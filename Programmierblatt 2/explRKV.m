function y = explRKV(f,t,y_0,A,b,c)
  
  n = length(t); % get grid size
  s = size(A,1); % get size of A
  y = y_0*ones(1,n); % allocate solution vector
  eta = zeros(s,1); % allocate temporary eta vector
  
  for i=1:n-1 % iterate over time grid
    h = t(i+1) - t(i); % calculate h in case of non linear grid
    % calculate eta_j = f(t_n + hc_j, y_n + h sum_l=1^s a_jl k_l), j=1,...,s
    eta(1) = y(i); % first eta is (half) explicit euler step
    for j=1:s
      eta(j) = f((t(i) + h * c(j)), (y(i) + h*sum(A(j,:) * eta)));
    end
    % y(n+1) = y(n) + h * sum_j=1^s b_j eta_j
    y(i+1) = y(i) + h * sum(b .* eta); 
  end
  
end
