#' Censor a character vector
#'
#' @inheritParams sweary_is
#' @param vec a vector to censor
#' @param with the element to use as a censor mark
#'
#' @return a censored version of the vector
#' @export
#'
#' @examples
#' vec <- c("Yeah, nigga, we're still fucking with you, Still waters run deep ,Still Snoop Dogg and D.R.E. '99, nigga, guess who's back; Still, still doin' that shit, Andre? Oh for sho' Yeah! Check me out")
#' sweary_censor(vec, "en")

sweary_censor <- function(vec, lang_code, with = "***"){
  check_is_lang(lang_code)
  gsub(
    paste0(get_swearwords(lang_code)$word, collapse = "|"), 
    with, 
    vec
    )
}

