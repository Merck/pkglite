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

#' Evaluate a list of file specifications
#'
#' Evaluate a list of file specifications and bind the results
#' as a file collection.
#'
#' @param pkg Path to the package directory.
#' @param ... One or more file specification objects.
#'
#' @return A file collection object containing the package name,
#' file paths, and file format types.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Get package metadata, for example, the package name.
#'     \item Flatten the input list of file specification(s).
#'     \item Evaluate the file specification(s) under the \code{pkg} directory.
#'     \item Remove duplicated files from all evaluation results and store
#'     the file path and format information in a data frame.
#'     \item Return the package metadata and the data frame in a list.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export collate
#'
#' @examples
#' system.file("examples/pkg1/", package = "pkglite") %>%
#'   collate(file_default())
collate <- function(pkg = ".", ...) {
  path <- normalizePath(pkg, winslash = "/")

  # get package metadata ----
  pkg_name <- get_pkg_name(path)

  # get file collection ----
  lst_spec <- list(...)
  # this is useful for file spec templates like `file_default()`
  # where the return can be a list of file specs
  lst_spec <- flatten_file_spec(lst_spec)
  k <- length(lst_spec)
  if (k == 0L) stop("Must provide at least one file specification.", call. = FALSE)
  lst_collection <- lapply(seq_len(k), function(i) fs_to_df(path, lst_spec[[i]]))
  df <- do.call(rbind, lst_collection)
  # remove duplicates
  df <- unique(df)

  new_file_collection(pkg_name, df)
}

#' Evaluate a file specification and return a file collection data frame
#'
#' @param pkg_path Path to the package directory.
#' @param file_spec A file specification.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Evaluate a file specification under a package directory
#'     using \code{list.files()}.
#'     \item Return the a data frame containing the absolute path,
#'     relative path, and format of the files.
#'     \item Return a data frame of 0 rows if there are no matching files.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
fs_to_df <- function(pkg_path, file_spec) {
  pkg_path <- normalizePath(pkg_path, winslash = "/")
  rel_path <- file_spec$path

  full_path <- paste(pkg_path, rel_path, sep = "/")
  df <- create_fc_df(nrow = 0L)
  if (!dir.exists(full_path)) {
    return(df)
  }

  full_path <- normalizePath(full_path, winslash = "/")
  file_path_abs <- list_files(
    path = full_path, pattern = file_spec$pattern, full.names = TRUE,
    recursive = file_spec$recursive, ignore.case = file_spec$ignore_case,
    all.files = file_spec$all_files, include.dirs = FALSE, no.. = TRUE
  )

  k <- length(file_path_abs)
  if (k == 0L) {
    return(df)
  }

  df <- create_fc_df(nrow = k)
  df$"path_abs" <- file_path_abs
  df$"path_rel" <- get_rel_path(pkg_path, file_path_abs)
  df$"format" <- file_spec$format

  df
}

#' Flatten a nested list of file specifications to a single-level list
#'
#' @param lst A (nested) list of file specifications.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Given a possibly nested list of file specifications,
#'     parse the list recursively and flatten the list structure
#'     until it becomes a single-level list of file specifications.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
flatten_file_spec <- function(lst) {
  if (!all(sapply(lapply(lst, class), `%in%`, c("file_spec", "list")))) {
    stop("All inputs must be file specification objects.", call. = FALSE)
  }
  do.call(c, lapply(lst, function(x) if (!is_file_spec(x)) flatten_file_spec(x) else list(x)))
}

#' Get file's relative path to the package root
#'
#' @param pkg_path Path to the package directory.
#' @param file_path_abs The file's absolute path.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Given the package directory path and a vector of the file's
#'     absolute path, return the file's path relative to the package root.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
get_rel_path <- function(pkg_path, file_path_abs) {
  gsub(paste0("^", pkg_path, "/"), "", file_path_abs)
}

#' Create a data frame for the file collection
#'
#' @param nrow Number of rows in the data frame.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Return a data frame that has \code{nrow} rows that equals to
#'     the number of files in a file collection. The columns will contain
#'     the absolute path, relative path, and format of the files.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @importFrom stats setNames
#'
#' @noRd
create_fc_df <- function(nrow) {
  setNames(
    data.frame(matrix(nrow = nrow, ncol = 3L), stringsAsFactors = FALSE),
    c("path_abs", "path_rel", "format")
  )
}

#' Get package name from the DESCRIPTION file
#'
#' @param path Package directory path.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Read the DESCRIPTION file under \code{path}.
#'     \item Parse and return the value of the \code{Package} field.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
get_pkg_name <- function(path) {
  path <- paste0(path, "/DESCRIPTION")
  if (!file.exists(path)) stop("Can't find the `DESCRIPTION` file in package root.", call. = FALSE)
  desc_file <- normalizePath(path, winslash = "/")
  pkg_name <- unname(read.dcf(desc_file)[, "Package"])
  pkg_name
}

#' List the files in a directory without returning any subdirectories
#'
#' @param ... Arguments passed to [list.files()].
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item List files using \code{list.files()}.
#'     \item Test if the results are files using \code{file_test()}.
#'     \item Keep the files only.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @importFrom utils file_test
#'
#' @noRd
list_files <- function(...) {
  Filter(function(x) file_test("-f", x), list.files(...))
}
