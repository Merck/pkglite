#  Copyright (c) 2024 Merck & Co., Inc., Rahway, NJ, USA and its affiliates. All rights reserved.
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
      "c", "h", "cpp", "cc", "ipp", "cxx", "hpp", "hxx", "hh", "cu", "cuh",
      "f", "f90", "f95", "f03",
      "win", "ucrt", "in", "ac", "mk", "guess", "def"
    ),
    "vignette" = c(
      "Rmd", "qmd", "orig", "md", "tex", "csl", "Rnw", "Snw", "Rtex", "Stex",
      "rsp", "Rasciidoc", "Rhtml", "lyx", "ltx", "dtx", "cls", "sty", "aux",
      "bib", "bibtex", "bst", "bbl", "asis", "el"
    ),
    "meta" = c("Rproj", "dcf", "yml", "yaml", "toml", "note"),
    "table" = c("csv", "tsv", "txt"),
    "figure" = c("svg", "ps", "dot", "drawio"),
    "web" = c(
      "html", "htm", "shtml", "css", "scss", "sass", "less",
      "js", "cjs", "mjs", "jsx", "wasm",
      "json", "ndjson", "jsonl", "jsonld", "json5", "topojson",
      "xml", "xsd", "xsl", "xslt", "dtd"
    ),
    "doc" = c("rtf"),
    "log" = c("save", "Rout", "log"),
    "proglang" = c(
      "stan", "bug", "jags", "py", "ipynb", "sh", "java", "bat", "m4", "cmake",
      "sql", "graphql", "lua", "rs", "lock", "jl", "pl", "pm", "brew",
      "scala", "awk", "rb", "sas", "m", "asm"
    ),
    "gettext" = c("po", "pot"),
    "geo" = c("geojson", "kml", "prj", "cpg", "qpj"),
    "bio" = c(
      "fasta", "fas", "fa", "faa", "fai",
      "fastq", "vcf", "ped", "bim", "fam", "gff", "gff3", "gtf"
    ),
    "generic" = c(
      "markdown", "rst", "typ",
      "ini", "conf", "slurm", "ris", "cff",
      "fwf", "arff", "graphml", "gexf"
    )
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
      "ppm", "pgm", "pbm", "pnm",
      "xcf", "psd", "graffle"
    ),
    "src" = c("o", "so"),
    "build" = c("rdb", "rdx"),
    "web" = c("woff2", "woff", "otf", "ttf", "eot"),
    "mso" = c("docx", "xlsx", "pptx", "xltx", "potx", "doc", "xls", "ppt", "xlsb", "xlsm"),
    "odf" = c("odt", "ods", "odp", "odg", "odc", "odf", "odi", "odm", "odb"),
    "sas" = c("sas7bdat", "sas7bcat", "xpt", "xpt5", "xpt8"),
    "archive" = c("zip", "tar", "gz", "tgz", "bz2", "7z", "xz"),
    "db" = c("sqlite", "sqlite3", "dbf", "accdb", "mdb"),
    "proglang" = c("pyc", "jar"),
    "gettext" = c("mo"),
    "geo" = c("shx", "shp", "laz", "sbx", "sbn", "nc", "gpkg"),
    "bio" = c("bam", "bai"),
    "audio" = c("wav", "mp3", "mid", "ogg", "au", "m4a"),
    "video" = c("mp4", "avi", "mov", "mkv", "webm"),
    "generic" = c(
      "bin", "epub", "h5", "hdf5", "onnx",
      "parquet", "feather", "pkl", "npy"
    )
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
    "^configure\\.ucrt$",
    "^configure\\.ac$",
    "^configure\\.in$",
    "^cleanup$",
    "^cleanup\\.win$",
    "^cleanup\\.ucrt$"
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
#' @export pattern_file_src
pattern_file_src <- function() {
  c(
    "^Makevars$",
    "^Makevars\\.win$",
    "^Makevars\\.ucrt$",
    "^Makefile$",
    "^Makefile\\.win$",
    "^Makefile\\.ucrt$",
    "^CMakeLists\\.txt$"
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
