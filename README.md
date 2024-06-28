# Finite Difference Methods for Option Pricing

This repository contains a collection of MATLAB functions designed to price various types of options using finite difference methods and iterative solvers. 

## Contents

- **AmerPutImplicit.m**: Prices American put options using an implicit finite difference method.
- **EurPutImplicit.m**: Prices European put options using an implicit finite difference method.
- **EurPutExplicit.m**: Prices European put options using an explicit finite difference method.
- **DwnOutPutCN.m**: Prices down-and-out put options using the Crank-Nicolson method.
- **AmerPutCN.m**: Prices American put options using the Crank-Nicolson method.
- **SORGaussSeidel.m**: An iterative solver using the SOR Gauss-Seidel method, enhancing the efficiency and convergence of solutions in financial models that require solving linear systems of equations.

## Numerical Methods Used

### Finite Difference Methods

These methods solve the partial differential equations commonly found in financial derivatives pricing:

- **Explicit Method**: Computes future pricing values directly from the known values at the current time step. It's fast but requires small time steps to maintain stability.
- **Implicit Method**: Uses future values to determine the values at the next time step, involving solving a system of equations. It's stable but computationally intensive.
- **Crank-Nicolson Method**: Averages the explicit and implicit methods, striking a balance between stability, accuracy, and computational efficiency.

### Iterative Solvers

- **SOR Gauss-Seidel Method**: Enhances the convergence of traditional Gauss-Seidel methods by using a relaxation factor. This method is particularly useful for the implicit and Crank-Nicolson methods, where the stability and speed of convergence are crucial.

## Additional Info: Finite Difference Methods Overview

Finite difference methods approximate the derivatives in differential equations by replacing them with differences computed from function values at discrete points. These methods transform continuous differential equations into a system of algebraic equations that can be solved using numerical techniques.

### Explicit Finite Difference Method

- How it works: The explicit method uses the function values at the current time step to compute the function values at the next time step.

- Stability and Speed: This method is generally faster because it involves simpler calculations. However, it has stability constraints (determined by the Courant-Friedrichs-Lewy condition) that require small time steps for stable solutions, particularly in problems involving high volatility or longer time frames.

- Example Usage: In option pricing, it is typically used where quick computation is needed, and stability can be managed with appropriately small steps.

### Implicit Finite Difference Method

- How it works: Unlike the explicit method, the implicit method uses the function values at the next time step to compute those values. This typically involves solving a system of linear equations at each time step.

- Stability and Complexity: Implicit methods are unconditionally stable for linear problems, allowing larger time steps without the solution becoming unstable. However, they are computationally more intensive since they often require matrix inversions or solving linear systems at each step.

- Example Usage: This method is favored in scenarios where stability is a priority over computational speed, such as deep market scenarios or long maturity derivatives.

### Crank-Nicolson Method

- How it works: The Crank-Nicolson method is a popular finite difference technique that averages the explicit and implicit methods. It uses function values from both the current and next time steps to compute values at the next step, formulated as a weighted average of the explicit and implicit approximations.

- Stability and Accuracy: It offers a good balance between stability and computational intensity, being more stable than explicit methods and generally more accurate than both explicit and implicit methods. It is also second-order accurate in time, providing a more precise solution with fewer time steps.

- Example Usage: Widely used for pricing American options and exotic options where both stability and accuracy are critical

## Additional Info: Successive Over-Relaxation (SOR) Gauss-Seidel Method Overview

- How it works: SOR is an enhancement of the traditional Gauss-Seidel method, introducing a relaxation factor (`ω` or `w`) to accelerate convergence. The method iteratively updates the solution by blending the new solution estimate with the previous iteration's value based on the relaxation factor. 

- *tability and Speed: By carefully choosing `ω`, the SOR method can converge significantly faster than standard iterative methods like Gauss-Seidel or Jacobi, especially in systems where the matrix is large and sparse.

- Example Usage: It is particularly effective in scenarios involving implicit and Crank-Nicolson finite difference methods, where the resulting linear systems may be challenging to solve due to their size or conditioning. The SOR method is used to quickly find stable solutions in complex option pricing models, such as those for American options or exotic derivatives.
