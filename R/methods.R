#' Print a Thresholded Regression Model
#'
#' Prints a concise summary of a fitted thresholded
#' negative binomial regression model.
#'
#' @param x An object of class `threshreg`.
#'
#' @return The fitted model object, invisibly.
#'
#' @export
print.threshreg <- function(x) {
  cat("Thresholded Negative Binomial Regression Summary\n\n")

  cat("Coefficient estimates:\n")
  print(x$coefficients)

  cat("\nSize parameter:", x$size, "\n")
  cat("Reporting threshold:", x$lower, "\n")
  cat("Log-likelihood:", x$logLik, "\n")
  cat("Convergence code:", x$convergence, "\n")

  invisible(x)
}


#' Predict from a Thresholded Regression Model
#'
#' Computes predicted mean counts from a fitted thresholded
#' negative binomial regression model.
#'
#' @param object An object of class `threshreg`.
#' @param newdata An optional data frame containing covariates
#'   for prediction. If NULL, the original fitted observations
#'   are used.
#'
#' @return A numeric vector of predicted means for models fitted
#'   using `threshreg()`, or a matrix of predicted means for models
#'   fitted using `threshreg_network()`.
#'
#' @export
predict.threshreg <- function(object, newdata = NULL) {

}
