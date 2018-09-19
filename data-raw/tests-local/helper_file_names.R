library(testthat)
library(sweary)
library(dplyr)
library(purrr)

# Test variables
swear_word_folder <- system.file("swear-word-lists", package = "sweary")
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
