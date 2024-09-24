test_that("Test ext_text() generate the right string list", {
  str_ls <- list(
    "r" = c("R", "r", "s", "q"),
    "man" = c("Rd", "rd"),
    "manfigures" = c("svg"),
    "src" = c(
      "c", "h", "cpp", "cc", "ipp", "cxx", "hpp", "hxx", "hh", "cu", "cuh",
      "f", "f90", "f95", "f03",
      "win", "in", "ucrt", "ac", "mk", "guess"
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
