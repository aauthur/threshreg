#Since this is an internal helper function, we don't need to be super careful about argument validation.
#Instead let's focus on some simple test cases.
test_that("Likelihood equals hand computed value.", {
for (i in c(1:100)) {
  #No observations censored.
  theta1 <- c(log(2),1,log(2))
  X1 <- cbind(rep(1, 100), rnorm(100, 1, 3))
  z1 <- rep(3, 100)
  lower1 <- 2

  ll1 <- -sum(dnbinom(z1, mu = as.vector(exp(X1 %*% theta1[1:2])), size = exp(theta1[3]), log = TRUE))
  expect_equal(.nll_nb(theta1, X1, z1, lower1), ll1)

  #Half observations censored (test 0 and NA censorship)
  theta2 <- c(log(2),1,log(2))
  X2 <- cbind(rep(1, 100), rnorm(100, 1, 3))
  z2 <- c(rep(3, 50), rep(0, 50))
  #Also test it works with NA instead of zeros
  z2na <- c(rep(3, 50), rep(NA, 50))
  lower2 <- 2

  mu2 = as.vector(exp(X2 %*% theta2[1:2]))

  ll2 <- -sum(dnbinom(z2[1:50], mu = mu2[1:50], size = exp(theta2[3]), log = TRUE)) -
    sum(pnbinom(lower2 - 1, mu = mu2[51:100], size = exp(theta2[3]), log.p = TRUE))
  expect_equal(.nll_nb(theta2, X2, z2, lower2), ll2)
  expect_equal(.nll_nb(theta2, X2, z2na, lower2), ll2)
}
  })
