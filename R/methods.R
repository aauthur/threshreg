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

}

#' Summarize a Thresholded Regression Model
#'
#' Produces a summary of a fitted thresholded negative
#' binomial regression model, including parameter estimates,
#' and convergence information.
#'
#' @param object An object of class `threshreg`.
#'
#' @return A list containing summary information about
#'   the fitted model.
#'
#' @export
summary.threshreg <- function(object) {

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
