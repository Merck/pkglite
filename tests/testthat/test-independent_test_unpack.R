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

pkg1 <- "pkg1" %>% find_package()
pkg2 <- "pkg2" %>% find_package()
fc1 <- pkg1 %>% collate(file_r())
fc2 <- pkg2 %>% collate(file_r())
txt <- tempfile(fileext = ".txt")

pack(fc1, fc2, output = txt, quiet = TRUE)

testthat::test_that("unpack returns the right files", {
  out <- file.path(tempdir(), "twopkgs")
  txt %>% unpack(output = out, quiet = TRUE)
  testthat::expect_equal(
    out %>% file.path("pkg1/R") %>% list.files(),
    pkg1 %>% file.path("/R") %>% list.files()
  )
  testthat::expect_equal(
    out %>% file.path("pkg2/R") %>% list.files(),
    pkg2 %>% file.path("/R") %>% list.files()
  )
})

testthat::test_that("unpack returns error when input is not in the right format", {
  out <- file.path(tempdir(), "twopkgs")
  testthat::expect_error(unpack(output = out, quiet = TRUE))
})

testthat::test_that("unpack can successfully install the packages after unpacking", {
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
  testthat::expect_true("pkg1" %in% list.files(temp_lib))
  testthat::expect_true("pkg2" %in% list.files(temp_lib))
  unlink(temp_lib, recursive = TRUE)
})

testthat::test_that("read_pkglite returns the pkg names correctly", {
  res <- read_pkglite(txt)
  testthat::expect_equal(res$pkg_name %>% unique(), c("pkg1", "pkg2"))
})

testthat::test_that("read_pkglite returns the file path correctly", {
  actual <- read_pkglite(txt)
  temp1 <- "pkg1" %>% find_files(dir = "R", pattern = "")
  res1 <- temp1$files %>% gsub(pattern = ".*pkg1/", replacement = "")
  temp2 <- "pkg2" %>% find_files(dir = "R", pattern = "")
  res2 <- temp2$files %>% gsub(pattern = ".*pkg2/", replacement = "")
  expected <- c(res1, res2)
  testthat::expect_equal(actual$path, expected)
})

testthat::test_that("match_field returns zero integer when the input is not valid", {
  testthat::expect_true(match_field("test", "Package") %>% length() == 0L)
  testthat::expect_true(match_field(123, "Package") %>% length() == 0L)
  testthat::expect_true(match_field("test", "Package") %>% length() == 0L)
})

testthat::test_that("match_field returns numerical vector", {
  input <- readLines(txt)
  testthat::expect_true(match_field(input, "Package") %>% is.numeric())
  testthat::expect_true(match_field(input, "File") %>% is.numeric())
  testthat::expect_true(match_field(input, "Format") %>% is.numeric())
})

testthat::test_that("extract_value returns the file path correctly", {
  input <- readLines(txt)
  ind <- match_field(input, "File")
  actual <- extract_value(input[ind])
  temp1 <- "pkg1" %>% find_files(dir = "R", pattern = "")
  res1 <- temp1$files %>% gsub(pattern = ".*pkg1/", replacement = "")
  temp2 <- "pkg2" %>% find_files(dir = "R", pattern = "")
  res2 <- temp2$files %>% gsub(pattern = ".*pkg2/", replacement = "")
  expected <- c(res1, res2)
  testthat::expect_equal(actual, expected)
})

testthat::test_that("split_str_by_two returns the output as expected", {
  x <- "hello world"
  testthat::expect_type(split_str_by_two(x), "character")
  testthat::expect_equal(split_str_by_two(x) %>% length(), 6)
})
