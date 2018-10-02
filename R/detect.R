#' Detect if a word is a Swear Word
#'
#' @param word the word to look for
#' @param lang_code the code of the language to look for
#'
#' @return TRUE if the word is in the database, FALSE if not
#' @export
#'
#' @examples
#' is_swearword("shit", "en")
is_swearword <- function(word, lang_code){
  check_is_lang(lang_code)
  word %in% get_swearwords(lang_code)$word
}

#' How muck are Swear Words?
#' 
#' @inheritParams is_swearword
#' @param vec the vector to test for swear words
#'
#' @return the number of swear words detected
#' @export
#'
#' @examples
#' vec <- c("Yeah nigga, we're still fucking with you, 
#' Still waters run deep, Still Snoop Dogg and D.R.E")
#' n_swearword(vec, "en")
n_swearword <- function(vec, lang_code){
  check_is_lang(lang_code)
  wd <- get_swearwords(lang_code)$word
  sum( sapply(tokenize_words(vec, simplify = TRUE), function(x) x %in% wd) )
  
}

#' How much are Swear Words?
#' 
#' @inheritParams n_swearword
#' @param vec the vector to test for swear words
#'
#' @return the percentage of swear words detected
#' @export
#'
#' @examples
#' vec <- c("Yeah nigga, we're still fucking with you, 
#' Still waters run deep, Still Snoop Dogg and D.R.E")
#' pct_swearword(vec, "en")
pct_swearword <- function(vec, lang_code){
  check_is_lang(lang_code)
  splitted <- tokenize_words(vec, simplify = TRUE)
  n <- n_swearword(vec, lang_code)
  if (n !=0) {
    n / length(splitted) * 100
  } else {
    0
  }
}

#' Detect if any word is a Swear Word
#'
#' @inheritParams n_swearword
#' @export
#' @importFrom tokenizers tokenize_words
#' @examples 
#' vec <- c("Yeah nigga, we're still fucking with you, 
#' Still waters run deep, Still Snoop Dogg and D.R.E")
#' any_swearword(vec, "en")
any_swearword <- function(vec, lang_code){
  check_is_lang(lang_code)
  n_swearword(vec, lang_code) > 0
}
