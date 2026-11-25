#I want to run two essential tests: 1. that in the absence of censoring our fitted model
#agrees with MASS negative binomial fit, and 2. That in the presence of censoring, our fitted
#model works better, that is results in coefficient estimates closer to the true coefficients.



test_that("Threshreg agrees with MASS NB fit without censoring.",
{

set.seed(42)

#Number of simulations:
N <- 50

for (i in c(1:N)) {
  #Here I'm just copying the logic from above, but this time I will use random coefficients and means and stuff to
  #simulate a variety of settings.

  #Generate some random covariates
  X1 <- matrix(data=rnorm(1000, 0, 2), nrow = 100)
  X2 <- matrix(data=rnorm(1000, 0, 3), nrow = 100)

  #Simulate response
  true_beta <- c(log(runif(1, 8, 12)), rnorm(1, 0, sd= 0.2), rnorm(1, 0, sd= 0.2))
  true_r <- runif(1, 2, 8)

  eta <- true_beta[1] + true_beta[2]*X1 + true_beta[3]*X2

  mu <- exp(eta)

  Y <- matrix(
    data = rnbinom(1000, size = true_r, mu = as.vector(mu)),
    nrow = 100
  )

  mass_fit <- MASS::glm.nb(
    as.vector(Y) ~ as.vector(X1) + as.vector(X2)
  )

  df <- data.frame(
    "Y" = as.vector(Y),
    "X1" = as.vector(X1),
    "X2" = as.vector(X2)
  )

  fit_threshreg <- threshreg(Y ~ X1 + X2, df, lower = 0)

  #Test that parameters agree between the two fits (beta vec and the size parameter).
  expect_equal(unname(fit_threshreg$coefficients), unname(mass_fit$coefficients), tolerance = 1e-3)
  expect_equal(fit_threshreg$size, mass_fit$theta, tolerance = 1e-2)

}
})

test_that("Threshreg improves on MASS NB fit in the pressence of censoring at least 90% of the time.",
          {

            set.seed(18)

            #Number of simulations:
            N <- 50

            beta_win <- rep(0, N)
            size_win <- rep(0, N)

            for (i in c(1:N)) {
              #Here I'm just copying the logic from above, but this time I will use random coefficients and means and stuff to
              #simulate a variety of settings.

              #Generate some random covariates
              X1 <- matrix(data=rnorm(1000, 0, 2), nrow = 100)
              X2 <- matrix(data=rnorm(1000, 0, 3), nrow = 100)

              #Simulate response
              true_beta <- c(log(runif(1, 8, 12)), rnorm(1, 0, sd= 0.2), rnorm(1, 0, sd= 0.2))
              true_r <- runif(1, 2, 8)
              #Need to pick a reasonable threshold otherwise MASS may not converge...
              #This limitation of a naive fit will be explored in the vignette simulation.
              threshold <- sample(3:5, 1)

              eta <- true_beta[1] + true_beta[2]*X1 + true_beta[3]*X2

              mu <- exp(eta)

              Y <- matrix(
                data = rnbinom(1000, size = true_r, mu = as.vector(mu)),
                nrow = 100
              )

              censored_Y <- censor_matrix(Y, threshold)

              mass_fit <- MASS::glm.nb(
                as.vector(censored_Y) ~ as.vector(X1) + as.vector(X2)
              )

              df <- data.frame(
                "Y" = as.vector(censored_Y),
                "X1" = as.vector(X1),
                "X2" = as.vector(X2)
              )

              fit_threshreg <- threshreg(Y ~ X1 + X2, df, lower = threshold)

              beta_mse_mass <- sum((unname(mass_fit$coefficients) - true_beta)^2)
              beta_mse_threshreg <- sum((unname(fit_threshreg$coefficients) - true_beta)^2)

              if (beta_mse_threshreg < beta_mse_mass) {
                beta_win[i] <- 1
              }

              size_mse_mass <- (mass_fit$theta - true_r)^2
              size_mse_threshreg <- (fit_threshreg$size - true_r)^2

              if (size_mse_threshreg < size_mse_mass) {
                size_win[i] <- 1
              }


            }
            #Expect that threshreg wins at least 90% of the time.
            expect_gt(sum(beta_win)/N, 0.90)
            expect_gt(sum(size_win)/N, 0.90)
          })
