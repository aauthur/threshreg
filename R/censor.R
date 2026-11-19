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
  if (!is.matrix(M) || !is.numeric(lower)) {
    stop("Invalid arguments.")
  }
  #1 if M_ij >= lower, 0 otherwise.
  mask <- (M >= lower)*1
  return(M*mask)
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
  if (!is.data.frame(data) || !is.numeric(lower) || !is.character(response)) {
    stop("Invalid argument types.")
  }
  if (is.null(data[[response]])) {
    stop("Specified response not present in data.")
  }

  mask <- (data[[response]] >= lower)*1
  data[[response]] <- data[[response]]*mask
  return(data)
}


