# Linear System Solvers: Gaussian Elimination vs. Jacobi Method

This repository contains MATLAB implementations of two different numerical approaches to solve a $4 \times 4$ system of linear equations ($Ax = b$):
1. **Gaussian Elimination** (Direct method to find the exact solution)
2. **Jacobi Iterative Method** (Iterative method to find an approximate solution)

The repository also includes error analysis evaluating the performance of the iterative solver using Euclidean norms.

---

## 💡 Problem Description

We solve the following $4 \times 4$ system of linear equations:

$$\begin{aligned}
10x_1 - 2x_2 + x_3 + 3x_4 &= 27 \\
-3x_1 + 8x_2 - x_3 + 2x_4 &= -14 \\
x_1 - 2x_2 + 9x_3 - x_4 &= 8 \\
2x_1 + x_2 - 3x_3 + 7x_4 &= -3
\end{aligned}$$

Expressing this in matrix form $Ax = b$:

$$A = \begin{bmatrix} 10 & -2 & 1 & 3 \\ -3 & 8 & -1 & 2 \\ 1 & -2 & 9 & -1 \\ 2 & 1 & -3 & 7 \end{bmatrix}, \quad b = \begin{bmatrix} 27 \\ -14 \\ 8 \\ -3 \end{bmatrix}$$

---

## ⚙️ Tasks & Methodology

### 1. Direct Solution (`xg`)
* Solved using **Gaussian Elimination** (or MATLAB's direct solver `A \ b`).
* Resulting exact solution vector is stored as `xg`.

### 2. Iterative Solution (`xj`)
* Solved using **Jacobi Iteration Method**.
* **Stopping Criterion:** Tolerance threshold of $10^{-6}$ (e.g., $\|x^{(k+1)} - x^{(k)}\|_2 < 10^{-6}$).
* Resulting approximate solution vector is stored as `xj`.

### 3. Error Analysis
The methods are compared using Euclidean $L_2$ norm metrics:

* **Relative Error (`err_rel`):**
  $$\text{err\_rel} = \frac{\|x_{\text{Jacobi}} - x_{\text{Gaussian}}\|_2}{\|x_{\text{Gaussian}}\|_2}$$

* **Residual Error (`err_res`):**
  $$\text{err\_res} = \|A x_{\text{Jacobi}} - b\|_2$$


---

## 📊 Expected Output Variables

Upon running `main.m`, the workspace generates the following key variables:

| Variable | Description |
| :--- | :--- |
| `xg` | Solution vector obtained via Gaussian Elimination |
| `xj` | Approximate solution vector obtained via Jacobi Iteration |
| `err_rel` | Relative error using Euclidean norm |
| `err_res` | Residual error $\|Ax - b\|_2$ of the Jacobi solution |
