#' Fit Thresholded Negative Binomial Regression
#'
#' Fits a negative binomial regression model on count data subject
#' to a known reporting threshold; that is, counts are only reported
#' when they are greater than or equal to some positive integer L.
#' The information provided by censored observations is incorporated
#' into the fit.
#'
#' @param formula A formula specifying the response variable and
#'   the covariates.
#' @param data A data frame containing the response variable and
#'   covariates.
#' @param lower A positive integer specifying the reporting threshold. Wheen passed as
#' zero, this is interpreted as an uncensored problem, i.e. ordinary negative binomial regression.
#'
#' @details
#' Response values are interpreted as follows:
#' * `0` or `NA`: Censored observation. The true count is known
#'   to be strictly less than `lower`.
#' * Values greater than or equal to `lower`: Interpreted directly.
#' * Positive values below `lower`: Invalid observations that
#'   cause an error.
#'
#'
#' @return An object of class `threshreg` containing the estimated
#'   regression coefficients, dispersion parameter, fitted means,
#'   maximized log-likelihood, and convergence information.
#'
#' @export
threshreg <- function(formula, data, lower) {

  # Argument parsing and validation:

  if (!inherits(formula, "formula") || length(formula) != 3L) {
    stop("'formula' must be a two-sided R formula.")
  }

  if (!is.data.frame(data)) {
    stop("'data' must be a data frame.")
  }

  # Validate variables referenced by formula
  missing_vars <- setdiff(all.vars(formula), names(data))

  if (length(missing_vars) > 0) {
    stop("Variables not found in data: ",
         paste(missing_vars, collapse = ", "))
  }

  # Construct model inputs
  mf <- model.frame(formula, data = data, na.action = na.pass)

  z <- model.response(mf)

  # Check response and covariates
  if (!is.numeric(z)) {
    stop("Response must be numeric.")
  }

  if (anyNA(mf[-1L])) {
    stop("Covariates cannot contain missing values.")
  }

  X <- model.matrix(formula, data = mf)

  if (any(!is.finite(X))) {
    stop("Design matrix contains non-finite values.")
  }

  #Threshold validation

  if (!is.numeric(lower) || length(lower) != 1L ||
      !is.finite(lower) || lower < 0) {
    stop("'lower' must be a single non-negative finite number.")
  }

  if (lower != floor(lower)) {
    warning("Non-integer reporting threshold for count data.")
  }


  #More detailed response validation (We need the response variable to be count data, i.e. integers, need to make sure
  #that it's consistent with the reporting rule):

  # NAs are one way to interpret censored observations, we will check 0s separately.
  observed <- z[!is.na(z)]

  if (any(!is.finite(observed)) ||
      any(observed < 0) ||
      any(observed != floor(observed))) {
    stop("Responses must be nonnegative integer counts or NA.")
  }

  #Check that there are no values which violate the specified reporting rule.
  if (any(observed > 0 & observed < lower)) {
    stop("Positive observed counts cannot be below the reporting threshold.")
  }

  #I want to allow lower == 0, i.e. no censorship, that way we can compare to normal NB regression from other libraries.
  #But if we have lower == 0, then it doesn't make sense for ANY count data to be censored, so in this case, we guard against NAs.
  if (lower == 0 && anyNA(z)) {
    stop("NA responses are not allowed when lower = 0.")
  }


  #Core logic: We use optim to find the optimal parameters that minimize the modified likelihood.

  #Initialize parameter vector
  theta <- c(rep(0, ncol(X)))
  #Initialize log of dispersion parameter. Higher values -> more like the poisson distribution.
  #We avoid setting this parameter too low (for r = e^this \in (0, 1), variance increases a lot, so we start modestly).
  theta <- c(theta, log(1.25))

  res <- optim(
    par = theta,
    fn = function(par) .nll_nb(par, X = X, z = z, lower = lower),
    method = "BFGS"
  )

  return(res)

}





#' Fit Thresholded Negative Binomial Regression on Network Data
#'
#' Fits a thresholded negative binomial regression model on network
#' count data represented by a matrix. The model may include row-level,
#' column-level, and edge-level covariates.
#'
#' @param M A matrix of observed counts. Zero and NA entries are
#'   interpreted as censored observations.
#' @param covariates A list containing up to three named lists:
#'   `row`, `col`, and `edge`. Row-level covariates are vectors
#'   of length `nrow(M)`, column-level covariates are vectors of
#'   length `ncol(M)`, and edge-level covariates are matrices
#'   with the same dimensions as `M`.
#' @param lower A positive integer specifying the reporting threshold.
#'
#' @details
#' Row-level and column-level covariates are internally expanded
#' to match the dimensions of `M`. The resulting data are converted
#' to tabular form and passed to `threshreg()`.
#'
#' An intercept is included automatically. Covariate names must
#' be unique across all three groups.
#'
#' @return An object of class `threshreg` containing the fitted
#'   regression model. Predictions retain the dimensions of `M`.
#'
#' @export
threshreg_network <- function(M, covariates, lower) {

}
