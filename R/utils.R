#' @importFrom attempt stop_if_not

check_is_lang <- function(lang_code){
  stop_if_not(
    lang_code, 
    ~ .x %in% swear_lang, 
    glue("Language '{lang_code}' not part of the package yet. \nWould you like to add it? :-)")
  )
}
