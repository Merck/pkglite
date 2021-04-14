#  Copyright (c) 2021 Merck Sharp & Dohme Corp., a subsidiary of
#  Merck & Co., Inc., Kenilworth, NJ, USA.
#
#  This file is part of the pkglite program.
#
#  pkglite is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

#' File specification templates
#'
#' * `file_root_core()` - core files under the package root
#' * `file_root_all()` - all files under the package root
#' * `file_r()` - files under `R/`
#' * `file_man()` - files under `man/`
#' * `file_src()` - files under `src/`
#' * `file_vignettes()` - files under `vignettes/`
#' * `file_data()` - files under `data/`
#' * `file_tests()` - files under `tests/`
#'
#' @return A file specification or a list of file specifications.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Use \code{file_spec()} to generate and return a file specification
#'     or a list of file specifications that cover the common naming
#'     patterns of files under directories in source R packages.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @name file_spec_templates
NULL
# > NULL

#' @rdname file_spec_templates
#' @export file_root_core
file_root_core <- function() {
  file_spec(
    path = "", pattern = cat_patterns(pattern_file_root_core()),
    format = c("text"), recursive = FALSE, ignore_case = FALSE, all_files = TRUE
  )
}

#' @rdname file_spec_templates
#' @export file_root_all
file_root_all <- function() {
  file_spec(
    path = "", pattern = cat_patterns(pattern_file_root_all()),
    format = c("text"), recursive = FALSE, ignore_case = TRUE, all_files = TRUE
  )
}

#' @rdname file_spec_templates
#' @export file_r
file_r <- function() {
  spec_code <- file_spec(
    path = "R/", pattern = cat_patterns(ends_with(ext_text()$"r")),
    format = c("text"), recursive = FALSE, ignore_case = TRUE, all_files = FALSE
  )
  spec_data <- file_spec(
    path = "R/", pattern = "^sysdata\\.rda$",
    format = "binary", recursive = FALSE, ignore_case = TRUE, all_files = FALSE
  )

  list(spec_code, spec_data)
}

#' @rdname file_spec_templates
#' @export file_man
file_man <- function() {
  spec_rd <- file_spec(
    path = "man/", pattern = cat_patterns(ends_with(ext_text()$"man")),
    format = c("text"), recursive = FALSE, ignore_case = TRUE, all_files = FALSE
  )

  spec_fig_binary <- file_spec(
    path = "man/figures/", pattern = cat_patterns(ends_with(ext_binary()$"manfigures")),
    format = c("binary"), recursive = FALSE, ignore_case = TRUE, all_files = FALSE
  )

  spec_fig_text <- file_spec(
    path = "man/figures/", pattern = cat_patterns(ends_with(ext_text()$"manfigures")),
    format = c("text"), recursive = FALSE, ignore_case = TRUE, all_files = FALSE
  )

  list(spec_rd, spec_fig_binary, spec_fig_text)
}

#' @rdname file_spec_templates
#' @export file_src
file_src <- function() {
  file_spec(
    path = "src/", pattern = cat_patterns(ends_with(ext_text()$"src")),
    format = c("text"), recursive = TRUE, ignore_case = TRUE, all_files = FALSE
  )
}

#' @rdname file_spec_templates
#' @export file_vignettes
file_vignettes <- function() {
  file_auto(path = "vignettes/")
}

#' @rdname file_spec_templates
#' @export file_data
file_data <- function() {
  file_spec(
    path = "data/", pattern = cat_patterns(ends_with(c("rda", "RData"))),
    format = "binary", recursive = FALSE, ignore_case = TRUE, all_files = FALSE
  )
}

#' @rdname file_spec_templates
#' @export file_tests
file_tests <- function() {
  file_auto(path = "tests/")
}

#' File specification (default combination)
#'
#' A default combination of common file specifications.
#'
#' @return A list of file specifications.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Use file specification template functions to generate and
#'     return a list of file specifications that cover a default
#'     set of the common naming patterns of files in source R packages.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export file_default
#'
#' @examples
#' file_default()
file_default <- function() {
  list(file_root_core(), file_r(), file_man(), file_src(), file_vignettes(), file_data())
}

#' File specification (eCTD submission)
#'
#' A combination of file specifications for eCTD submissions.
#'
#' @return A list of file specifications.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Use file specification template functions to generate and
#'     return a list of file specifications that cover the a set of the
#'     common naming patterns of files in source R packages for
#'     eCTD submissions.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export file_ectd
#'
#' @examples
#' file_ectd()
file_ectd <- function() {
  list(file_root_core(), file_r(), file_man(), file_src(), file_data())
}

#' File specification (automatic guess)
#'
#' Lists all files under a folder recursively and guesses the
#' file format type (text or binary) based on the file extension.
#'
#' @param path The directory's relative path (relative to the
#' package root), for example, `"inst/"`.
#'
#' @return A list of file specifications.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Use \code{file_spec()} to cover all text files by their file
#'     extensions under the relative \code{path} of the package, recursively.
#'     \item Use \code{file_spec()} to cover all binary files by their file
#'     extensions under the relative \code{path} of the package, recursively.
#'     \item Return the combination of the two file specifications in a list.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export file_auto
#'
#' @examples
#' file_auto("inst/")
file_auto <- function(path) {
  # uses a file extension dictionary to guess the format type
  patterns_text <- cat_patterns(ends_with(ext_text(flat = TRUE)))
  spec_text <- file_spec(
    path = path, pattern = patterns_text, format = "text",
    recursive = TRUE, ignore_case = TRUE, all_files = TRUE
  )

  patterns_binary <- cat_patterns(ends_with(ext_binary(flat = TRUE)))
  spec_binary <- file_spec(
    path = path, pattern = patterns_binary, format = "binary",
    recursive = TRUE, ignore_case = TRUE, all_files = TRUE
  )

  list(spec_text, spec_binary)
}

#' Concatenate patterns
#'
#' @param patterns A character vector of individual patterns
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Concatenate pattern strings with \code{|}.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
cat_patterns <- function(patterns) paste0(patterns, collapse = "|")

#' Convert file extensions to regular expressions
#'
#' @param x A character vector of file extensions (without dot)
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Attach the starting dot with the start and end of string anchors
#'     to a vector of file extensions.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
ends_with <- function(x) paste0("\\.", x, "$")
