context("Raw swear word files")

test_that("swear word lists folder exists", {
	expect_true(file.exists(swear_word_folder))
})

purrr::walk(swear_word_files, function(swear_word_file) {
	lang <- file_name(swear_word_file)
	f <- readLines(swear_word_file, encoding = "UTF-8")

	test_that(paste(lang, "file is sorted"), {
		expect_equal(f, sort(f, method = "shell"))
	})

	test_that(paste(lang, "file is lowercase"), {
		expect_equal(f, tolower(f))
	})

	test_that(paste(lang, "file contains unique words"), {
		expect_equal(f, unique(f))
	})

	test_that(paste(lang, "file doesn't contain multi-word phrases and trailing whitespace"), {
		expect_equal(f, stringr::str_replace_all(f, "\\s", ""))
	})
})
