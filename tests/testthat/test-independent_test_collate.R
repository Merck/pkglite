# locate example package path
find_package <- function(pkg) {
  system.file(paste0("examples/", pkg), package = "pkglite")
}

# list files under a folder in an example package
find_files <- function(pkg, dir, pattern) {
  pkg_path <- find_package(pkg)
  d <- file.path(paste(pkg_path, dir, sep = "/")) %>%
    list.files(
      pattern = pattern,
      ignore.case = TRUE,
      full.names = TRUE
    ) %>%
    gsub(pattern = paste0(".*", pkg, "/{1}"), replacement = "") %>%
    as.data.frame(stringsAsFactors = FALSE)
  names(d)[1] <- "files"
  d
}

testthat::test_that("collate returns the package name correctly", {
  pkg <- "pkg1"
  actual <- pkg %>%
    find_package() %>%
    collate(file_default())
  testthat::expect_equal(pkg, actual$pkg_name)
})

testthat::test_that("collate returns the full path correctly", {
  pkg <- "pkg1"
  files <- pkg %>%
    find_package() %>%
    collate(file_root_all())
  res <- files$df
  actual <- res$path_abs %>%
    gsub(pattern = paste0(pkg, ".*", "{1}"), replacement = "") %>%
    unique()

  path <- list.files(
    pkg %>% find_package(),
    pattern = paste0("*."),
    ignore.case = TRUE,
    full.names = TRUE
  )
  expected <- path %>%
    gsub(pattern = paste0(pkg, ".*", "{1}"), replacement = "") %>%
    unique()
  testthat::expect_equal(actual, expected)
})

testthat::test_that("collate returns the files names in the R directory correctly", {
  pkg <- "pkg1"
  actual <- pkg %>%
    find_package() %>%
    collate(file_r())
  expected <- find_files(pkg, dir = "R", pattern = "*.R$|.rda$")
  testthat::expect_equal(actual$df$path_rel, expected$files)
})

testthat::test_that("collate returns the help files correctly", {
  pkg <- "pkg1"
  files <- pkg %>%
    find_package() %>%
    collate(file_man())
  actual <- files$df %>% base::subset(format == "text")
  expected <- find_files(pkg, dir = "man", pattern = "*.Rd$")
  testthat::expect_equal(actual$path_rel, expected$files)
})

testthat::test_that("collate returns error when no file spec is passed through", {
  pkg <- "pkg1"
  testthat::expect_error(pkg %>% find_package() %>% collate())
})

testthat::test_that("collate returns 0-row data when the file spec is not in the right format", {
  pkg <- "pkg1"
  files <- pkg %>%
    find_package() %>%
    collate(file_src())
  testthat::expect_equal(nrow(files$df), 0L)
})

testthat::test_that("fs_to_df returns error when no path is passed through", {
  testthat::expect_error(fs_to_df(file_spec = file_default()))
})

testthat::test_that("fs_to_df returns error when no file spec is passed through", {
  testthat::expect_error(pkg %>% find_package() %>% fs_to_df())
})

testthat::test_that("fs_to_df returns 0-row data when the file spec is not in the right format", {
  pkg <- "pkg1"
  files <- pkg %>%
    find_package() %>%
    fs_to_df(file_src())
  testthat::expect_equal(nrow(files), 0L)
})

testthat::test_that("fs_to_df evaluates a file spec and return the data frame correctly", {
  lst <- list(
    "path" = "R/",
    "pattern" = "\\.R$",
    "format" = "text",
    "recursive" = FALSE,
    "ignore_case" = TRUE,
    "all_files" = FALSE
  )
  pkg <- "pkg1"
  actual <- pkg %>%
    find_package() %>%
    fs_to_df(file_spec = lst)
  expected_files <- list.files(
    file.path(pkg %>% find_package(), "R"),
    pattern = "*.R$",
    ignore.case = TRUE,
    full.names = TRUE
  )
  expected <- find_files(pkg, dir = "R", pattern = "*.R$")
  testthat::expect_equal(names(actual), c("path_abs", "path_rel", "format"))
  testthat::expect_equal(actual$path_rel, expected$files)
  testthat::expect_equal(actual$path_abs, expected_files)
  testthat::expect_length(object = actual$path_abs, n = nrow(expected))
})

testthat::test_that("is_file_collection detects whether an object is of class file collection", {
  pkg <- "pkg1"
  testthat::expect_false(
    pkg %>% find_package() %>%
      fs_to_df(file_spec = file_src()) %>%
      is_file_collection()
  )
})

testthat::test_that("print returns a data frame as expected", {
  pkg <- "pkg1"
  actual <- pkg %>%
    find_package() %>%
    collate(file_vignettes()) %>%
    print() %>%
    `[[`("df")
  files <- pkg %>% find_files(dir = "vignettes", pattern = "*")
  expected <- data.frame(
    "path_rel" = files$files,
    "format" = rep("text", length(files$files)),
    stringsAsFactors = FALSE
  )
  testthat::expect_identical(actual[, -1], expected)
})

testthat::test_that("get_pkg_name returns the package name correctly", {
  testthat::expect_equal(get_pkg_name(path = find_package("pkg1")), "pkg1")
  testthat::expect_equal(get_pkg_name(path = find_package("pkg2")), "pkg2")
})

testthat::test_that("create_fc_df returns the data frame correctly", {
  n_row <- 3L
  expected <- data.frame(
    "path_abs" = rep(NA, n_row),
    "path_rel" = rep(NA, n_row),
    "format" = rep(NA, n_row),
    stringsAsFactors = FALSE
  )
  testthat::expect_identical(expected, create_fc_df(n_row))
})

testthat::test_that("sanitize_file_collection can successfully
                    remove commonly excluded files and directories from a file collection", {
  actual = system.file("examples/pkg1/", package = "pkglite") %>%
    collate(file_default()) %>%
    sanitize_file_collection()

  path = paste(gsub(pattern = "(pkg1).*", "\\1", actual$df$path_abs[1]), ".DS_Store", sep = '/')
  #  manually add some rows with some of the special file name
  temp = rbind(actual$df,
               c(path, "test.DS_Store", "text"),
               c(path, "test.git", "binary"),
               c(path, "test.svn", "svn"),
               c(path, "test.hg", "hg"),
               c(path, "test.Rproj", " "),
               c(path, "test.Rhistory", " "),
               c(path, "test.RData", "binary"),
               c(path, "test.Ruserdata", "binary"),
               c(path, "test.user", "binary"))
  test <- actual
  test$df <- temp
  testthat::expect_equal(sanitize_file_collection(actual), sanitize_file_collection(test))
})
