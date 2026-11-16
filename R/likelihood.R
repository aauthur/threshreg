#' Compute the Negative Log-Likelihood
#'
#' Evaluates the negative log-likelihood of the
#' lower-threshold censored negative binomial model.
#'
#' @param theta A numeric vector containing the regression
#'   coefficients (beta) and the logarithm of the
#'   negative binomial size parameter.
#' @param X The regression design matrix.
#' @param z A numeric vector of observed responses, with
#'   zero or NA indicating censored observations.
#' @param lower A positive integer specifying the
#'   reporting threshold.
#'
#' @return The negative log-likelihood evaluated at theta.
.nll_nb <- function(theta, X, z, lower) {

}
