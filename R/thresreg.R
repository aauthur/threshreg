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
#' @param lower A positive integer specifying the reporting threshold.
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
