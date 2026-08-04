function drug_diffusion_comparison()
    %% 1. Definitions and Parameters
    t_start = 0;
    t_end = 25;
    C0 = 10; % Initial concentration (mg/L)

    % Nonlinear Ordinary Differential Equation (ODE): dC/dt = f(t, C)
    % Derived from the exact solution using the chain rule and sec^2(x) = 1 + tan^2(x)
    f = @(t, C) -0.04 * (5.25 + C^2);

    % Exact (Analytical) Solution Function
    exact_sol = @(t) sqrt(5.25) * tan(atan(10/sqrt(5.25)) - 0.04 * sqrt(5.25) * t);

    %% 2. Running Simulations
    % Simulation and analysis for step size h = 1.0
    [res1, h1_times] = run_simulation(f, exact_sol, t_start, t_end, C0, 1);
    
    % Simulation and analysis for step size h = 0.25
    [res2, h2_times] = run_simulation(f, exact_sol, t_start, t_end, C0, 0.25);

    %% 3. Plotting Results (Task 3 - for h = 1.0)
    figure('Color', 'w', 'Position', [100, 100, 850, 500]);
    
    % Fine-grained time vector for a smooth exact solution curve
    t_fine = linspace(t_start, t_end, 500);
    plot(t_fine, exact_sol(t_fine), 'k-', 'LineWidth', 2); hold on;
    
    % Modified Euler (Heun) Solution
    plot(h1_times, res1.C_heun, 'ro--', 'LineWidth', 1.2, 'MarkerFaceColor', 'r', 'MarkerSize', 5);
    
    % 4th-Order Runge-Kutta (RK4) Solution
    plot(h1_times, res1.C_rk4, 'bs-.', 'LineWidth', 1.2, 'MarkerFaceColor', 'b', 'MarkerSize', 5);
    
    % Plot adjustments
    title('Drug Diffusion Profile over Time (h = 1 min)', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (minutes)', 'FontSize', 11);
    ylabel('Concentration C(t) (mg/L)', 'FontSize', 11);
    legend('Exact Solution', 'Modified Euler (Heun)', '4th-Order Runge-Kutta (RK4)', 'Location', 'Best');
    grid on;
    axis([t_start t_end 0 C0+1]);

    %% 4. Tabulating Performance Metrics (Task 5 & 6)
    fprintf('========================================================================\n');
    fprintf('         PERFORMANCE COMPARISON TABLE (TASK 5 & 6)                      \n');
    fprintf('========================================================================\n');
    fprintf('%-27s | %-18s | %-18s\n', 'Metric / Method', 'Step Size h = 1.00', 'Step Size h = 0.25');
    fprintf('------------------------------------------------------------------------\n');
    fprintf('%-27s | %-18e | %-18e\n', 'Heun Avg Comp Time (s)', res1.t_heun_bench, res2.t_heun_bench);
    fprintf('%-27s | %-18e | %-18e\n', 'RK4 Avg Comp Time (s)',  res1.t_rk4_bench,  res2.t_rk4_bench);
    fprintf('------------------------------------------------------------------------\n');
    fprintf('%-27s | %-18.6f | %-18.6f\n', 'Heun Avg Absolute Error', res1.avg_err_heun, res2.avg_err_heun);
    fprintf('%-27s | %-18.6f | %-18.6f\n', 'RK4 Avg Absolute Error',  res1.avg_err_rk4,  res2.avg_err_rk4);
    fprintf('========================================================================\n\n');
    
    % Error Improvement Analysis
    heun_err_imp = ((res1.avg_err_heun - res2.avg_err_heun) / res1.avg_err_heun) * 100;
    rk4_err_imp = ((res1.avg_err_rk4 - res2.avg_err_rk4) / res1.avg_err_rk4) * 100;
    
    fprintf('Accuracy Improvement Analysis (Transition from h=1.0 to h=0.25):\n');
    fprintf(' -> Modified Euler Error Reduction: %.2f%%\n', heun_err_imp);
    fprintf(' -> RK4 Error Reduction: %.2f%%\n', rk4_err_imp);
end

%% --- AUXILIARY SIMULATION FUNCTION ---
function [struct_out, t] = run_simulation(f, exact_sol, t_start, t_end, C0, h)
    t = t_start:h:t_end;
    N = length(t);
    
    % Analytical solution values at specific node points
    C_exact = exact_sol(t);
    
    %% Task 1a: Modified Euler (Heun's Method) with Benchmarking
    C_heun = zeros(1, N);
    C_heun(1) = C0;
    
    % Running the loop 1000 times to get an accurate average computation time
    tic;
    for run = 1:1000 
        for i = 1:(N-1)
            k1 = f(t(i), C_heun(i));
            C_predict = C_heun(i) + h * k1; % Predictor step
            k2 = f(t(i+1), C_predict);       % Corrector slope
            C_heun(i+1) = C_heun(i) + (h/2) * (k1 + k2); % Corrector step
        end
    end
    t_heun_bench = toc / 1000; % Average time for a single execution

    %% Task 1b: 4th-Order Runge-Kutta (RK4) with Benchmarking
    C_rk4 = zeros(1, N);
    C_rk4(1) = C0;
    
    tic;
    for run = 1:1000
        for i = 1:(N-1)
            ti = t(i);
            Ci = C_rk4(i);
            
            k1 = f(ti, Ci);
            k2 = f(ti + h/2, Ci + (h/2)*k1);
            k3 = f(ti + h/2, Ci + (h/2)*k2);
            k4 = f(ti + h, Ci + h*k3);
            
            C_rk4(i+1) = Ci + (h/6) * (k1 + 2*k2 + 2*k3 + k4);
        end
    end
    t_rk4_bench = toc / 1000;

    %% Task 4 & 5: Error Quantification (Absolute Error)
    err_heun = abs(C_exact - C_heun);
    err_rk4 = abs(C_exact - C_rk4);
    
    % Packing the outputs into a structure
    struct_out.C_heun = C_heun;
    struct_out.C_rk4 = C_rk4;
    struct_out.t_heun_bench = t_heun_bench;
    struct_out.t_rk4_bench = t_rk4_bench;
    struct_out.avg_err_heun = mean(err_heun);
    struct_out.avg_err_rk4 = mean(err_rk4);
end