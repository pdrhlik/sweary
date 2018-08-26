context("Raw swear word files")

swear_word_folder <- "../../data-raw/swear-word-lists"
swear_word_files <- list.files(swear_word_folder, full.names = TRUE)

#' Extracts file name from a file path.
#'
#' It splits a file path using a platform specific directory
#' separator, unlists the results and returns the last element
#' of the vector.
#'
#' @param file_path Character file path.
#' @param ds Directory separator that defaults to a platform default.
#'
#' @return Character file name.
file_name <- function(file_path, ds = .Platform$file.sep) {
	ret <- unlist(strsplit(file_path, ds))
	ret <- ret[length(ret)]

	return(ret)
}

test_that("swear word lists folder exists", {
	expect_true(file.exists(swear_word_folder))
})

purrr::walk(swear_word_files, function(swear_word_file) {
	lang <- file_name(swear_word_file)
	f <- readLines(swear_word_file, encoding = "UTF-8")

	test_that(paste(lang, "file is sorted"), {
		expect_equal(f, sort(f))
	})

	test_that(paste(lang, "file is lowercase"), {
		expect_equal(f, tolower(f))
	})

	test_that(paste(lang, "file contains unique words"), {
		expect_equal(f, unique(f))
	})
})
