test_that("unpack returns the right files", {
  res <- create_artifacts_unpack()
  out <- file.path(tempdir(), "twopkgs")
  res$txt %>% unpack(output = out, quiet = TRUE)

  expect_equal(
    out %>% file.path("pkg1/R") %>% list.files(),
    res$pkg1 %>% file.path("/R") %>% list.files()
  )
  expect_equal(
    out %>% file.path("pkg2/R") %>% list.files(),
    res$pkg2 %>% file.path("/R") %>% list.files()
  )
})

test_that("unpack returns error when input is not in the right format", {
  out <- file.path(tempdir(), "twopkgs")
  expect_error(unpack(output = out, quiet = TRUE))
})

test_that("unpack can successfully install the packages after unpacking", {
  skip_on_cran()

  pkg1 <- "pkg1" %>% find_package()
  pkg2 <- "pkg2" %>% find_package()
  fc1 <- pkg1 %>% collate(file_default())
  fc2 <- pkg2 %>% collate(file_default())
  txt <- tempfile(fileext = ".txt")
  pack(fc1, fc2, output = txt, quiet = TRUE)

  out <- file.path(tempdir(), "twopkgs")
  temp_lib <- file.path(tempdir(), "templib")
  invisible(dir.create(temp_lib))
  txt %>% unpack(output = out, quiet = TRUE, install = TRUE, lib = temp_lib, force = TRUE)

  expect_true("pkg1" %in% list.files(temp_lib))
  expect_true("pkg2" %in% list.files(temp_lib))

  unlink(temp_lib, recursive = TRUE)
})

test_that("read_pkglite returns the pkg names correctly", {
  res <- create_artifacts_unpack()
  pkg <- read_pkglite(res$txt)
  expect_equal(pkg$pkg_name %>% unique(), c("pkg1", "pkg2"))
})

test_that("read_pkglite returns the file path correctly", {
  res <- create_artifacts_unpack()
  actual <- read_pkglite(res$txt)
  temp1 <- "pkg1" %>% find_files(dir = "R", pattern = "")
  res1 <- temp1$files %>% gsub(pattern = ".*pkg1/", replacement = "")
  temp2 <- "pkg2" %>% find_files(dir = "R", pattern = "")
  res2 <- temp2$files %>% gsub(pattern = ".*pkg2/", replacement = "")
  expected <- c(res1, res2)

  expect_equal(actual$path, expected)
})

test_that("match_field returns zero integer when the input is not valid", {
  expect_true(match_field("test", "Package") %>% length() == 0L)
  expect_true(match_field(123, "Package") %>% length() == 0L)
  expect_true(match_field("test", "Package") %>% length() == 0L)
})

test_that("match_field returns numerical vector", {
  res <- create_artifacts_unpack()
  input <- readLines(res$txt)

  expect_true(match_field(input, "Package") %>% is.numeric())
  expect_true(match_field(input, "File") %>% is.numeric())
  expect_true(match_field(input, "Format") %>% is.numeric())
})

test_that("extract_value returns the file path correctly", {
  res <- create_artifacts_unpack()
  input <- readLines(res$txt)
  ind <- match_field(input, "File")
  actual <- extract_value(input[ind])
  temp1 <- "pkg1" %>% find_files(dir = "R", pattern = "")
  res1 <- temp1$files %>% gsub(pattern = ".*pkg1/", replacement = "")
  temp2 <- "pkg2" %>% find_files(dir = "R", pattern = "")
  res2 <- temp2$files %>% gsub(pattern = ".*pkg2/", replacement = "")
  expected <- c(res1, res2)

  expect_equal(actual, expected)
})

test_that("split_str_by_two returns the output as expected", {
  x <- "hello world"
  expect_type(split_str_by_two(x), "character")
  expect_equal(split_str_by_two(x) %>% length(), 6)
})
