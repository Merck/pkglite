#  Copyright (c) 2022 Merck Sharp & Dohme Corp., a subsidiary of
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

#' Concatenate and print text
#'
#' Concatenate and print the input text with a new line.
#'
#' @param ... Character vector of strings.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Concatenate the vector of strings.
#'     \item Print a new line.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
cli_text <- function(...) {
  cat(paste0(..., "\n"), sep = "")
}

#' Print as headings
#'
#' Format and print the input as headings.
#'
#' @param x Character string.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Get the maximum width from options.
#'     \item Create and format `--` with a space as prefix.
#'     \item Create and format the input string `x`.
#'     \item Create and format a space as suffix.
#'     \item Calculate the number of trailing `-` needed to fill up the line
#'     while considering small width and long text.
#'     \item Concatenate and print the prefix, `x`, the suffix,
#'     and the formatted trailing `-`.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
cli_h1 <- function(x) {
  line <- "-"
  width <- getOption("width")
  prefix <- crayon::cyan(paste0(line, line, " "))
  x <- crayon::bold(x)
  suffix <- crayon::bold(" ")
  line_length <- width - crayon::col_nchar(prefix) - crayon::col_nchar(x) - crayon::col_nchar(suffix)
  line_length <- max(0, line_length)
  cli_text(prefix, x, suffix, crayon::cyan(strrep(line, line_length)))
}

#' Print with rules
#'
#' Format and print the input with rules.
#'
#' @param x Character string as key.
#' @param y Character string as value.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Get the maximum width from options.
#'     \item Create and format `--` with a space as prefix.
#'     \item Create and format the input string `x`.
#'     \item Create and format the input string `y`.
#'     \item Create and format a space as suffix.
#'     \item Calculate the number of trailing `-` needed to fill up the line
#'     while considering small width and long text.
#'     \item Concatenate and print the prefix, `x`, `y`, the suffix,
#'     and the formatted trailing `-`.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
cli_rule <- function(x, y) {
  line <- "-"
  width <- getOption("width")
  prefix <- paste0(line, line, " ")
  suffix <- " "
  line_length <- width - nchar(prefix) - crayon::col_nchar(x) - crayon::col_nchar(y) - nchar(suffix)
  line_length <- max(0, line_length)
  cli_text(prefix, x, y, suffix, strrep(line, line_length))
}

#' Print as bullet lists
#'
#' Print and format input as bullet lists.
#'
#' @param ... Character vector of strings.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Concatenate and print the input with a leading bullet and a space.
#'     \item Print a new line.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
cli_li <- function(...) {
  bullet <- "-"
  cli_text(bullet, " ", ...)
}

#' Format as string type
#'
#' Format the input as string type.
#'
#' @param ... Character string.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Encode the input for printing.
#'     \item Format the encoded input as blue.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
cli_str <- function(...) {
  crayon::blue(encodeString(..., quote = "\""))
}

#' Format as Boolean type
#'
#' Format the input as Boolean type.
#'
#' @param ... Logical.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Format the input as blue.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
cli_bool <- function(...) {
  crayon::blue(...)
}

#' Format as numeric type
#'
#' Format the input as numeric type.
#'
#' @param ... Numeric.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Format the input as green.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
cli_num <- function(...) {
  crayon::green(...)
}

#' Format as package name
#'
#' Format the input as package name.
#'
#' @param ... Character string.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Format the input as blue.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
cli_pkg <- function(...) {
  crayon::blue(...)
}

#' Format as source path
#'
#' Format the input as path of source.
#'
#' @param ... Vector of character strings that construct the path.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Construct the path from the input.
#'     \item Encode the path.
#'     \item Format the encoded path as green.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
cli_path_src <- function(...) {
  crayon::green(encodeString(file.path(...), quote = "\""))
}

#' Format as destination path
#'
#' Format the input as path of destination.
#'
#' @param ... Vector of character strings that construct the path.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Construct the path from the input.
#'     \item Encode the path.
#'     \item Format the encoded path as blue.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
cli_path_dst <- function(...) {
  crayon::blue(encodeString(file.path(...), quote = "\""))
}
