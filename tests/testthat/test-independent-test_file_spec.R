testthat::test_that("file_spec() creates the correct 'file_spec' object", {
  path <- "R/"
  pattern <- "\\.R$"
  format <- "text"
  recursive <- FALSE
  ignore_case <- TRUE
  all_files <- FALSE

  fs_source <- file_spec(
    path = path, pattern = pattern, format = format,
    recursive = recursive, ignore_case = ignore_case, all_files = all_files
  )

  testthat::expect_equal(fs_source$path, path)
  testthat::expect_equal(fs_source$pattern, pattern)
  testthat::expect_equal(fs_source$format, format)
  testthat::expect_equal(fs_source$recursive, recursive)
  testthat::expect_equal(fs_source$ignore_case, ignore_case)
  testthat::expect_equal(fs_source$all_files, all_files)
  testthat::expect_equal(class(fs_source), "file_spec")
  testthat::expect_error(file_spec(), "Must provide a non-empty `path`.")
})

testthat::test_that("is_file_spec() checks the presence of 'file_spec' as the class specifier", {
  path <- "R/"
  pattern <- "\\.R$"
  format <- "text"
  recursive <- FALSE
  ignore_case <- TRUE
  all_files <- FALSE

  fs_source <- file_spec(
    path = path, pattern = pattern, format = format,
    recursive = recursive, ignore_case = ignore_case, all_files = all_files
  )

  dummy <- 1
  class(dummy) <- "file"

  testthat::expect_equal(is_file_spec(fs_source), TRUE)
  testthat::expect_equal(is_file_spec(dummy), FALSE)
})


testthat::test_that("Check print.file_spec() is returning the right file_spec() object", {
  path <- "R/"
  pattern <- "\\.R$"
  format <- "text"
  recursive <- FALSE
  ignore_case <- TRUE
  all_files <- FALSE

  fs_source <- file_spec(
    path = path, pattern = pattern, format = format,
    recursive = recursive, ignore_case = ignore_case, all_files = all_files
  )

  x <- print.file_spec(fs_source)

  testthat::expect_equal(x, fs_source)
})
