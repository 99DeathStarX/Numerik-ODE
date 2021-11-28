clear, close all

%% declare parameters
% implicit middle point method
A1 = 0.5;
b1 = 1;
c1 = 0.5;

% two-step gaussian method
A2 = [0.25, (0.25 - sqrt(3)/6); (0.25 + sqrt(3)/6), 0.25];
b2 = [0.5, 0.5]';
c2 = [(0.5-sqrt(3)/6), (0.5+sqrt(3)/6)]';

% simulation parameters
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

%% solve ode with impl. middle point rule (mpm) and two-step gaussian method (gm)
y_mpm1 = implRKV(f, df, t1, x_0, A1, b1, c1);
y_mpm2 = implRKV(f, df, t2, x_0, A1, b1, c1);
y_gm1 = implRKV(f, df, t1, x_0, A2, b2, c2);
y_gm2 = implRKV(f, df, t2, x_0, A2, b2, c2);

%% plot solutions
% implicit middle point rule
figure()
plot(t1, y_mpm1(1,:)) 
hold on
plot(t2, y_mpm2(1,:))
title('simulation of an ideal spring pendulum using implicit middle point method')
ylabel('position [m]')
xlabel('time [s]')
legend('h = 0.05s', 'h = 0.01s')

% two-step gaussian method
figure()
plot(t1, y_gm1(1,:))
hold on
plot(t2, y_gm2(1,:))
title('simulation of an ideal spring pendulum using two-step gaussian method')
ylabel('position [m]')
xlabel('time [s]')
legend('h = 0.05s', 'h = 0.01s')

%% Diskussion der Ergebnisse:
% Wie man den Graphen entnehmen kann, wird die Amplitude der Schwingung bei den beiden
% Verfahren erhalten und liefert somit physikalisch sinnvolle Ergebnisse.
% Weiterhin kann beobachtet werden, dass die Verringerung der Schrittweite
% keinen sichtbaren Einfluss auf das Ergebnis hat (die Graphen liegen
% unmittelbar aufeinander).

