# Interpolation and Curve Fitting of Noisy Exponential Data

This repository contains MATLAB implementations for analyzing noisy exponential sample data using interpolation techniques (**Lagrange** and **Newton**) and regression-based curve fitting (**Least-Squares Exponential Fit**). 

The goal is to estimate intermediate values ($x = 1.2$ and $x = 1.8$) and compare the accuracy and behavior of interpolation versus curve fitting against the true function $f(x) = e^x$.

---

## 💡 Given Data

The noisy data samples are generated from $f(x) = e^x + \text{noise}$:

| $x$ | $y = e^x + \text{noise}$ |
| :---: | :---: |
| **0.0** | `1.0497` |
| **0.5** | `1.6129` |
| **1.0** | `2.7281` |
| **1.5** | `4.4003` |
| **2.0** | `7.2978` |

---

## ⚙️ Tasks & Methodology

### Part 1: Lagrange Interpolation
* Implemented via `lagrange\_interp(x, y, xp)` to compute interpolated values at query points `xp`.
* Estimates values at $x = 1.2$ and $x = 1.8$.
* Plots the interpolating polynomial across $[0, 2]$, original data points, true function $f(x) = e^x$, and estimated points.

### Part 2: Newton Interpolation
* Implemented via `newton\_interp(x, y, xp)` using divided differences.
* Estimates values at $x = 1.2$ and $x = 1.8$.
* Compares the resulting polynomial visually with Lagrange and true exponential curves.

### Part 3: Least-Squares Curve Fitting
* Fits the data to an exponential model of the form:
  $$f(x) = a \cdot e^{bx}$$
* Evaluates fitted values at $x = 1.2$ and $x = 1.8$.

### Part 4: Error Analysis & Discussion
* Calculates **Absolute Error** at test points ($x = 1.2, 1.8$):
  $$\text{Absolute Error} = |y_{\text{estimated}} - e^x|$$
* Evaluates performance based on:
  1. Estimation accuracy relative to true $e^x$.
  2. Polynomial oscillation near and between noisy data points.
  3. Method robustness when dealing with noise and extrapolation.


## 📊 Summary of Results

| Target Point ($x$) | True Value ($e^x$) | Lagrange Interp. | Newton Interp. | Least-Squares Fit |
| :---: | :---: | :---: | :---: | :---: |
| **1.2** | `3.3201` | *Result* | *Result* | *Result* |
| **1.8** | `6.0496` | *Result* | *Result* | *Result* |
