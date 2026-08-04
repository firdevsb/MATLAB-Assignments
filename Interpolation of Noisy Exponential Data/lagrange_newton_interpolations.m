%% Given Data
x = [0.0 0.5 1.0 1.5 2.0];
y = [1.0497 1.6129 2.7281 4.4003 7.2978];
true_f = @(x) exp(x);
xp = [1.2 1.8]; % Points where estimation is requested

%% PART 1 & 2: INTERPOLATION (Lagrange & Newton)
% Call the functions
yp_lagrange = lagrange_interp(x, y, xp);
yp_newton = newton_interp(x, y, xp);

% Large dataset for visualization
xx = linspace(0, 2, 200);
yy_true = true_f(xx);
yy_lagrange = lagrange_interp(x, y, xx);

%% PART 3: CURVE FITTING (Least-Squares Exponential Fit)

% f(x) = a * e^(bx) modelini lineerleştirelim: ln(f(x)) = ln(a) + bx
% Bu durumda polyfit kullanarak b ve ln(a) değerlerini buluruz.
p = polyfit(x, log(y), 1); 
b_fit = p(1);
a_fit = exp(p(2));
fit_f = @(val) a_fit * exp(b_fit * val);

yp_fit = fit_f(xp);
yy_fit = fit_f(xx);

%% PART 4: VISUALIZATION 
figure;
plot(xx, yy_true, 'r-', 'LineWidth', 2, 'DisplayName', 'True f(x) = e^x'); hold on;
plot(xx, yy_lagrange, 'b--', 'LineWidth', 1.5, 'DisplayName', 'Lagrange Interpolation');
plot(xx, yy_fit, 'g:', 'LineWidth', 1.5, 'DisplayName', 'Exponential Fit');
plot(x, y, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Noisy Data Points');
plot(xp, yp_lagrange, 'gs', 'MarkerSize', 8, 'DisplayName', 'Lagrange Estimates');
legend('Location', 'northwest');
xlabel('x'); ylabel('f(x)');
title('Interpolation vs. Curve Fitting on Noisy Data');
grid on;

%% ERROR ANALYSIS & DISCUSSION 
true_vals = true_f(xp);
err_lagrange = abs(yp_lagrange - true_vals);
err_newton = abs(yp_newton - true_vals);
err_fit = abs(yp_fit - true_vals);

fprintf('\nError Analysis and Discussion:\n');
for i = 1:length(xp)
    fprintf('x = %.1f\n', xp(i));
    fprintf('  True f(x)         = %.4f\n', true_vals(i));
    fprintf('  Lagrange Estimate = %.4f, Absolute Error: %.4f\n', yp_lagrange(i), err_lagrange(i));
    fprintf('  Newton Estimate   = %.4f, Absolute Error: %.4f\n', yp_newton(i), err_newton(i));
    fprintf('  Curve Fit Est.    = %.4f, Absolute Error: %.4f\n', yp_fit(i), err_fit(i));
end

% Behavior Analysis 
fprintf('\n- Behavior near and between data points:\n');
fprintf('  Lagrange interpolation method passes through all given data points exactly,\n');
fprintf('  which can cause them to be more sensitive to noise and potentially oscillate.\n');
fprintf('  Exponential fit (Least-Squares) smooths the noise and follows the trend.\n');

%% Functions

% Part 1: Lagrange Interpolation
function yp = lagrange_interp(x, y, xp)
    n = length(x);
    yp = zeros(size(xp));
    for k = 1:length(xp)
        s = 0;
        for i = 1:n
            L = 1;
            for j = 1:n
                if j ~= i
                    L = L * (xp(k) - x(j)) / (x(i) - x(j));
                end
            end
            s = s + y(i) * L;
        end
        yp(k) = s;
    end
end

% Part 2: Newton Interpolation (Divided Differences)
function yp = newton_interp(x, y, xp)
    n = length(x);
    F = zeros(n, n);
    F(:,1) = y';
    for j = 2:n
        for i = j:n
            F(i,j) = (F(i,j-1) - F(i-1,j-1)) / (x(i) - x(i-j+1));
        end
    end
    yp = zeros(size(xp));
    for k = 1:length(xp)
        res = F(1,1);
        poly_term = 1;
        for j = 1:n-1
            poly_term = poly_term * (xp(k) - x(j));
            res = res + F(j+1,j+1) * poly_term;
        end
        yp(k) = res;
    end
end