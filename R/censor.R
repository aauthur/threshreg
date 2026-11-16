#' Apply Lower-Threshold Censoring to a Matrix
#'
#' Applies a known lower reporting threshold to a matrix of
#' fully observed data. All entries below the threshold
#' are replaced with zero.
#'
#' @param M A matrix containing nonnegative integer counts.
#' @param lower A positive integer specifying the reporting threshold.
#'
#' @return A matrix with the same dimensions as `M`, with
#'   all entries strictly below `lower` replaced by zero.
#'
#' @export
censor_matrix <- function(M, lower) {

}



#' Apply Lower-Threshold Censoring to Tabular Data
#'
#' Applies a known lower reporting threshold to a specified
#' response variable in a data frame. All observations below the
#' threshold are replaced with zero. Other columns are unchanged.
#'
#' @param data A data frame containing the response variable.
#' @param response A character string specifying the name of
#'   the variable to be censored.
#' @param lower A positive integer specifying the reporting threshold.
#'
#' @return A data frame with the specified response variable
#'   censored according to the reporting threshold.
#'
#' @export
censor_data <- function(data, response, lower) {

}
