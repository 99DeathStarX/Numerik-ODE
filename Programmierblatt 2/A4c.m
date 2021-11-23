clear, close all

%% declare parameters
% RK abc
A = [0, 0, 0, 0; 0.5, 0, 0, 0; 0, 0.5, 0, 0; 0, 0, 1, 0];
b = [1/6; 1/3; 1/3; 1/6];
c = [0; 0.5; 0.5; 1];

T = 2; % total simulation time
f = @(t,y) (1-t).*y.*y; % right hand side of ode
y_0 = 1.8; % start value
y = @(t) 2./ ( t.*t - 2*t + (10/9) ); % exact solution

n = 6;
relativeError = zeros(n,1);
h = 10.^(-(1:n));

% do Kutta method and save relative error
for i=1:n
  t = 0:h(i):T;
  y_K = explRKV(f, t, y_0, A, b, c);
   %relativeError(i) = norm( abs(y_K - y(t) ./ y(t)) ); %klammer falsch gesetzt ihr berechnet abs(y_K-1)
  relativeError(i) = norm( abs(y_K - y(t)) ./ y(t) );
end

figure(1)
loglog(h, relativeError);
xlabel('stepwidth log h [s]')
ylabel('log y')
title('relative error plotted against the step width h')

%% Diskussion der Ergebnisse
% Es kann beobachtet werden, dass bis zu einer Schrittweite von h = 10^-4 der
% Fehler bei Verkleinerung der Schrittweite um Faktor 0.1 um den Faktor 10^-4 abnimmt.
% Dies deckt sich damit, dass das Kutta-Verfahren Konsistenzordnung 4 besitzt.
% Wählt man noch kleinere Schrittweiten sind numerische Instabilitäten zu beobachten,
% die zu einer Vergrößerung des Fehlers führen.
% Das sehe ich nicht in eurem bild. :D -1P










