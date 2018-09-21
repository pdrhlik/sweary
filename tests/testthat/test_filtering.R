context("Filtering tools")

test_that("filtering a language works", {
	lang_code <- "en"
	lang <- get_swearwords(lang_code)

	expect_gt(nrow(lang), 0)
	expect_equal(lang_code, unique(lang$language))
})

test_that("filtering a non-existent language doesn't work", {
	expect_error(get_swearwords("non-existent"))
})
