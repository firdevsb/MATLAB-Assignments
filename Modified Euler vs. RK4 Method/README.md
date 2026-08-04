# Drug Diffusion Simulation: Modified Euler vs. RK4 Method

This repository contains MATLAB implementations for simulating the non-linear pharmacokinetics of drug concentration $C(t)$ in tissue over time. 

Two numerical Ordinary Differential Equation (ODE) solvers are implemented from scratch and evaluated:
1. **Modified Euler's Method (Heun's Method)** — 2nd-order ODE solver
2. **4th-Order Runge-Kutta (RK4)** — 4th-order ODE solver

---

## 💡 Problem Description

A drug is injected into a tissue compartment where high concentrations are eliminated faster (mimicking drug clearance behavior in vascular tissue).

### Initial Condition & Analytical Solution
* **Initial Concentration:** $C(0) = 10 \text{ mg/L}$
* **Exact Analytical Solution:**

$$C(t) = \sqrt{5.25} \cdot \tan\left( \arctan\left(\frac{10}{\sqrt{5.25}}\right) - 0.04 \cdot \sqrt{5.25} \cdot t \right)$$

---

## ⚙️ Tasks & Methodology

### 1. Numerical Solver Implementation
* **(a) Modified Euler (Heun's Method):** Uses predictor-corrector approach ($O(h^2)$ accuracy).
* **(b) Runge-Kutta 4th Order (RK4):** Uses 4 intermediate slope evaluations ($k_1, k_2, k_3, k_4$) for high-precision integration ($O(h^4)$ accuracy).

### 2. Time Domain & Step Size
* **Simulation Interval:** $t \in [0, 25] \text{ minutes}$
* **Base Step Size:** $h = 1.0 \text{ min}$
* **Refined Step Size Comparison:** $h = 0.25 \text{ min}$

### 3. Performance & Error Metrics
* **Absolute Error at Time Point $t_i$:**
  $$\text{Absolute Error}(t_i) = |C_{\text{numerical}}(t_i) - C_{\text{exact}}(t_i)|$$
* **Average Absolute Error:** Mean of absolute errors across all time steps.
* **Computation Time:** Measured average execution time for each method.

---

## 📊 Results & Discussion

### Performance Comparison ($t \in [0, 25]\text{ min}$)

| Step Size ($h$) | Method | Average Absolute Error | Avg. Computation Time (s) |
| :---: | :--- | :---: | :---: |
| **$h = 1.00$** | **Modified Euler (Heun)** | `0.050631` | `3.4610 \times 10^{-6}` |
| | **RK4** | `0.000017` | `4.3900 \times 10^{-6}` |
| **$h = 0.25$** | **Modified Euler (Heun)** | `0.003058` | `3.6700 \times 10^{-6}` |
| | **RK4** | `0.000001` | `6.0890 \times 10^{-6}` |

---

### Accuracy Improvement Analysis ($h = 1.00 \rightarrow h = 0.25$)

Reducing the step size from $1.00$ to $0.25$ produced significant improvements in solution accuracy across both numerical solvers:

* **Modified Euler (Heun's Method) Error Reduction:** **`93.96%`** drop in average absolute error (from `0.050631` to `0.003058`).
* **RK4 Error Reduction:** **`94.36%`** drop in average absolute error (from `0.000017` down to near-exact `0.000001`).

---

### Key Observations & Discussion

* **RK4 Superiority:** Even at a larger step size ($h = 1.00$), RK4 achieves an average absolute error of just `0.000017`—outperforming Modified Euler at $h = 0.25$ by two orders of magnitude with minimal computational overhead.
* **Trade-off between Step Size & Speed:** Transitioning to $h = 0.25$ increases the step count fourfold, slightly increasing execution times, yet both methods execute in microseconds ($\approx 3.6 - 6.0\ \mu\text{s}$), making RK4 with $h = 0.25$ the optimal choice for precision.
