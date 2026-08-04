%Gaussian Elimination

A= [10 -2 1 3;
    -3 8 -1 2;
    1 -2 9 -1;
    2 1 -3 7];

b= [27; -14; 8; -3];
n= length(b);
Aug= [A b];

%Forward Elimination

for k=1:n-1
    for i=k+1:n
        m= Aug(i,k)/Aug(k,k);
        Aug(i,k:n+1)=Aug(i,k:n+1) - m* Aug(k,k:n+1);
    end
end

% Back Substitution

xg= zeros(n,1);
xg(n)= Aug(n,n+1)/Aug(n,n);

for i=n-1:-1:1
    sum_val=Aug(i,i+1:n)*xg(i+1:n);
    xg(i)=(Aug(i,n+1)-sum_val)/Aug(i,i);
end

fprintf('---Gaussian Elimination Result(xg)---\n');
disp(xg)

%Jacobi Iteration 

A= [10 -2 1 3;
    -3 8 -1 2;
    1 -2 9 -1;
    2 1 -3 7];

b= [27; -14; 8; -3];

n = length(b);
xj = zeros(n,1);        % Initial guess: [0;0;0;0]
tol = 1e-6;             % Stopping criterion 
max_iter = 100;         % Maximum number of steps to avoid entering an infinite loop
err_rel = 1;            % Initial error value
iter = 0;

%Iterations
while err_rel > tol && iter < max_iter
    x_old = xj;         % Keep the values ​​from the previous step
    
    for i = 1:n
        sum_val = A(i,:) * x_old - A(i,i) * x_old(i);
        xj(i) = (b(i) - sum_val) / A(i,i);
    end
   
    err_rel = norm(xj - x_old) / norm(xj);
    
    iter = iter + 1;
end

% Print the Results
fprintf('\n--- Jacobi Iteration Result (xj) ---\n');
disp(xj);
fprintf('Number of Iterations: %d\n', iter);


%Errors

% 1. Relative Error - err_rel
%The ratio of the difference between the Jacobian result (xj) and the Gaussian result (xg) to the Gaussian result.
err_rel_final = norm(xj - xg) / norm(xg);

% 2. Residual Error - err_res
% When we substitute Jacobi's result (xj) into the system, how much does it deviate from the right side (b)
err_res_final = norm(A * xj - b);

% Printing the Results
fprintf('\n--- Comparison Results ---\n');
fprintf('Relative Error - err_rel: %.10f\n', err_rel_final);
fprintf('Residual Error - err_res: %.10f\n', err_res_final);