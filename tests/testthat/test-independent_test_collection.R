test_that("is_file_collection detects whether an object is of class
                    file collection", {
  pkg <- "pkg1"
  expect_false(
    pkg %>%
      find_package() %>%
      fs_to_df(file_spec = file_src()) %>%
      is_file_collection()
  )
})

test_that("print returns a data frame as expected", {
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
  expect_identical(actual[, -1], expected)
})

test_that("merge can merge two empty file collections and return
                    an empty file collection", {
  fc1 <- new_file_collection("pkg1", df = create_fc_df(0))
  pkg <- system.file("examples/pkg1/", package = "pkglite")
  fc2 <- pkg %>% collate(file_root_core())
  fc2$df <- create_fc_df(0)
  expect_true(merge(fc1, fc2) %>% is_file_collection())
})

test_that("merge returns error when some inputs are not
                    file collection objects", {
  pkg <- system.file("examples/pkg1/", package = "pkglite")
  fc1 <- pkg %>% collate(file_root_core())
  fc2 <- c("apple", "oranges")
  expect_error(merge(fc1, fc2))
})

test_that("merge returns error when the input file collections
                    are for different packages", {
  pkg1 <- system.file("examples/pkg1/", package = "pkglite")
  fc1 <- pkg1 %>% collate(file_root_core())
  pkg2 <- system.file("examples/pkg2/", package = "pkglite")
  fc2 <- pkg2 %>% collate(file_root_core())
  expect_error(merge(fc1, fc2))
})

test_that("merge returns a file collection with the correct
                    number of files when the file collections contain
                    non-duplicated relative paths", {
  pkg <- system.file("examples/pkg1/", package = "pkglite")
  fc1 <- pkg %>% collate(file_r())
  fc2 <- pkg %>% collate(file_man())
  fc_merged <- merge(fc1, fc2)
  expect_equal(nrow(fc_merged$df), nrow(fc1$df) + nrow(fc2$df))
})

test_that("merge returns a file collection with the correct
                    number of files when the file collections contain
                    duplicated relative paths", {
  pkg <- system.file("examples/pkg1/", package = "pkglite")
  fc1 <- pkg %>% collate(file_root_core())
  fc2 <- pkg %>% collate(file_r(), file_root_core())
  x <- union(fc1$df$path_rel, fc2$df$path_rel)
  fc_merged <- merge(fc1, fc2)
  expect_equal(nrow(fc_merged$df), length(x))
})

test_that("prune returns the same file collection when no files
                    match the provided path", {
  fc <- system.file("examples/pkg1/", package = "pkglite") %>%
    collate(file_r())
  expect_warning(fc %>% prune(c("NEWS.md", "man/figures/logo.png")))

  oldw <- getOption("warn")
  options(warn = -1)
  fc_new <- fc %>% prune(path = "NEWS.md")
  options(warn = oldw)

  expect_equal(fc, fc_new)
})

test_that("prune returns a file collection with the correct
                    number of files when some files match the provided path", {
  fc <- system.file("examples/pkg1/", package = "pkglite") %>%
    collate(file_default())

  oldw <- getOption("warn")
  options(warn = -1)
  fc_pruned <- fc %>% prune(c("NEWS.md", "man/figures/logo.png", "README.rmd"))
  options(warn = oldw)

  x <- intersect(fc$df$path_rel, c("NEWS.md", "man/figures/logo.png", "README.rmd"))
  expect_equal(nrow(fc$df) - length(x), nrow(fc_pruned$df))
})

test_that("prune returns an empty file collection object
                    when all files are removed", {
  fc <- system.file("examples/pkg1/", package = "pkglite") %>%
    collate(file_root_core())
  fc_pruned <- fc %>% prune(c("DESCRIPTION", "NAMESPACE", "NEWS.md", "README.md"))
  expect_equal(nrow(fc_pruned$df), 0)
})

test_that("prune returns a file collection with the correct
                    number of rows with a warning when the provided path
                    can be partially matched", {
  expect_warning(system.file("examples/pkg1/", package = "pkglite") %>%
    collate(file_default()) %>%
    prune(path = c("NEWS.md", "man/figure/logo.png")))
  fc <- system.file("examples/pkg1/", package = "pkglite") %>%
    collate(file_default())
  oldw <- getOption("warn")
  options(warn = -1)
  fc_pruned <- fc %>% prune(c("NEWS.md", "man/figure/logo.png", "README.rmd"))
  options(warn = oldw)
  expect_equal(nrow(fc_pruned$df), 14)
})

test_that("sanitize can successfully remove commonly excluded
                    files and directories from a file collection", {
  actual <- system.file("examples/pkg1/", package = "pkglite") %>%
    collate(file_default()) %>%
    sanitize()

  path <- paste(gsub(pattern = "(pkg1).*", "\\1", actual$df$path_abs[1]), ".DS_Store", sep = "/")
  # manually add some rows with some of the special file name
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
  expect_equal(sanitize(actual), sanitize(test))
})
