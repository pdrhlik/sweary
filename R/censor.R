#' Censor a character vector
#'
#' @inheritParams is_swearword
#' @param vec a vector to censor
#' @param with the element to use as a censor mark
#'
#' @return a censored version of the vector
#' @export
#'
#' @examples
#' vec <- c("Yeah nigga, we're still fucking with you, 
#' Still waters run deep, Still Snoop Dogg and D.R.E")
#' censor_swearword(vec, "en")
censor_swearword <- function(vec, lang_code, with = "***"){
  check_is_lang(lang_code)
  gsub(
    paste0(get_swearwords(lang_code)$word, collapse = "|"), 
    with, 
    vec
    )
}
