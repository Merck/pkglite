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
    "r" = c("R", "r", "s", "q"),
    "man" = c("Rd", "rd"),
    "manfigures" = c("svg"),
    "src" = c(
      "c", "h", "cpp", "cc", "hpp", "hxx", "hh",
      "f", "f90", "f95", "f03",
      "win", "in", "ucrt", "ac"
    ),
    "vignette" = c(
      "Rmd", "md", "csl", "Rnw", "tex", "ltx", "rsp", "cls", "sty",
      "bib", "bst", "asis", "el"
    ),
    "meta" = c("Rproj", "dcf", "yml", "yaml", "note"),
    "table" = c("csv", "tsv", "txt"),
    "figure" = c("svg"),
    "web" = c("html", "htm", "shtml", "css", "js", "json", "xml", "scss", "less"),
    "doc" = c("rtf"),
    "log" = c("save", "Rout"),
    "proglang" = c(
      "stan", "bug", "jags", "py", "ipynb", "sh", "java", "bat", "m4", "cmake",
      "sql", "lua", "rs", "jl", "pl", "pm", "brew"
    ),
    "gettext" = c("po", "pot"),
    "geo" = c("geojson", "kml", "prj", "cpg", "qpj"),
    "bio" = c("fasta", "fastq", "vcf", "ped", "bim", "fam", "gff", "gtf")
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
      "png", "jpg", "jpeg", "bmp", "gif", "tif", "tiff", "emf", "svgz",
      "ico", "webp", "eps", "pdf",
      "ppm", "pgm", "pbm", "pnm"
    ),
    "src" = c("o", "so"),
    "build" = c("rdb", "rdx"),
    "web" = c("woff2", "woff", "otf", "ttf", "eot"),
    "mso" = c("docx", "xlsx", "pptx", "xltx", "potx", "doc", "xls", "ppt"),
    "odf" = c("odt", "ods", "odp", "odg", "odc", "odf", "odi", "odm", "odb"),
    "sas" = c("sas7bdat", "sas7bcat", "xpt", "xpt5", "xpt8"),
    "archive" = c("zip", "tar", "gz", "tgz", "bz2", "7z", "xz"),
    "db" = c("sqlite", "sqlite3"),
    "proglang" = c("pyc", "jar"),
    "gettext" = c("mo"),
    "geo" = c("shx", "shp", "laz", "sbx", "sbn", "nc", "gpkg"),
    "bio" = c("bam", "bai"),
    "audio" = c("wav", "mp3", "mid", "ogg", "au", "m4a"),
    "video" = c("mp4", "avi", "mov", "mkv", "webm")
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
    "^README\\.Rmd$",
    "^README\\.md$",
    "^NEWS$",
    "^NEWS\\.md$",
    "^LICENSE$",
    "^LICENCE$",
    "^LICENSE\\.note$",
    "^LICENCE\\.note$",
    "\\.Rbuildignore$",
    "\\.Rinstignore$",
    "^configure$",
    "^configure\\.win$",
    "^configure\\.ac$",
    "^configure\\.in$",
    "^cleanup$",
    "^cleanup\\.win$"
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
    "^LICENCE$",
    "^configure$",
    "^cleanup$",
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
