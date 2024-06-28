# Finite Difference Methods for Option Pricing

This repository contains a collection of MATLAB functions designed to price various types of options using finite difference methods.

## Contents

- **AmerPutImplicit.m**: Prices American put options using an implicit finite difference method.
- **EurPutImplicit.m**: Prices European put options using an implicit finite difference method.
- **EurPutExplicit.m**: Prices European put options using an explicit finite difference method.
- **DwnOutPutCN.m**: Prices down-and-out put options using the Crank-Nicolson method.
- **AmerPutCN.m**: Prices American put options using the Crank-Nicolson method.

## Finite Difference Methods Overview

Finite difference methods approximate the derivatives in differential equations by replacing them with differences computed from function values at discrete points. These methods transform continuous differential equations into a system of algebraic equations that can be solved using numerical techniques.

### Explicit Finite Difference Method

How it works: The explicit method uses the function values at the current time step to compute the function values at the next time step.

Stability and Speed: This method is generally faster because it involves simpler calculations. However, it has stability constraints (determined by the Courant-Friedrichs-Lewy condition) that require small time steps for stable solutions, particularly in problems involving high volatility or longer time frames.

Example Usage: In option pricing, it is typically used where quick computation is needed, and stability can be managed with appropriately small steps.

### Implicit Finite Difference Method

How it works: Unlike the explicit method, the implicit method uses the function values at the next time step to compute those values. This typically involves solving a system of linear equations at each time step.

Stability and Complexity: Implicit methods are unconditionally stable for linear problems, allowing larger time steps without the solution becoming unstable. However, they are computationally more intensive since they often require matrix inversions or solving linear systems at each step.

Example Usage: This method is favored in scenarios where stability is a priority over computational speed, such as deep market scenarios or long maturity derivatives.

### Crank-Nicolson Method

How it works: The Crank-Nicolson method is a popular finite difference technique that averages the explicit and implicit methods. It uses function values from both the current and next time steps to compute values at the next step, formulated as a weighted average of the explicit and implicit approximations.

Stability and Accuracy: It offers a good balance between stability and computational intensity, being more stable than explicit methods and generally more accurate than both explicit and implicit methods. It is also second-order accurate in time, providing a more precise solution with fewer time steps.

Example Usage: Widely used for pricing American options and exotic options where both stability and accuracy are critical
