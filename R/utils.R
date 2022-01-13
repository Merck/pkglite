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

#' Check if a file contains only ASCII characters
#'
#' @param input Path to the text file.
#' @param quiet Print the elements containing non-ASCII characters?
#'
#' @return Logical. `TRUE` if the file only contains ASCII characters,
#' `FALSE` otherwise.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Read the file and check for non-ASCII characters in its content.
#'     \item If there are non-ASCII characters, return \code{FALSE}, otherwise \code{TRUE}.
#'     \item If \code{quiet = FALSE} and there are non-ASCII characters,
#'     print the corresponding line numbers and the non-ASCII characters.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @importFrom tools showNonASCIIfile
#'
#' @export verify_ascii
#'
#' @examples
#' pkg <- system.file("examples/pkg1", package = "pkglite")
#' txt <- tempfile(fileext = ".txt")
#'
#' pkg %>%
#'   collate(file_default()) %>%
#'   pack(output = txt, quiet = TRUE) %>%
#'   verify_ascii()
verify_ascii <- function(input, quiet = FALSE) {
  if (missing(input)) stop("Must provide an input file.", call. = FALSE)
  input <- file.path(input)
  x <- suppressMessages(showNonASCIIfile(input))
  has_only_ascii <- !as.logical(length(x))
  if (!has_only_ascii & !quiet) showNonASCIIfile(input)
  has_only_ascii
}

#' Remove content lines from a pkglite file
#'
#' @param input Path to the text file.
#' @param x A character vector.
#' Exactly matched lines in the file content will be removed.
#' @param quiet Suppress printing of progress?
#'
#' @return The input file path.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Read the input file as a character vector.
#'     \item Identify the line numbers that belong to the Content field by the indentation.
#'     \item Extract these lines and remove the two heading whitespaces and store as a vector.
#'     \item Find the elements that match the values in the input vector \code{x}.
#'     \item Remove the matching elements.
#'     \item Write the file back with the matching elements removed.
#'     \item If there are any matching elements and \code{quiet = FALSE},
#'     print the line numbers being removed.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export remove_content
#'
#' @examples
#' pkg <- system.file("examples/pkg1", package = "pkglite")
#' txt <- tempfile(fileext = ".txt")
#'
#' pkg %>%
#'   collate(file_default()) %>%
#'   pack(output = txt, quiet = TRUE) %>%
#'   remove_content(c("## New Features", "## Improvements"), quiet = TRUE)
remove_content <- function(input, x, quiet = FALSE) {
  if (missing(input)) stop("Must provide an input file.", call. = FALSE)
  y <- readLines(input)

  idx_content <- which(substr(y, 1L, 2L) == "  ")
  y_content <- substring(y[idx_content], 3L)
  idx_match <- which(!is.na(match(y_content, x)))

  k <- length(idx_match)
  if (k > 0L) {
    if (!quiet) {
      lapply(seq_len(k), function(i) {
        idx <- idx_content[idx_match][i]
        cli_text("Removing line ", cli_num(idx))
      })
    }
    y <- y[-idx_content[idx_match]]
    if (!quiet) cli_text("Writing to: ", cli_path_dst(input))
    writeLines(y, con = input)
  } else {
    if (!quiet) cli_text("No matching content found")
  }

  invisible(input)
}

#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @return The evaluation result of `rhs(lhs)`,
#' if `rhs` is a function and `lhs` is an object.
#' See [magrittr::%>%] for more details.
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL
