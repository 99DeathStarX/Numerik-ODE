clear, close all

%% declare parameters

T = 2; % total simulation time
h1 = 0.05; % step width h1
h2 = 0.01; % step width h2
t1 = 0:h1:T; % time grid t1 using h1
t2 = 0:h2:T; % time grid t2 using h2

f = @(t,y) (1-t).*y.*y; % right hand side of ode
y_0 = 1.8; % start value

y = @(t) 2 ./ (t.*t - 2 * t + (10 / 9) ); % exact solution

%% Runge method
% declare parameters
A_R = [0,0; 0.5, 0];
b_R = [0;1];
c_R = [0; 0.5];

% solve ode using runge method
y1_R = explRKV(f, t1, y_0, A_R, b_R, c_R);
y2_R = explRKV(f, t2, y_0, A_R, b_R, c_R);

%% Kutta method
% declare parameters
A_K = [0, 0, 0, 0; 0.5, 0, 0, 0; 0, 0.5, 0, 0; 0, 0, 1, 0];
b_K = [1/6; 1/3; 1/3; 1/6];
c_K = [0; 0.5; 0.5; 1];

% solve ode using kutta method
y1_K = explRKV(f, t1, y_0, A_K, b_K, c_K);
y2_K = explRKV(f, t2, y_0, A_K, b_K, c_K);

%% plot solutions
figure(1)
plot(t1, y1_R, 'y-.', t2, y2_R, 'g-.')
hold on
plot(t1, y1_K, 'b-.', t2, y2_K, 'r-.')
plot(t2, y(t2), 'k-')
title('solution of start value problem using runge-kutta-methods')
xlabel('time [s]')
legend('runge - h = 0.05s', 'runge - h = 0.01s', 'kutta - h = 0.05s',"kutta - h = 0.01s", 'exact solution', 'location', 'northwest')



