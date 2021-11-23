clear, close all

%% declare parameters

x_0 = [0;1]; % start vector
T = 30; % total simulation time

h1 = 0.05; % step width 0.05s
h2 = 0.01; % step width 0.01s
t1 = 0:h1:T; % time grid with h1
t2 = 0:h2:T; % time grid with h2

m = 1; % kg
D = 2.1; % N/m
A = [0, 1; -D/m, 0];

f = @(t,x) A * x; % function handle
df = @(t,x) A; % derivative of f -> needed for newton-method

%% solve ode with impl. euler method
x1 = implEuler(f, df, t1, x_0);
x2 = implEuler(f, df, t2, x_0);

%% Plot solution
figure(1)
plot(t1, x1(1,:));
hold on
plot(t2, x2(1,:));
title('simulation of an ideal spring pendulum using implicit euler method')
xlabel('time [s]')
ylabel('position [m]')
legend('h = 0.05s', 'h = 0.01s', 'location', 'northeast');

%% Diskussion der Ergebnisse
% Im Gegensatz zum expliziten Euler-Verfahren, konvergiert das implizite Euler-Verfahren
% dieses mal gegen 0, was auch mit den Erkenntnissen des Theorieblatts vereinbar ist.
% Für h = 0.01s nimmt die Oszillation nicht so stark ab, allerdings wird auch diese
% Lösung für hinreichend lange Simulationszeit gegen 0 konvergieren. in der
% tat