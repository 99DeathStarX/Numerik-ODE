function y = implRKV(f, df, t, y_0, A, b, c)
%% function parameters
% A,b,c: RKV parameters
% t: time grid
% f: rhs of ode
% df: partial derivative of f
% y_0: start vector

s = length(b); % get number of steps
d = length(y_0); % get dimension of ode

%% allocate solution vector and identity matrix
y = y_0 * ones(1, length(t));
I = speye(s*d);

%% do simplified newton method
for i=1:length(t)-1

    % calculate parameters for newton iteration
    h = t(i+1) - t(i); % time step
    J = df(t(i), y(:,i)); % jacobi matrix at y_i, t_i
    D_Phi = h * kron(A, J); % d_phi
    k_j = repmat(f(t(i), y(:,i)), 1, s); % initialize k_j
    lhs = (I - D_Phi); % calculate lhs of LGS since it doesnt change in iterations
    Phi = zeros(d,s); % allocate Phi matrix

    %% do newton iterations (3 steps)
    for j=1:3
        % calculate phi(k_j) = f(t_i + c_j*h, y_i + sum_v=1^s a_jv k_v)
        for k=1:s
            Phi(:,k) = f(t(i) + c(k)*h, y(:,i) + sum(h * A(k,:) .* k_j, 2)); 
        end
        % calculate rhs in lexicographic order (dimension s*d)
        rhs = reshape(Phi, s*d, 1) - reshape(k_j, s*d, 1);
        z_n = lhs \ rhs; % solve LGS
        k_j = k_j + reshape(z_n, d, s); % add solution of LGS to obtain k_j(n+1)
    end
    y(:,i+1) = y(:,i) + h * (b' * k_j')'; % calculate y_i+1 = y_i + h * sum b_j k_j
end

