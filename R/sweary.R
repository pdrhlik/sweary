#' sweary: A database of swear words from multiple languages
#'
"_PACKAGE"

#' Data frame of swear words
#'
#' A dataset containing a list of swear words across multiple
#'   languages.
#'
#' \describe{
#'   \item{word}{A swear word.}
#'   \item{language}{A character code of the language the swear word
#'     is recorded in.}
#' }
#'
#' @docType data
#' @format A data frame with 96 rows and 2 variables.
"swear_words"

## Deletes R CMD check NOTES for '.', '%>%' and '.data'.
utils::globalVariables(c(".", "%>%", ".data"))
