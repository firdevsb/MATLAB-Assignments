function [root, iter_vals] = fixed_point_iteration(g, x0, tol, max_iter)
% fixed_point_iteration: solves x = g(x) using iteration
%
% Inputs:
% g = function handle for the rearranged form
% x0 = initial guess
% tol = tolerance
% max_iter = maximum iterations
%
% Outputs:
% root = approximate solution found
% iter_vals = vector storing all iteration values

iter_vals = x0; % Add the initial estimate to the vector
curr_x = x0;

for i = 1:max_iter
    next_x = g(curr_x); % x_{i+1} = g(x_i)
    iter_vals = [iter_vals, next_x]; % Add new values to the vector

    % Convergence control
    if abs(next_x - curr_x) < tol
        root = next_x;
        return;
    end

    curr_x = next_x;
end

root = curr_x;
warning('The maximum number of iterations has been reached; however, the desired accuracy may not have been achieved.');
end

% Define parameters
g = @(x) nthroot(5 - 3*x, 3); % The function g(x) in the image
x0 = 1; % initial guess
tol = 1e-6; % Tolerance
max_iter = 100; % Maximum iteration

% Call the function
[root_fp, iter_vals] = fixed_point_iteration(g, x0, tol, max_iter);

% Print the results
fprintf('The root found using Fixed Point Iteration: %.6f\n', root_fp);
fprintf('Number of iterations required: %d\n', length(iter_vals) - 1);

% Convergence Check
% g'(x) = -1 / (5 - 3x)^(2/3)
dg = @(x) -1 ./ ((5 - 3*x).^(2/3));
fprintf('|g''(root)| value: %.4f\n', abs(dg(root_fp)));

if abs(dg(root_fp)) < 1
    disp('The criterion has been met: |g''(x)| < 1 the method converges');
else
    disp('Warning: |g''(x)| >= 1 the method does not converges');
end