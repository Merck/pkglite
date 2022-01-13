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

#' Create a file specification
#'
#' Specify which files to include
#'
#' Most of the parameters are passed through [list.files()].
#'
#' @param path Path relative to the package root), for example, `"inst/"`.
#' @param pattern Regular expression for matching the file names.
#' @param format File format type, one of `"binary"` or `"text"`.
#' @param recursive List files in the sub-directories?
#' @param ignore_case Should pattern-matching be case-insensitive?
#' @param all_files List all files including the invisible ones?
#'
#' @return A file specification object.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Define a list of parameters that can be passed to \code{list.files()}.
#'     \item Store the parameters in a named list.
#'     \item Assign class \code{file_spec} to the list.
#'     \item Return the \code{file_spec} object.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export file_spec
#'
#' @examples
#' file_spec(
#'   "R/",
#'   pattern = "\\.R$", format = "text",
#'   recursive = FALSE, ignore_case = TRUE, all_files = FALSE
#' )
file_spec <- function(path, pattern = NULL, format = c("binary", "text"),
                      recursive = TRUE, ignore_case = TRUE, all_files = FALSE) {
  if (missing(path)) stop("Must provide a non-empty `path`.", call. = FALSE)
  format <- match.arg(format)

  lst <- list(
    "path" = path,
    "pattern" = pattern,
    "format" = format,
    "recursive" = recursive,
    "ignore_case" = ignore_case,
    "all_files" = all_files
  )

  class(lst) <- "file_spec"
  lst
}

#' Is this a file specification object?
#'
#' @param object Any R object
#'
#' @return Logical. `TRUE` if it is a file specification object,
#' `FALSE` otherwise.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Check if the input object class contains \code{file_spec}.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export is_file_spec
#'
#' @examples
#' file_spec(
#'   "R/",
#'   pattern = "\\.R$", format = "text",
#'   recursive = FALSE, ignore_case = TRUE, all_files = FALSE
#' ) %>%
#'   is_file_spec()
is_file_spec <- function(object) {
  if ("file_spec" %in% class(object)) TRUE else FALSE
}

#' Print a file specification
#'
#' @param x An object of class `file_spec`.
#' @param ... Additional parameters for [print()] (not used).
#'
#' @return The input `file_spec` object.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Print the elements in the file specification object with cli.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @method print file_spec
#'
#' @export
#'
#' @examples
#' fs <- file_spec(
#'   "R/",
#'   pattern = "\\.R$", format = "text",
#'   recursive = FALSE, ignore_case = TRUE, all_files = FALSE
#' )
#' fs
print.file_spec <- function(x, ...) {
  cli_h1("File specification")
  cli_li("Relative path: ", cli_str(x$path))
  cli_li("Pattern: ", cli_str(x$pattern))
  cli_li("Format: ", cli_str(x$format))
  cli_li("Recursive: ", cli_bool(x$recursive))
  cli_li("Ignore case: ", cli_bool(x$ignore_case))
  cli_li("All files: ", cli_bool(x$all_files))
  invisible(x)
}
