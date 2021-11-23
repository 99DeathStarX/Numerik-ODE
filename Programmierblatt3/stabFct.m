function [X, Y, R] = stabFct(A, b, xRange, yRange, step)
% X, Y: coordinate grid
% R: values of the stability function
% A,b: runge cutta parameters
% xRange, yRange: vector with lower and upper boundary of grid
% step: step width of equidistant grid

s = length(b); % get s
I = speye(s); % create identity matrix

%% define coordinate grid
v = xRange(1):step:xRange(2); % define x grid
w = yRange(1):step:yRange(2); % define y grid
[X, Y] = meshgrid(v, w); % create mesh

%% solve R on X + iY: 1 + x * b^T * (I-xA)^-1 * vec(1)
R = arrayfun(@(x) (1 + x * b' * ((I - x*A) \ ones(s,1))), X+1i*Y);

end