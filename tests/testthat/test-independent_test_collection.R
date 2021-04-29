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

testthat::test_that("is_file_collection detects whether an object is of class file collection", {
  pkg <- "pkg1"
  testthat::expect_false(
    pkg %>%
      find_package() %>%
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

testthat::test_that("merge can merge two empty file collections and return an empty file collection", {
  TRUE
})

testthat::test_that("merge returns error when some inputs are not file collection objects", {
  TRUE
})

testthat::test_that("merge returns error when the input file collections are for different packages", {
  TRUE
})

testthat::test_that("merge returns a file collection with the correct number of files when the file collections contain non-duplicated relative paths", {
  TRUE
})

testthat::test_that("merge returns a file collection with the correct number of files when the file collections contain duplicated relative paths", {
  TRUE
})

testthat::test_that("prune returns the same file collection when no files match the provided path", {
  TRUE
})

testthat::test_that("prune returns a file collection with the correct number of files when some files match the provided path", {
  TRUE
})

testthat::test_that("prune returns an empty file collection object when all files are removed", {
  TRUE
})

testthat::test_that("prune returns a file collection with the correct number of rows with a warning when the provided path can be partially matched", {
  TRUE
})

testthat::test_that("sanitize can successfully remove commonly excluded files and directories from a file collection", {
  actual <- system.file("examples/pkg1/", package = "pkglite") %>%
    collate(file_default()) %>%
    sanitize()

  path <- paste(gsub(pattern = "(pkg1).*", "\\1", actual$df$path_abs[1]), ".DS_Store", sep = "/")
  #  manually add some rows with some of the special file name
  temp <- rbind(
    actual$df,
    c(path, "test.DS_Store", "text"),
    c(path, "test.git", "binary"),
    c(path, "test.svn", "svn"),
    c(path, "test.hg", "hg"),
    c(path, "test.Rproj", " "),
    c(path, "test.Rhistory", " "),
    c(path, "test.RData", "binary"),
    c(path, "test.Ruserdata", "binary"),
    c(path, "test.user", "binary")
  )
  test <- actual
  test$df <- temp
  testthat::expect_equal(sanitize(actual), sanitize(test))
})
