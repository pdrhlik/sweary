#' Automates sweary builds
#'
#' @description  It starts with rebuilding the `swear_words` data frame
#'   by running a prepared script. It lists all language files
#'   and constructs the data frame.
#'
#'   Then it rerenders the README.Rmd file so that all the proper
#'   numbers of new words and languages propagate into README.md.
#'   We also have to delete the README.html file that is created
#'   in the process.
#'
#'   The next step is to create necesarry documentation from
#'   roxygen comments.
#'
#'   Then we build the package as we would normally.
#'
#'   After a build, we run local tests that ensure our
#'   raw files consistency and check that the data frame
#'   `swear_words` has been modified accordingly.
#'
#'   The last step is a complex check.
#'
#'   Every error or warning should be properly addressed
#'   before merging into master.
#'
#' @param quiet If \code{TRUE}, stops printing most of the output.
#'   Defaults to \code{FALSE}.
#'
#' @return Summary of the build process - list of class
#'   \code{sweary_build_results}.
build_sweary <- function(quiet = FALSE) {
	reporter <- ifelse(quiet, "silent", testthat::default_reporter())
	# Rebuild a swear_words data frame
	source("data-raw/swear-words.R")
	# Rerender the README file
	safe_render <- purrr::safely(rmarkdown::render)
	rr <- safe_render("README.Rmd", output_format = "github_document", encoding = "UTF-8", quiet = quiet)
	# Unlink a temporary preview HTML file
	unlink("README.html")
	# Rebuild documentation
	devtools::document(roclets = c("rd", "collate", "namespace"))
	# Rebuild package
	devtools::build(quiet = quiet)
	# Run local tests
	lt <- testthat::test_dir("data-raw/tests-local/", reporter = reporter)
	# Run general tests
	gt <- devtools::test(reporter = reporter)
	# Run complex package check
	dc <- devtools::check(quiet = quiet)

	# Create a list of build results
	build_results <- list(
		readme_render = list(
			output = rr,
			summary = data.frame(
				warnings = 0,
				errors = as.integer(!is.null(rr$error))
			)
		),
		local_tests = list(
			output = lt,
			summary = test_summary(lt)
		),
		general_tests = list(
			output = gt,
			summary = test_summary(gt)
		),
		devtools_check = list(
			output = dc,
			summary = purrr::map(dc, ~ length(.) > 0) %>%
				purrr::map(~ as.integer(.)) %>%
				dplyr::as_data_frame(.)
		)
	)

	class(build_results) <- "sweary_build_results"

	print(build_results)

	return(build_results)
}

# Unified console output of the sweary build process
format.sweary_build_results <- function(x) {
	reset <- "\u001b[0m"
	sw <- sweary::swear_words

	readme <- x$readme_render$summary
	local_tests <- x$local_tests$summary
	general_tests <- x$general_tests$summary
	devtools_check <- x$devtools_check$summary

	rsw <- sw[sample(1:nrow(sw), 1),]

	status <- build_summary(x)
	final_message <- dplyr::case_when(
		status$errors > 0 ~ "You need to fix some ERRORS!",
		status$warnings > 0 ~ "You should fix those WARNINGS!",
		status$notes > 0 ~ "Handle those NOTES and you're good to go!",
		TRUE ~ paste0("Great job! Random swearword for you: ", rsw$word, " [", rsw$language, "] :-)")
	)

	glue::glue("
	    {status_color(status)}
		==================
		BUILD SWERY STATUS
		==================\\
		{reset}\\

		{status_color(readme)}
		README.Rmd render
		-------------\\
		{reset}
		{print_readme_render(readme)}\\

		{status_color(local_tests)}
		Local Tests
		-----------\\
		{reset}
		{print_test_summary(local_tests)}\\

	    {status_color(general_tests)}
		General Tests
		-------------\\
		{reset}
		{print_test_summary(general_tests)}\\

		{status_color(devtools_check)}
		Devtools Check
		--------------\\
		{reset}
		{print_devtools_check_summary(devtools_check)}

		{status_color(status)}{final_message}{reset}")
}

print.sweary_build_results <- function(x, ...) {
	cat(format(x, ...), "\n")
}

# Testhat results wrangling
test_summary <- function(testthat_results) {
	purrr::map(testthat_results, "results") %>%
		unlist(recursive = FALSE) %>%
		purrr::map(~ class(.)) %>%
		purrr::map_df(~ data.frame(
			OK = any(stringr::str_detect(., "success")),
			warnings = any(stringr::str_detect(., "warning")),
			errors = any(stringr::str_detect(., "failure"))
		)) %>%
		colSums(., na.rm = TRUE) %>%
		as.list(.) %>%
		dplyr::as_data_frame(.)
}

# Build status summary
build_summary <- function(sweary_build_results) {
	res <- unlist(sweary_build_results, recursive = FALSE)
	res <- res[which(stringr::str_detect(names(res), "summary"))]
	res <- dplyr::bind_rows(res) %>%
		colSums(., na.rm = TRUE) %>%
		as.list(.) %>%
		dplyr::as_data_frame(.)

	return(res)
}

# Console coloring function.
# If the step contains errors, it becomes red.
# If the step contains warnings, it becomes yellow.
# Otherwise it's green.
status_color <- function(x) {
	red <- "\u001b[31m"
	green <- "\u001b[32m"
	yellow <- "\u001b[33m"

	ret <- dplyr::case_when(
		x$errors > 0 ~ red,
		x$warnings > 0 ~ yellow,
		TRUE ~ green
	)

	return(ret)
}

print_readme_render <- function(x) {
	ifelse(
		x$errors == TRUE,
		"ERROR",
		"SUCCESS"
	)
}

print_test_summary <- function(x) {
	glue::glue("
		OK: {x$OK}
		warnings: {x$warnings}
		errors: {x$errors}")
}

print_devtools_check_summary <- function(x) {
	glue::glue("
		errors: {x$errors}
		warnings: {x$warnings}
		notes: {x$notes}")
}
