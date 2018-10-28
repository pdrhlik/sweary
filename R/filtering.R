#' Get swear words for one language
#'
#' @description If the language doesn't exist yet, it throws
#' an error. Otherwise it returns a filtered
#' \code{swear_words} data frame.
#'
#' @param lang_code \href{https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes}{ISO 639-1}
#'   two letter language code.
#'
#' @return Data frame of swear words of one language.
#' @export
#'
#' @examples
#' en_swear_words <- get_swearwords("en")
#' head(en_swear_words)
get_swearwords <- function(lang_code) {
	lang_index <- sweary::swear_words$language == lang_code

	if (sum(lang_index) == 0) {
		stop(glue::glue("'{lang_code}' not part of the package yet. Would you like to add it? :-)"))
	}

	lang <- sweary::swear_words[sweary::swear_words$language == lang_code, ]
	return(lang)
}
