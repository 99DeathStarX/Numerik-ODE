% Script performs and visualizes the Picard iteration for the ode y'=f(t,y)
% with y(t_0) = y_0. [by Lukas Holbach]
clear, close all;

%% analytical parameters
f = @(t,y) -y + cos(t);                    % rhs of ode
Y = @(t) 0.5*(sin(t) + cos(t) - exp(-t));  % analytical solution of ode
y_0 = 0;                                   % y(t_0)
t_0 = 0;                                   % simulation on interval [t_0, T]
T = 10;

%% numerical parameters
N = 101;                        % no. of nodes
t = linspace(t_0,T,N);          % time grid
tol = 1e-3;                     % tolerance for rel. error in Picard iteration
iter = 1;                       % iteration counter
maxIter = 50;                   % max. no. of Picard iterations
y = y_0*ones(1,N);              % first (or zeroth) iterate
n_0 = norm(Y(t));               % to normalize the error
relErr = zeros(maxIter,1);      % to save rel. errors in each iteration
relErr(1) = norm(Y(t)-y)/n_0;   % first (or zeroth) rel. error

% plot analytical and first iterative solution
plot(t,Y(t),'k');
axis([0 10 -2 2])
hold on
h1 = plot(t,y,'r');
legend('analytical solution', 'iterative solution', 'Location', 'northwest')
xlabel('t')
ylabel('y(t)')
title('Picard iteration')
pause(0.5)

%% Picard iteration 
% until the error is sufficiently small or max. no. of iterations is
% reached

while relErr(iter) > tol && iter <= maxIter    
    % perform Picard iteration
    y = picIter(t, y, f, y_0);
    
    % save relative error
    iter = iter + 1;
    relErr(iter) = norm(Y(t)-y)/n_0;
    
    % plot iterative solution
    set(h1,'YData',y);
    pause(0.3)
end

% plot relative error
figure(2)
semilogy(0:iter-1,relErr(1:iter));
xlabel('iteration no.')
ylabel('rel. error')
title('relative error of Picard iteration')
