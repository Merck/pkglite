test_that("collate returns the package name correctly", {
  pkg <- "pkg1"
  actual <- pkg %>%
    find_package() %>%
    collate(file_default())
  expect_equal(pkg, actual$pkg_name)
})

test_that("collate returns the full path correctly", {
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
  expect_equal(actual, expected)
})

test_that("collate returns the files names in the R directory correctly", {
  pkg <- "pkg1"
  actual <- pkg %>%
    find_package() %>%
    collate(file_r())
  expected <- find_files(pkg, dir = "R", pattern = "*.R$|.rda$")
  expect_equal(actual$df$path_rel, expected$files)
})

test_that("collate returns the help files correctly", {
  pkg <- "pkg1"
  files <- pkg %>%
    find_package() %>%
    collate(file_man())
  actual <- files$df %>% base::subset(format == "text")
  expected <- find_files(pkg, dir = "man", pattern = "*.Rd$")
  expect_equal(actual$path_rel, expected$files)
})

test_that("collate returns error when no file spec is passed through", {
  pkg <- "pkg1"
  expect_error(pkg %>% find_package() %>% collate())
})

test_that("collate returns 0-row data when the file spec is not in the right format", {
  pkg <- "pkg1"
  files <- pkg %>%
    find_package() %>%
    collate(file_src())
  expect_equal(nrow(files$df), 0L)
})

test_that("fs_to_df returns error when no path is passed through", {
  expect_error(fs_to_df(file_spec = file_default()))
})

test_that("fs_to_df returns error when no file spec is passed through", {
  expect_error(pkg %>% find_package() %>% fs_to_df())
})

test_that("fs_to_df returns 0-row data when the file spec is not in the right format", {
  pkg <- "pkg1"
  files <- pkg %>%
    find_package() %>%
    fs_to_df(file_src()[[2]])
  expect_equal(nrow(files), 0L)
})

test_that("fs_to_df evaluates a file spec and return the data frame correctly", {
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
  expect_equal(names(actual), c("path_abs", "path_rel", "format"))
  expect_equal(actual$path_rel, expected$files)
  expect_equal(actual$path_abs, expected_files)
  expect_length(object = actual$path_abs, n = nrow(expected))
})

test_that("get_pkg_name returns the package name correctly", {
  expect_equal(get_pkg_name(path = find_package("pkg1")), "pkg1")
  expect_equal(get_pkg_name(path = find_package("pkg2")), "pkg2")
})

test_that("create_fc_df returns the data frame correctly", {
  n_row <- 3L
  expected <- data.frame(
    "path_abs" = rep(NA, n_row),
    "path_rel" = rep(NA, n_row),
    "format" = rep(NA, n_row),
    stringsAsFactors = FALSE
  )
  expect_identical(expected, create_fc_df(n_row))
})
