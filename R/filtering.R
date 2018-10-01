#' Get swear words for one language
#'
#' @description If the language doesn't exist yet, it throws
#' an error. Otherwisee it returns a filtered
#' \code{swear_words} data frame.
#'
#' @param lang_code \href{https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes}{ISO 639-1}
#'   two letter language code.
#'
#' @return Data frame of swear words of one language.
#' @export
#' 
#' @importFrom attempt stop_if_not
#' @importFrom glue glue
#'
#' @examples
#' en_swear_words <- get_swearwords("en")
#' head(en_swear_words)
get_swearwords <- function(lang_code) {
  
  check_is_lang(lang_code)

  swear_words[swear_words$language == lang_code, ]
	
}