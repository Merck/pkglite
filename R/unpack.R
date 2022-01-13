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

#' Unpack packages from a text file
#'
#' @details
#' If `install = TRUE`, the packages will be installed by the order of
#' appearance in the `input` file. When internal dependencies exist between
#' these packages, make sure they are packed in the order where the
#' low-level dependencies appear first.
#'
#' @param input Path to the text file.
#' @param output Path to the output directory.
#' Each package is placed under a subdirectory named after the package name.
#' Default is the current working directory.
#' @param install Try install the unpacked package(s)?
#' @param quiet Suppress printing of progress?
#' @param ... Additional parameters for [remotes::install_local()].
#'
#' @return The output directory path.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Read input file.
#'     \item Construct output file paths.
#'     \item Write all files in all packages to their destination in
#'     the order of their appearance in the input file.
#'     \item Install the unpacked packages if \code{install = TRUE}.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @importFrom remotes install_local
#'
#' @export unpack
#'
#' @examples
#' # pack two packages
#' pkg1 <- system.file("examples/pkg1", package = "pkglite")
#' pkg2 <- system.file("examples/pkg2", package = "pkglite")
#'
#' fc1 <- pkg1 %>% collate(file_default())
#' fc2 <- pkg2 %>% collate(file_default())
#'
#' txt <- tempfile(fileext = ".txt")
#' pack(fc1, fc2, output = txt, quiet = TRUE)
#'
#' # unpack the two packages
#' out <- file.path(tempdir(), "twopkgs")
#' txt %>% unpack(output = out, quiet = TRUE)
#'
#' out %>%
#'   file.path("pkg1") %>%
#'   list.files()
#' out %>%
#'   file.path("pkg2") %>%
#'   list.files()
unpack <- function(input, output = ".", install = FALSE, quiet = FALSE, ...) {
  # handle input ----
  if (missing(input)) stop("Must provide an input file.", call. = FALSE)

  # read input ----
  if (!quiet) cli_h1("Unpacking from pkglite file")
  if (!quiet) cli_rule("Reading file: ", cli_path_src(input))
  lst <- read_pkglite(input)

  pkg_name <- lst[["pkg_name"]]
  path <- lst[["path"]]
  format <- lst[["format"]]
  content <- lst[["content"]]

  # construct output file paths ----
  nfiles <- length(path)
  output <- file.path(output)
  if (!dir.exists(output)) dir.create(output)
  output <- normalizePath(output, winslash = "/")
  path_abs <- file.path(paste0(output, "/", pkg_name, "/", path))
  path_rel <- file.path(paste0(pkg_name, "/", path))

  # write all files in all packages ----
  if (!quiet) cli_text("Writing to: ", cli_path_dst(output))
  lapply(seq_len(nfiles), function(i) {
    path_rel_cli <- path_rel[i]
    if (!quiet) cli_text("Writing ", cli_path_dst(path_rel_cli))
    write_pkg(path = path_abs[i], format = format[i], content = content[[i]])
  })

  # handle installation ----
  pkgs <- unique(pkg_name)
  path_pkg <- file.path(paste0(output, "/", pkgs, "/"))
  npkgs <- length(pkgs)
  if (install) {
    lapply(seq_len(npkgs), function(i) {
      pkg <- pkgs[i]
      if (!quiet) cli_rule("Installing package: ", cli_pkg(pkg))
      remotes::install_local(path_pkg[i], quiet = quiet, ...)
    })
  }

  invisible(output)
}

#' Read pkglite.txt
#'
#' Read pkglite.txt and return a list of output-ready line vectors.
#'
#' @param path File path.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Locate the line numbers of each field in every block.
#'     \item Get the field values in each block.
#'     \item For binary files, convert the character string to raw vectors.
#'     \item Return the file metadata and content as a list.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
read_pkglite <- function(path) {
  x <- readLines(path)
  nlines <- length(x)

  # locate the position of each field in every block
  idx_pkg <- match_field(x, "Package:")
  nblocks <- length(idx_pkg)
  idx_path <- match_field(x, "File:")
  idx_format <- match_field(x, "Format:")
  idx_content_start <- match_field(x, "Content:") + 1L
  idx_content_end <- c(idx_pkg[2L:nblocks] - 2L, nlines)

  # get the field values in each block
  lst <- list("pkg_name" = NULL, "path" = NULL, "format" = NULL, "content" = NULL)
  lst[["pkg_name"]] <- extract_value(x[idx_pkg])
  lst[["path"]] <- extract_value(x[idx_path])
  lst[["format"]] <- extract_value(x[idx_format])
  lst[["content"]] <- extract_value_multi(x, idx_content_start, idx_content_end)

  # convert string to writable raw vectors
  for (i in seq_len(nblocks)) {
    if (lst[["format"]][i] == "binary") {
      lst[["content"]][[i]] <- vec_to_raw(lst[["content"]][[i]])
    }
  }

  lst
}

#' Match the start of a string in a vector
#'
#' Match the start of a string in a vector and return the matching indices.
#'
#' @param x A character vector.
#' @param str The string to match.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item For each element in \code{x}, get the first \code{n}
#'     characters with the same length as \code{str}.
#'     \item Return \code{TRUE} if it matches \code{str},
#'     otherwise \code{FALSE}.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
match_field <- function(x, str) {
  which(substr(x, 1L, nchar(str)) == str)
}

#' Extract the value from a single-line field
#'
#' @param x A string vector of the single-line fields.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Extract the value part from the fields.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
extract_value <- function(x) {
  sapply(strsplit(x, ": "), "[", 2L)
}

#' Extract the value from a multi-line field
#'
#' Extract the value from a multi-line field in the DCF file
#' and remove the two heading whitespaces.
#'
#' @param x A string vector of the DCF file content.
#' @param start An integer vector of the field value starting line numbers.
#' @param end An integer vector of the field value ending line numbers.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Extract each block from \code{x} by their
#'     \code{start} and \code{end} locations.
#'     \item Return a list with each component representing one block.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
extract_value_multi <- function(x, start, end) {
  if (length(start) != length(end)) stop("`start` and `end` must have equal length.", call. = FALSE)
  k <- length(start)
  lapply(seq_len(k), function(i) substring(x[start[i]:end[i]], 3))
}

#' Convert hex character string to a raw vector
#'
#' @param x A string of hex characters.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Convert the input hex character string \code{x} into a raw vector.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
vec_to_raw <- function(x) {
  as.raw(as.hexmode(split_str_by_two(paste0(trimws(x), collapse = ""))))
}

#' Split a string by every two characters
#'
#' @param x A character string.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Split a string into a vector with each element containing two
#'     characters, assuming the string has an even number of characters.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
split_str_by_two <- function(x) {
  y <- strsplit(x, "")[[1]]
  paste0(y[c(TRUE, FALSE)], y[c(FALSE, TRUE)])
}

#' Write a file to the package destination
#'
#' @param path File path.
#' @param format File format.
#' @param content File content vector.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Create the directory first if the directory in \code{path}
#'     does not exist.
#'     \item Write a text or binary file's \code{content} to \code{path}.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
write_pkg <- function(path, format, content) {
  # create the directory
  path_dir <- file.path(dirname(path))
  if (!dir.exists(path_dir)) dir.create(path_dir, recursive = TRUE)

  # write the files
  if (format == "text") write_file_text(path, content)
  if (format == "binary") write_file_binary(path, content)

  invisible()
}

#' Write text content to a file
#'
#' @param path File path.
#' @param content Text file content (character vector).
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Write the character vector \code{content} to \code{path}.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
write_file_text <- function(path, content) {
  writeLines(content, con = path)
}

#' Write binary content to a file
#'
#' @param path File path.
#' @param content Binary file content (raw vector).
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Write the raw vector \code{content} to \code{path}.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
write_file_binary <- function(path, content) {
  writeBin(content, con = path)
}
