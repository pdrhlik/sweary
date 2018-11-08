library(purrr)
library(readr)
library(stringr)
library(dplyr)

lang_files <- list.files("data-raw/swear-word-lists/", full.names = TRUE)
swear_words <- purrr::map_df(lang_files, load_lang_from_file)

usethis::use_data(swear_words, overwrite = TRUE)
