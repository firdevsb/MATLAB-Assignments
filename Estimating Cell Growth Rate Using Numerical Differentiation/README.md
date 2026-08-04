# Estimating Cell Growth Rate Using Numerical Differentiation

This repository contains MATLAB implementations to estimate the instantaneous growth rate ($\frac{dC}{dt}$) of mammalian cells in a batch bioreactor over a 12-hour period. 

Finite difference methods (**Forward**, **Backward**, and **Central Differences**) are applied to experimental cell concentration data and compared against a ground-truth bioprocess model.

---

## 💡 Problem Statement

Mammalian cell concentration $C(t)$ (in $10^6 \text{ cells/mL}$) was recorded at discrete $\Delta t = 2 \text{ hr}$ intervals:

| Time $t$ (hr) | Cell Concentration $C(t)$ ($10^6 \text{ cells/mL}$) |
| :---: | :---: |
| **0** | `0.649` |
| **2** | `0.975` |
| **4** | `2.000` |
| **6** | `3.370` |
| **8** | `4.340` |
| **10** | `6.280` |
| **12** | `9.260` |

### Analytical Model (Ground Truth)
The underlying bioprocess model for cell growth is defined as:

$$C(t) = C_0 \cdot \left(1 + \frac{r \cdot t}{K}\right)^K$$

Where:
* $C_0 = 0.5 \times 10^6 \text{ cells/mL}$ (Initial concentration)
* $r = 0.4$ (Growth rate parameter)
* $K = 3$ (Model constant)

---

## ⚙️ Tasks & Methodology

### 1. Numerical Growth Rate Estimation at $t = 6\text{ hr}$
Using a step size of $h = 2\text{ hr}$, the derivative $\frac{dC}{dt}\Big|_{t=6}$ is computed using:

* **(a) Forward Difference:**
  $$\frac{dC}{dt} \approx \frac{C(t+h) - C(t)}{h} = \frac{C(8) - C(6)}{2}$$

* **(b) Backward Difference:**
  $$\frac{dC}{dt} \approx \frac{C(t) - C(t-h)}{h} = \frac{C(6) - C(4)}{2}$$

* **(c) Central Difference:**
  $$\frac{dC}{dt} \approx \frac{C(t+h) - C(t-h)}{2h} = \frac{C(8) - C(4)}{4}$$

### 2. Concentration & Growth Rate Overlay Plots
* Plot measured concentration data points ($y$) versus time ($x$).
* Overlay derivative curves for all three numerical finite difference schemes across $t = 0 \text{ to } 12 \text{ hr}$.
* Overlay the continuous analytical model curve across $0 - 12 \text{ hr}$.

### 3. Comparison & Bar Chart Visualization
* Compute the exact analytical derivative $\frac{dC}{dt}\Big|_{t=6}$ from the bioprocess model equation.
* Generate a separate bar chart comparing the analytical derivative against Forward, Backward, and Central difference estimates at $t = 6\text{ hr}$.

---

## 📊 Results & Discussion

### Numerical Comparison ($t = 6\text{ hr}$)

The growth rate estimates ($\frac{dC}{dt}$) at $t = 6\text{ hr}$ obtained from each finite difference method are compared against the exact analytical model derivative ($0.6480 \times 10^6 \text{ cells/mL}\cdot\text{hr}^{-1}$):

| Method | Growth Rate $\frac{dC}{dt}$ ($10^6 \text{ cells/mL}\cdot\text{hr}^{-1}$) | Absolute Error | Relative Error (%) |
| :--- | :---: | :---: | :---: |
| **Analytical (Ground Truth)** | `0.6480` | — | — |
| **Forward Difference** | `0.4850` | `0.1630` | `25.15%` |
| **Backward Difference** | `0.6850` | `0.0370` | `5.71%` |
| **Central Difference** | `0.5850` | `0.0630` | `9.72%` |

---

### Key Observations & Discussion

* **Analytical Baseline:** The exact bioprocess model derivative yields a growth rate of **$0.6480 \times 10^6 \text{ cells/mL}\cdot\text{hr}^{-1}$** at $t = 6\text{ hr}$.
* **Method Performance:**
  * **Backward Difference (`0.6850`):** Produced the closest estimate to the analytical value with the lowest absolute error (`0.0370` / `5.71%`).
  * **Central Difference (`0.5850`):** Achieved a balanced $O(h^2)$ second-order accurate estimate (`0.0630` error), effectively averaging the trend between forward and backward steps.
  * **Forward Difference (`0.4850`):** Underestimated the growth rate due to the sharp slope change in cell concentration immediately following $t = 6\text{ hr}$.
