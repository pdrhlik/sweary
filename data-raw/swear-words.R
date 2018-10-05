library(purrr)
library(readr)
library(stringr)
library(dplyr)

load_lang <- function(lang_file) {
	suppressMessages(
		words <- readr::read_csv(lang_file, col_names = c("word"))
	)
	lang <- stringr::str_extract(lang_file, "[\\w-]+$")

	words$language <- lang

	return(words)
}

lang_files <- list.files("data-raw/swear-word-lists/", full.names = TRUE)
swear_words <- purrr::map_df(lang_files, load_lang)

devtools::use_data(swear_words, overwrite = TRUE)
