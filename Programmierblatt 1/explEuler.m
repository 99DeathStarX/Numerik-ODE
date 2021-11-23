function x = explEuler(f,t,x_0)

n = length(t);
x = zeros(2,n);

x(:,1) = x_0;

for i=1:n-1
  x(1,i+1) = x(1,i) + (t(i+1) - t(i)) * x(2,i);
  x(2,i+1) = x(2,i) + (t(i+1) - t(i)) * f(x(1,i));
end
    
end
