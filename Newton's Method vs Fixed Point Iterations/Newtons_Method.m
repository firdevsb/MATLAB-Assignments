function [root, iter_vals] = newton_method(f, df, x0, tol, max_iter)
% newton_method, f(x) = 0 The root of the equation is found using Newton's method.
%
% Inputs:
% f = f(x) function handle
% df = function handle for f&#39;(x)
% x0 = initial guess
% tol = tolerance
% max_iter = maximum number of allowed iterations
%
% Outputs:
% root = approximate root found
% iter_vals = vector of all iteration values [x0, x1, x2, ...]

iter_vals = x0; % start with first assumption
curr_x = x0;

for i = 1:max_iter
    f_val = f(curr_x);
    df_val = df(curr_x);

    % Check to avoid errors if the derivative is zero
    if df_val == 0
        error('Newtons method fails because the derivative is zero.');
    end

    % Newton Formula: x_{n+1} = x_n - f(x_n) / f&#39;(x_n)

    next_x = curr_x - (f_val / df_val);
    iter_vals = [iter_vals, next_x]; % Add the new value to the list

    % Convergence control
    if abs(next_x - curr_x) < tol
        root = next_x;
        return;
    end

    curr_x = next_x;
end

root = curr_x;
warning('The maximum number of iterations has been reached.');
end

% 1. Define functions
f = @(x) x^3 + 3*x - 5;
df = @(x) 3*x^2 + 3;

% 2. Define the parameters
x0 = 1;
tol = 1e-6;
max_iter = 50;

% 3. Call newton method
[root_newton, iter_vals_newton] = newton_method(f, df, x0, tol, max_iter);

% 4. Print the results

fprintf('--- Results of the Newton Method ---\n');
fprintf('The final root found: %.6f\n', root_newton);
fprintf('Number of iterations performed: %d\n', length(iter_vals_newton) - 1);