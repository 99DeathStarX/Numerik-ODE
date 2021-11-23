function y = implRKV(f, df, t, y_0, A, b, c)
%% function parameters
% A,b,c: RKV parameters
% t: time grid
% f: rhs of ode
% df: partial derivative of f
% y_0: start vector

s = length(b);

%% allocate solution vector and temporary vector k
y = y_0 * ones(1, length(t));
k = zeros(s, length(y_0));
I = speye(s * size(A,1));

%% newton iteration
for i=1:length(t)-1
    % calculate parameters for newton iteration
    h = t(i+1) - t(i);
    J = df(t(i),y(i)); % calculate Jacobi-Matrix at t_i, y_i
    D_phi = h * kron(A,J); % calculate D_Phi
    for j=1:s
        k(j,:) = f(t(i), y(:,i))'; % initialize k
    end
    % do simplified newton iteration
    for j=1:3
        % solve LGS (I- D_Phi)z(n) = \Phi((n)) - k(n)
        lhs = (I - D_phi);
        rhs = f(t(i) + c(j) * h, y(i) + (h * A(:,:) * k(:,:))' ) - k(:,:)';
        z_n = lhs \ rhs;
        k = k + z_n;
    end
    % calculate y_i+1 = y_i + h \sum_j=1^s b_j k_j(n)
    y(i+1,:) = y(i,:) + h * b(:)' * k(:,1);
end

end
