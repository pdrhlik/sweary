context("test-utils")

test_that("error detection works", {
  expect_error(check_is_lang(12))
  expect_null(check_is_lang("en"))
})
