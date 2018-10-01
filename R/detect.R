#' Detect if a word is a Swear Word
#'
#' @param word the word to look for
#' @param lang_code the code of the language to look for
#'
#' @return TRUE if the word is in the database, FALSE if not
#' @export
#'
#' @examples
#' sweary_is("shit", "en")

sweary_is <- function(word, lang_code){
  check_is_lang(lang_code)
  word %in% get_swearwords(lang_code)$word
}

#' How muck are Swear Words?
#' 
#' @inheritParams sweary_is
#' @param vec the vector to test for swear words
#'
#' @return the number of swear words detected
#' @export
#'
#' @examples
#' vec <- c("Yeah, nigga, we're still fucking with you, Still waters run deep ,Still Snoop Dogg and D.R.E. '99, nigga, guess who's back; Still, still doin' that shit, Andre? Oh for sho' Yeah! Check me out")
#' sweary_n(vec, "en")

sweary_n <- function(vec, lang_code){
  check_is_lang(lang_code)
  
  wd <- get_swearwords(lang_code)$word
  
  sum( sapply(tokenize_words(vec, simplify = TRUE), function(x) x %in% wd) )
  
}

#' How much are Swear Words?
#' 
#' @inheritParams sweary_is
#' @param vec the vector to test for swear words
#'
#' @return the percentage of swear words detected
#' @export
#'
#' @examples
#' vec <- c("Yeah, nigga, we're still fucking with you, Still waters run deep ,Still Snoop Dogg and D.R.E. '99, nigga, guess who's back; Still, still doin' that shit, Andre? Oh for sho' Yeah! Check me out")
#' sweary_pct(vec, "en")

sweary_pct <- function(vec, lang_code){
  check_is_lang(lang_code)
  splitted <- tokenize_words(vec, simplify = TRUE)
  n <- sweary_n(vec, lang_code)
  if (n !=0){
    n / length(splitted) * 100
  } else {
    0
  }
}

#' Detect if any word is a Swear Word
#'
#' @inheritParams sweary_n
#' @export
#' @importFrom tokenizers tokenize_words
#' @examples 
#' vec <- c("Yeah, nigga, we're still fucking with you, Still waters run deep ,Still Snoop Dogg and D.R.E. '99, nigga, guess who's back; Still, still doin' that shit, Andre? Oh for sho' Yeah! Check me out")
#' sweary_any(vec, "en")

sweary_any <- function(vec, lang_code){
  check_is_lang(lang_code)
  sweary_n(vec, lang_code) > 0
}
