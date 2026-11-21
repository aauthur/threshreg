
<!-- README.md is generated from README.Rmd. Please edit that file. -->

# threshreg

## Overview

`threshreg` is an R package for fitting negative binomial regression
models on data subject to a known lower reporting threshold. Rather than
discarding censored observations or naively interpreting them, the
package incorporates the information that their underlying counts fall
below the threshold into the likelihood function. The package supports
both tabular and network data, with the latter represented using
matrices of observed counts and covariates.

## Installation

The development version of `threshreg` can be installed from GitHub:

``` r
install.packages("remotes")
remotes::install_github("aauthur/threshreg")
```

## Development Status

The goal is to complete the core functionality of the package by the
24th, and then use the remainder of the time to work on preparing the
presentation and constructing interesting and illuminative examples.

Currently, I have implemented the censor.R functions and associated
testing, the modified negative log likelihood helper that is central to
the package’s logic, a working prototype of the threshreg fit function
on tabular data, and I have implemented some simulations in
test-threshreg.R (these will likely need to be moved to a more
appropriate place). I still need to implement the methods.R functions to
make threshreg function objects analogous to other regression packages,
the network analog of the tabular function, and clean everything up.

After the fundamental logic and testing has been implemented, I will
work on some visual examples (analogous to what is currently in the
test-threshreg.R file). These will become part of my presentation.

## AI Use

ChatGPT in browser was used to help code ROxygen function descriptions
based on informal descriptions, to create the plots in test-threshreg.R,
and to help with argument validation for core threshreg function on
tabular data.

Google search AI was used to explain the syntax for optim function
utilized in threshreg.R for the core tabular function.
