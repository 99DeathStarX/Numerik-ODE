function y_new = picIter(t, y_old, f, y_0)
  
  %% declare variables
  n = length(t); % get n
  integral = 0; % declare integral
  y_new = ones(1,n); % allocate y_new vector
  
  y_new(1) = y_0; % First integral is 0 and therefore we set y_new to y_0
  
  %% Iterate over grid of t
  for i=2:n
    % calculate integral using trapezoidal rule 
    % therefore we use the integral of the previous iteration and add 0.5 (b-a) [f(a) + f(b)]
    integral = integral + 0.5 * ( t(i) - t(i-1) ) * ( f( t(i-1), y_old(i-1) ) + f( t(i), y_old(i) ) );
    y_new(i) = y_0 + integral;
  end
  
end
