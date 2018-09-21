
<!-- README.md is generated from README.Rmd. Please edit this file. -->
[![Join the chat at https://gitter.im/pdrhlik/sweary](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/swearyr) [![Build Status](https://travis-ci.org/pdrhlik/sweary.svg?branch=master)](https://travis-ci.org/pdrhlik/sweary)

sweary <img src="sticker/sweary-sticker.png" align="right" width="150" />
=========================================================================

Sweary is an R package that contains a database of swear words from different languages, cherry picked by native speakers.

Installation
------------

The development version of this package can be installed using [devtools](https://github.com/r-lib/devtools):

    devtools::install_github("pdrhlik/sweary")

Current swear word lists
------------------------

| Language  | Language code | Number of swear words |
|-----------|---------------|-----------------------|
| Czech     | cs            | 57                    |
| English   | en            | 39                    |
| Polish    | pl            | 41                    |
| **Total** | **3 langs**   | **137**               |

How to use it
-------------

The package contains a data frame called `swear_words`. You can filter or modify it as you wish now. There will be convenient functions to extract only the languages that are of your interest.

Add (modify) a language
-----------------------

If you are not comfortable with `git` and pull requests, you can just follow steps **1-3**. After you create the file, send it to me via [email](mailto:patrik.drhlik@gmail.com) with a subject **New sweary language: {LANG\_CODE}**. We will acknowledge you in the README after we approve of the changes.

1.  **Choose a new language.**
    Find its two letter [ISO 639-1 code](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes).
2.  **Create a language file.**
    Place the file in `data-raw/swear-word-lists/{LANG_CODE}`.
    Example for English: `data-raw/swear-word-lists/en`.
3.  **Fill in the file with swear-words.** Following rules must apply:
    -   **One** swear-word per line.
    -   All words must be **lowercase**.
    -   The list must only contain **unique** words.
    -   The list must be **sorted** alphabetically.
4.  **Make sure all the tests pass.**
    You can do that using a development function called `build_sweary()`. It becomes available when you `git clone` the repository and call `devtools::load_all()`. Or pressing `Ctrl+Shift+L` in RStudio. Learn more about calling this function using `?build_sweary`.
5.  **Update README.Rmd**
    Update the `langs` data frame in README.Rmd by adding a new row to it. More precise instructions are in the raw file itself.
6.  **Create a pull request.**

Origin
------

The idea first appeared after the [South Park text analysis lightning talk](https://github.com/pdrhlik/southparktalk-whyr2018) at the [Why R? 2018 conference](http://whyr2018.pl/) in Wrocław. All the contributors will be acknowledged as the work progresses.
