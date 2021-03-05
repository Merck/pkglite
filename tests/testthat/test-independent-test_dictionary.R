test_that("Test ext_text() generate the right string list", {
  str_ls <- list(
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
      "png", "jpg", "jpeg", "bmp", "gif", "tiff", "emf",
      "ico", "webp", "eps", "pdf"
    ),
    "src" = c("o", "so"),
    "mso" = c("docx", "xlsx", "pptx", "doc", "xls", "ppt")
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
    "^README\\.md$",
    "^NEWS$",
    "^NEWS\\.md$",
    "^LICENSE$",
    "\\.Rbuildignore$"
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
