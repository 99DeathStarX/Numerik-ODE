function x = implEuler(f, df, t, x_0)
  
  n = length(t); % get grid size
  m = length(x_0);
  x = x_0*ones(1,n); % allocate solution vector and initialize with x_0
  
  %% newton method y_i+1 (k+1) = y_i+1 (k) - F / F'
  
  x_temp = x(:,1); % allocate temporary solution vector
  z_k = x_0;
  I = eye(m); % create identity matrix
  
  for i=1:n-1
    for j=1:3 % do 3 iterations of newton method
      mat = I - (t(i+1) - t(i))*df(t(i+1), x_temp); % (I - hJ)
      b = x(:,i) + (t(i+1) - t(i)) * f(t(i+1), x_temp) - x_temp; % x_i + hf(t_i+1, x_i+1) - x_i+1
      z_k = mat \ b; % solve LGS
      x_temp = x_temp + z_k; % add solution vector 
    end
    x(:,i+1) = x_temp; % save solution in solution vector
  end
end
