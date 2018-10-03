usethis::use_build_ignore("devtools_history.R")

# Add package
usethis::use_package("attempt") 
usethis::use_package("glue") 
usethis::use_package("tokenizers") 

# Clean DESC
usethis::use_tidy_description()

# Test 

usethis::use_test("utils")
usethis::use_test("detect")
usethis::use_test("tokenize_words")
