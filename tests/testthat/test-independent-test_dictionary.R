test_that("Test ext_text() generate the right string list", {
  str_ls <- list(
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

  ls_target <- str_ls
  ls_source <- ext_text()
  expect_equal(ls_source, ls_target)

  ls_target_f <- unique(unlist(str_ls))
  ls_source_f <- ext_text(flat = TRUE)
  expect_equal(ls_source_f, ls_target_f)
})


test_that("Test ext_binary() generate the right string list", {
  str_ls <- list(
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

  ls_target <- str_ls
  ls_source <- ext_binary()
  expect_equal(ls_source, ls_target)

  ls_target_f <- unique(unlist(str_ls))
  ls_source_f <- ext_binary(flat = TRUE)
  expect_equal(ls_source_f, ls_target_f)
})


test_that("Test pattern_file_root_core() generate the right string list", {
  str_ls <- c(
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

  ls_target <- str_ls
  ls_source <- pattern_file_root_core()
  expect_equal(ls_source, ls_target)
})


test_that("Test pattern_file_root_all() generate the right string list", {
  str_ls <- c(
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

  ls_target <- str_ls
  ls_source <- pattern_file_root_all()
  expect_equal(ls_source, ls_target)
})


test_that("Test pattern_file_sanitize() generate the right string list", {
  str_ls <- c(
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

  ls_target <- str_ls
  ls_source <- pattern_file_sanitize()
  expect_equal(ls_source, ls_target)
})
