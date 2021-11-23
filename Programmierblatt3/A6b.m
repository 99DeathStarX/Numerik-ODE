clear, close all

%% declare parameters
xRange = [-4 4]'; % upper and lower boundary of x
yRange = [-4 4]'; % upper and lower boundary of y
step = 0.1; % step width

%% declare method parameters
A1 = 0; b1 = 1; c1 = 0; % expl. euler method
A2 = 1; b2 = 1; c2 = 1; % impl. euler method
A3 = [0 0; 0.5 0]; b3 = [0 1]'; c3 = [0 0.5]'; % runge method
A4 = [0 0 0 0; 0.5 0 0 0; 0 0.5 0 0; 0 0 1 0]; b4 = [1/6 1/3 1/3 1/6]'; c4 = [0 0.5 0.5 1]'; % kutta method

%% do stabFct on the four methods
[X, Y, R1] = stabFct(A1, b1, xRange, yRange, step); % expl. euler
[~, ~, R2] = stabFct(A2, b2, xRange, yRange, step); % impl. euler
[~, ~, R3] = stabFct(A3, b3, xRange, yRange, step); % runge
[~, ~, R4] = stabFct(A4, b4, xRange, yRange, step); % kutta

%% plot stability area with S := {x \in C: |R(x)| <= 1}
contour(X,Y,abs(R1) <= 1, 1, 'color', 'b'); % expl. euler
hold on
contour(X,Y,abs(R2) <= 1, 1, 'color', 'r'); % impl. euler
contour(X,Y,abs(R3) <= 1, 1, 'color', 'g'); % runge
contour(X,Y,abs(R4) <= 1, 1, 'color', 'k'); % kutta
legend('expl. euler method', 'impl. euler method', 'runge method', 'kutta-method')
hold off

