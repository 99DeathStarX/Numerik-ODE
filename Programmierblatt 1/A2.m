%% Code to solve spring-mass problem
clear, close all

%% Parameters

simulation_time = 30; % simulation over 30s
h_1 = 0.05; % time step 0.05s
h_2 = 0.01; % time step 0.01s

t_1 = linspace(0, simulation_time, (simulation_time / h_1 + 1) ); % time grid with step width 0.05s
t_2 = linspace(0, simulation_time, (simulation_time / h_2 + 1) ); % time grid with step width 0.01s

m = 1; % mass m = 1kg
D = 2.1; % spring constant D = 2.1 N / m

x_0 = [0;1]; % start values x(0) = 0, x'(0) = 1
f = @(x) -(D/m) * x; % function handle v' = -D/m * u

%% Do explicite Euler method for h1 and h2
x_1 = explEuler(f,t_1,x_0);
x_2 = explEuler(f,t_2,x_0);

%% Plot graphs 
figure(1)

plot(t_1, x_1(1,:))
hold on
plot(t_2, x_2(1,:))
title('explicit Euler method')
xlabel('time [s]')
ylabel('position [m]')
legend('h = 0.05s', 'h = 0.01s', 'location', 'northwest')

%% Es fällt auf, dass bei zu großer Schrittweite die Lösung oszillatorisch divergiert.
%% Wählt man eine kleinere Schrittweite so besitzt die Lösung einen sinusförmigen Verlauf.

