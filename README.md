# Economics-Thesis
An Empirical Comparison of the Dependence of Conditional Volatility Parameter for Short-term Interest Rate Models

## Overview

This repository contains an implementation of financial models designed for forecasting short-term interest rates. The core focus of this tool is to leverage historical monthly observations of 90-day constant maturity treasury bill rates and AA commercial paper rates to evaluate the dynamics of interest rate behavior. Specifically, this tool contrasts two distinct models:

1. A model applying the elasticity of volatility with respect to interest rate levels, based on the framework proposed by Chan et al. (1992).
2. A model centered around the concept of volatility clustering - a phenomenon where large changes tend to be grouped together over time, elaborated by Mandelbrot (1963).

By analyzing these models, this tool aims to provide insights on whether interest rates become more volatile with rising interest rates or if periods of heightened volatility are sporadic among times of stability. Additionally, it examines the impact of monetary policy on volatility, estimates parameters for slightly riskier assets, and draws conclusions based on these models' parameter estimates.

## Features

- Monthly observations loading and preprocessing module.
- Implementation of the Chan et al. (1992) model for elasticity of volatility.
- Implementation of the Mandelbrot (1963) volatility clustering model.
- GARCH effects incorporation for improved forecasting accuracy.
- Analysis module for evaluating the impact of monetary policy on interest rate volatility.
- Parameter estimation module for riskier assets comparison.
- Comprehensive comparison between the two interest rate dynamics models.
