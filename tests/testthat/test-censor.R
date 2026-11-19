
mat <- matrix(c(3, 4, 5, 6, 7, 8), nrow = 2)

test_that("Censoring matrix works", {
  #Unchanged when all entries above or equal to threshold.
  expect_equal(censor_matrix(mat, 3), mat)
  #All zero when all entries below threshold.
  expect_equal(censor_matrix(mat, 9), matrix(rep(0, 6), nrow = 2))
  #Ordinary threshold behaves correctly.
  expect_equal(censor_matrix(mat, 6), matrix(c(0, 0, 0, 6, 7, 8), nrow = 2))

  #Argument validation:
  expect_error(censor_matrix(mat, "a"))
  expect_error(censor_matrix(3, 4))
})

df <- data.frame(
  "X1" = c(1,2,3,4),
  "X2" = c(2,3,4,5)
)


test_that("Censoring dataframe works", {
  #Unchanged when all entries above or equal to threshold.
  expect_equal(censor_data(cars, "speed", min(cars$speed)), cars)
  #All zero when all entries below threshold.
  expect_equal(censor_data(cars, "speed", max(cars$speed)+1)[["speed"]], rep(0, length(cars$speed)))
  #Ordinary threshold behaves correctly.
  expect_equal(censor_data(df, "X1", 2),
               data.frame(
                 "X1" = c(0,2,3,4),
                 "X2" = c(2,3,4,5)
               ))
  expect_equal(censor_data(df, "X2", 4),
               data.frame(
                 "X1" = c(1,2,3,4),
                 "X2" = c(0,0,4,5)
               ))

  #Argument validation
  expect_error(censor_data(df, "X2", "a"))
  expect_error(censor_data(df, "X3", 4))
  expect_error(censor_data("df", "X2", "a"))

})
