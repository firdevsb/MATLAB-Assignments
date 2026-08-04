# Root Finding Algorithms in MATLAB 

This repository contains MATLAB implementations of two fundamental numerical root-finding algorithms: **Newton’s Method** and **Fixed-Point Iteration**.

---

## 💡 Problem Statement

We aim to find the root of the non-linear equation:

f(x) = x^3 + 3x - 5 = 0

---

## ⚙️ Implemented Methods & Tasks

### Part A: Newton’s Method
Newton’s Method finds the root iteratively using the function derivative:

x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}

* **Test Function:** f(x) = x^3 + 3x - 5
* **Derivative:** f'(x) = 3x^2 + 3
* **Parameters:** x_0 = 1, `tol` = 10^{-6}, `max_iter` = 50

---

### Part B: Fixed-Point Iteration
The equation f(x) = 0 is rearranged into the form x = g(x):

g(x) = \sqrt[3]{5 - 3x}

* **Convergence Criterion:** The method converges near the root if |g'(x)| < 1.
* **Parameters:** x_0 = 1, `tol` = 10^{-6}, `max_iter` = 100

---

## 📁 Repository Structure

* `Newtons_Method.m` — Generic implementation of Newton's Method.
* `Fixed_Point_Iterations.m` — Generic implementation of Fixed-Point Iteration.

---

## 📊 Results & Comparison

Executing `main.m` produces the following outputs:

| Metric | Newton's Method | Fixed-Point Iteration |
| **Calculated Root** | `1.154171` | `1.154172` |
| **Iterations Needed** | **4** | **45** |
| **Convergence Status** | Fast (Quadratic) | $|g'(\text{root})| \approx 0.7507 < 1$ (Linear) |

### Key Takeaway
Newton’s Method converges significantly faster (4 iterations) compared to Fixed-Point Iteration (45 iterations) for this specific problem due to the usage of derivative information.
