#' Compute the Negative Log-Likelihood
#'
#' Evaluates the negative log-likelihood of the
#' lower-threshold censored negative binomial model.
#'
#' @param theta A numeric vector containing the regression
#'   coefficients (beta) and the logarithm of the
#'   negative binomial size parameter. A (p+1)x1 vector.
#' @param X The nxp regression design matrix. This will be preprocessed in the case of network data.
#' @param z A numeric vector of observed responses, with
#'   zero or NA indicating censored observations. (nx1) vector.
#' @param lower A positive integer specifying the
#'   reporting threshold.
#'
#' @return The negative log-likelihood evaluated at theta.
.nll_nb <- function(theta, X, z, lower) {
  #Get parameters
  beta <- theta[1:(length(theta) - 1)]
  log_r <- theta[length(theta)]

  #Compute mean (nx1 vector)
  mu <- exp(X %*% beta)

  #Get indices of uncensored/censored values.
  uncensored <- !is.na(z) & z >= lower
  censored <- is.na(z) | z == 0

  #Compute likelihood of uncensored values.
  likelihood_uncensored <- sum(dnbinom(z[uncensored], size = exp(log_r), mu = mu[uncensored], log = TRUE))
  likelihood_censored <- sum(pnbinom((lower - 1), size = exp(log_r), mu = mu[censored], log.p = TRUE))

  return(-likelihood_censored - likelihood_uncensored)
}
