test_that("file_spec() creates the correct 'file_spec' object", {
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

  expect_equal(fs_source$path, path)
  expect_equal(fs_source$pattern, pattern)
  expect_equal(fs_source$format, format)
  expect_equal(fs_source$recursive, recursive)
  expect_equal(fs_source$ignore_case, ignore_case)
  expect_equal(fs_source$all_files, all_files)
  expect_equal(class(fs_source), "file_spec")
  expect_error(file_spec(), "Must provide a non-empty `path`.")
})

test_that("is_file_spec() checks the presence of 'file_spec' as the class specifier", {
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

  expect_equal(is_file_spec(fs_source), TRUE)
  expect_equal(is_file_spec(dummy), FALSE)
})


test_that("Check print.file_spec() is returning the right file_spec() object", {
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

  expect_equal(x, fs_source)
})
