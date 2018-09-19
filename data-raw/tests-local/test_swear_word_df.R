context("Swear word data frame")

test_that("swear word data frame exists", {
	expect_true(exists("swear_words"))
})

test_that(paste("swear word df contains all raw data"), {
	n_lang_df <- length(unique(sweary::swear_words$language))
	n_lang_files <- length(swear_word_files)

	expect_equal(n_lang_df, n_lang_files)

	n_words <- purrr::map_dbl(swear_word_files, function(f) {
		length(readLines(f))
	}) %>% sum()

	expect_equal(n_words, nrow(sweary::swear_words))
})
