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

#' File collection constructor
#'
#' @param pkg_name package name
#' @param df data frame
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Remove row names from data frame.
#'     \item Store \code{pkg_name} and \code{df} in a list.
#'     \item Assign class \code{file_collection} to the list.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @noRd
new_file_collection <- function(pkg_name, df) {
  row.names(df) <- NULL
  fc <- list("pkg_name" = pkg_name, "df" = df)
  class(fc) <- "file_collection"
  fc
}

#' Is this a file collection object?
#'
#' @param object Any R object.
#'
#' @return Logical. `TRUE` if it is a file collection object,
#' `FALSE` otherwise.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Check if the object has the class \code{file_collection}.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export is_file_collection
#'
#' @examples
#' system.file("examples/pkg1/", package = "pkglite") %>%
#'   collate(file_default()) %>%
#'   is_file_collection()
is_file_collection <- function(object) {
  if ("file_collection" %in% class(object)) TRUE else FALSE
}

#' Print a file collection
#'
#' @param x An object of class `file_collection`.
#' @param ... Additional parameters for [print()] (not used).
#'
#' @return The input `file_collection` object.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Print the metadata and the data frame in a file collection object.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export
#'
#' @examples
#' fc <- system.file("examples/pkg1/", package = "pkglite") %>%
#'   collate(file_default())
#' fc
print.file_collection <- function(x, ...) {
  pkg_name <- x$pkg_name
  df <- x$df
  # only prints relative path
  df$"path_abs" <- NULL

  cli_h1("File collection")
  cli_rule("Package: ", cli_pkg(pkg_name))
  print(df)
  invisible(x)
}

#' Merge file collections
#'
#' @param x File collection.
#' @param y Another file collection.
#' @param ... Additional file collections.
#'
#' @return Merged file collection.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Capture the file collection objects and store in a list.
#'     \item Check if all objects are file collection objects.
#'     \item Check if the file collections are for the same package.
#'     \item Bind the data frames from the file collections together and
#'     remove duplicated rows.
#'     \item Create a new file collection object with the merged data frame.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export
#'
#' @examples
#' pkg <- system.file("examples/pkg1/", package = "pkglite")
#' fc1 <- pkg %>% collate(file_root_core())
#' fc2 <- pkg %>% collate(file_r(), file_man())
#' merge(fc1, fc2)
merge.file_collection <- function(x, y, ...) {
  lst_fc <- list(x, y, ...)

  if (!all(sapply(lst_fc, is_file_collection))) {
    stop("All inputs must be file collection objects.", call. = FALSE)
  }
  pkg_name <- unique(sapply(lst_fc, "[[", "pkg_name"))
  if (length(pkg_name) != 1L) {
    stop("Can't merge file collections for different packages.", call. = FALSE)
  }

  rbind0 <- function(...) rbind(..., stringsAsFactors = FALSE)
  lst_df <- lapply(lst_fc, "[[", "df")
  df <- do.call(rbind0, lst_df)

  # remove duplicated rows if any
  df <- unique(df)
  # ensure relative paths are not duplicated
  if (anyDuplicated(df$"path_rel") != 0L) {
    stop("Some files share the same relative path but conflicting absolute paths.", call. = FALSE)
  }

  new_file_collection(pkg_name, df)
}

#' Remove files from a file collection
#'
#' @param x File collection.
#' @param path Character vector. Relative paths of the files to remove.
#'
#' @return Pruned file collection.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Remove the rows from the data frame whose relative paths
#'     match the given paths exactly.
#'     \item Create a new file collection object with the pruned data frame.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export prune
#'
#' @examples
#' system.file("examples/pkg1/", package = "pkglite") %>%
#'   collate(file_default()) %>%
#'   prune(path = c("NEWS.md", "man/figures/logo.png"))
prune <- function(x, path) UseMethod("prune")

#' @rdname prune
#' @export
prune.file_collection <- function(x, path) {
  pkg_name <- x$pkg_name
  df <- x$df
  path <- unique(path)

  idx <- match(path, df$"path_rel")
  if (anyNA(idx)) {
    warning(
      paste0(
        "Can't find files in file collection: ",
        paste0(path[is.na(idx)], collapse = ", ")
      )
    )
  }
  df <- df[setdiff(seq_len(nrow(df)), idx[!is.na(idx)]), ]

  new_file_collection(pkg_name, df)
}

#' Sanitize file collection
#'
#' Remove commonly excluded files from a file collection.
#'
#' @param x File collection.
#'
#' @return Sanitized file collection.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Remove the files whose names match certain patterns from the
#'     file collection and return a sanitized file collection.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export sanitize
#'
#' @examples
#' system.file("examples/pkg1/", package = "pkglite") %>%
#'   collate(file_default()) %>%
#'   sanitize()
sanitize <- function(x) UseMethod("sanitize")

#' @rdname sanitize
#' @export
sanitize.file_collection <- function(x) {
  pkg_name <- x$pkg_name
  df <- x$df
  df <- df[!grepl(cat_patterns(pattern_file_sanitize()), df$"path_abs"), ]
  new_file_collection(pkg_name, df)
}

#' Sanitize file collection (deprecated)
#'
#' Remove commonly excluded files from a file collection.
#'
#' @param x File collection.
#'
#' @return Sanitized file collection.
#'
#' @section Specification:
#' \if{latex}{
#'   \itemize{
#'     \item Remove the files whose names match certain patterns from the
#'     file collection and return a sanitized file collection.
#'   }
#' }
#' \if{html}{The contents of this section are shown in PDF user manual only.}
#'
#' @export sanitize_file_collection
#'
#' @examples
#' system.file("examples/pkg1/", package = "pkglite") %>%
#'   collate(file_default()) %>%
#'   sanitize()
sanitize_file_collection <- function(x) {
  .Deprecated("sanitize")
  sanitize(x)
}
