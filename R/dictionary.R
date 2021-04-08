#  Copyright (c) 2021 Merck Sharp & Dohme Corp. a subsidiary of Merck & Co., Inc., Kenilworth, NJ, USA.
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

#' Common file extensions (text)
#'
#' @param flat Flatten the list and return a vector?
#'
#' @return A list or vector of standard text file extensions.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Return a named list of common text file extensions in R packages.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export ext_text
#'
#' @examples
#' ext_text()
ext_text <- function(flat = FALSE) {
  x <- list(
    "r" = c("R", "r", "s"),
    "man" = c("Rd", "rd"),
    "manfigures" = c("svg"),
    "src" = c(
      "c", "h", "cpp", "hpp", "hxx", "hh",
      "f", "f90", "f95", "f03"
    ),
    "vignette" = c("Rmd", "md", "Rnw", "tex", "bib"),
    "meta" = c("Rproj", "dcf", "yml", "yaml"),
    "table" = c("csv", "tsv", "txt"),
    "figure" = c("svg"),
    "web" = c("html", "css", "js", "xml"),
    "doc" = c("rtf")
  )
  if (flat) unique(unlist(x)) else x
}

#' Common file extensions (binary)
#'
#' @param flat Flatten the list and return a vector?
#'
#' @return A list or vector of standard binary file extensions.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Return a named list of common binary file extensions in R packages.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export ext_binary
#'
#' @examples
#' ext_binary()
ext_binary <- function(flat = FALSE) {
  x <- list(
    "data" = c("rda", "rds", "RData"),
    "manfigures" = c("jpg", "jpeg", "pdf", "png"),
    "figure" = c(
      "png", "jpg", "jpeg", "bmp", "gif", "tiff", "emf",
      "ico", "webp", "eps", "pdf"
    ),
    "src" = c("o", "so"),
    "mso" = c("docx", "xlsx", "pptx", "doc", "xls", "ppt"),
    "sas" = c("sas7bdat", "sas7bcat", "xpt", "xpt5", "xpt8")
  )
  if (flat) unique(unlist(x)) else x
}

#' Common File name patterns
#'
#' @return A vector of file name patterns.
#'
#' @name file_name_patterns
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Return a vector of filename patterns for matching files.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
NULL
# > NULL

#' @rdname file_name_patterns
#' @export pattern_file_root_core
pattern_file_root_core <- function() {
  c(
    "^DESCRIPTION$",
    "^NAMESPACE$",
    "^README$",
    "^README\\.md$",
    "^NEWS$",
    "^NEWS\\.md$",
    "^LICENSE$",
    "\\.Rbuildignore$"
  )
}

#' @rdname file_name_patterns
#' @export pattern_file_root_all
pattern_file_root_all <- function() {
  c(
    "^DESCRIPTION$",
    "^NAMESPACE$",
    "^README$",
    "^NEWS$",
    "^LICENSE$",
    "*[.]"
  )
}

#' @rdname file_name_patterns
#' @export pattern_file_sanitize
pattern_file_sanitize <- function() {
  c(
    "/\\.DS_Store$",
    "/Thumbs\\.db$",
    "/\\.git$",
    "/\\.svn$",
    "/\\.hg$",
    "/\\.Rproj\\.user$",
    "/\\.Rhistory$",
    "/\\.RData$",
    "/\\.Ruserdata$"
  )
}
