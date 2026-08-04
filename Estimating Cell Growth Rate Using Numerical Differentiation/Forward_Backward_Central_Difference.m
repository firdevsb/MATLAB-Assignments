%% 1. Given Data
time = [0; 2; 4; 6; 8; 10; 12]; % saat
concentration = [0.649; 0.975; 2.000; 3.370; 4.340; 6.280; 9.260]; % 10^6 cells/mL
h = 2; % dt = 2 saat

% Model Parameters
C0 = 0.5; r = 0.4; K = 3;

%% 2. Numerical and Analytical Differential Calculations for t = 6 hours
idx_6 = 4; % Index corresponding to t = 6

% Numerical Derivatives
dC_forward_6  = (concentration(idx_6 + 1) - concentration(idx_6)) / h;
dC_backward_6 = (concentration(idx_6) - concentration(idx_6 - 1)) / h;
dC_central_6  = (concentration(idx_6 + 1) - concentration(idx_6 - 1)) / (2*h);

% Analytical Derivative
t_target = 6;
dC_analytical_6 = C0 * r * (1 + (r * t_target) / K)^(K - 1);

% Printing the results
fprintf('--- t = 6 hr Sonuçları ---\n');
fprintf('Forward Difference : %.4f\n', dC_forward_6);
fprintf('Backward Difference: %.4f\n', dC_backward_6);
fprintf('Central Difference : %.4f\n', dC_central_6);
fprintf('Analytical Formula : %.4f\n\n', dC_analytical_6);


%% 3. Generating Derivative Vectors for All Points
N = length(time);
dC_forward = NaN(N, 1); dC_backward = NaN(N, 1); dC_central = NaN(N, 1);

for i = 1:N
    if i < N, dC_forward(i) = (concentration(i+1) - concentration(i)) / h; end
    if i > 1, dC_backward(i) = (concentration(i) - concentration(i-1)) / h; end
    if i > 1 && i < N, dC_central(i) = (concentration(i+1) - concentration(i-1)) / (2*h); end
end


%% Question 2: Drawing a Dual Y-Axis (yyaxis) Graph
figure('Name', 'Cell Growth Analysis', 'Position', [100, 100, 850, 500]);

% --- LEFT Y-AXIS: Concentration Data and Model Curve ---
yyaxis left
t_fine = linspace(0, 12, 200);
C_model = C0 * (1 + (r .* t_fine) ./ K).^K;

plot(time, concentration, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'DisplayName', 'Experimental Data (C)');
hold on;
plot(t_fine, C_model, 'k-', 'LineWidth', 2, 'DisplayName', 'Model Curve [C(t)]');
ylabel('Cell Concantration (10^6 cells/mL)', 'FontSize', 11, 'FontWeight', 'bold');
ax = gca; ax.YColor = [0 0 0]; %The left axis makes the text color black

% --- RIGHT Y-AXIS: Derivative Curves (Growth Rates) ---
yyaxis right
plot(time, dC_forward, 'r--s', 'LineWidth', 1.5, 'MarkerFaceColor', 'r', 'DisplayName', 'Forward Difference');
plot(time, dC_backward, 'b--^', 'LineWidth', 1.5, 'MarkerFaceColor', 'b', 'DisplayName', 'Backward Difference');
plot(time, dC_central, 'g--o', 'LineWidth', 1.5, 'MarkerFaceColor', 'g', 'DisplayName', 'Central Difference');
ylabel('Growth Ratio (dC/dt) [10^6 cells/mL/hr]', 'FontSize', 11, 'FontWeight', 'bold');

% Graphics Edits
xlabel('Time (hours)', 'FontSize', 11, 'FontWeight', 'bold');
title('Comparison of Concentration and Numerical Derivative Values', 'FontSize', 12, 'FontWeight', 'bold');
grid on;
legend('Location', 'northwest');
hold off;


%% Question 3: Bar Chart Comparison for t = 6 hours
figure('Name', 'Comparison (t = 6 hr)', 'Position', [150, 150, 600, 450]);

methods_data = [dC_forward_6, dC_backward_6, dC_central_6, dC_analytical_6];
labels = {'Forward Difference', 'Backward Difference', 'Central Difference', 'Analytical'};

b = bar(methods_data, 0.5, 'FaceColor', 'flat');
b.CData(1,:) = [0.85 0.33 0.1];  % Red/Orange
b.CData(2,:) = [0 0.45 0.74];    % Blue
b.CData(3,:) = [0.47 0.67 0.19]; % Green
b.CData(4,:) = [0.25 0.25 0.25]; % Dark Grey

% Printing numerical values ​​on the bars
text(1:4, methods_data, num2str(methods_data', '%.4f'), ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 10, 'FontWeight', 'bold');

set(gca, 'XTickLabel', labels, 'FontSize', 11);
ylabel('Instantaneous Growth Rate (10^6 cells/mL/hr)', 'FontWeight', 'bold');
title('Cell Growth Rate at t = 6 hours (Method Comparison)', 'FontSize', 12, 'FontWeight', 'bold');
grid on;
ylim([0, max(methods_data)*1.2]);
