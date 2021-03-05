pkg1 <- system.file("examples/pkg1", package = "pkglite")
pkg2 <- system.file("examples/pkg2", package = "pkglite")
fc1 <- pkg1 %>% collate(file_default())
fc2 <- pkg2 %>% collate(file_default())
txt <- tempfile(fileext = ".txt")

save_txt <- function(code, path = tempfile(fileext = ".txt")) {
  writeLines(code, con = path)
  path
}

testthat::test_that("pack returns the text file correctly", {
  local_edition(3)
  x <- pack(fc1, fc2, output = txt, quiet = TRUE)
  testthat::expect_snapshot_file(save_txt(x %>% readLines()), "pack.txt", binary = FALSE)
})

testthat::test_that("get_fc_pkg returns the package name correctly", {
  testthat::expect_equal(get_fc_pkg(list(fc1, fc2)), c("pkg1", "pkg2"))
})

testthat::test_that("fc_to_text returns the strings correctly", {
  local_edition(3)
  lst_fc <- list(fc1, fc2)
  testthat::expect_snapshot_file(save_txt(fc_to_text(lst_fc[[1]]) %>% unlist()), "fc_to_text1.txt", binary = FALSE)
  testthat::expect_snapshot_file(save_txt(fc_to_text(lst_fc[[2]]) %>% unlist()), "fc_to_text2.txt", binary = FALSE)
})

testthat::test_that("file_to_vec returns the strings correctly", {
  local_edition(3)
  fc <- list(fc1, fc2)
  df <- fc[[1]][["df"]]
  pkg_name <- fc[[1]][["pkg_name"]]
  nfiles <- nrow(df)
  res <- lapply(1:nfiles, function(i) {
    path_rel <- df[i, "path_rel"]
    file_to_vec(df[i, "path_abs"], format = df[i, "format"], pkg_name = pkg_name, path_rel = path_rel)
  }) %>% unlist()

  testthat::expect_snapshot_file(save_txt(res), "file_to_vec.txt", binary = FALSE)
})

testthat::test_that("read_file_text returns the strings correctly", {
  local_edition(3)
  fc <- list(fc1, fc2)
  df <- fc[[1]][["df"]]
  testthat::expect_snapshot_file(save_txt(read_file_text(df[1, "path_abs"])), "read_file_text1.txt", binary = FALSE)
  testthat::expect_snapshot_file(save_txt(read_file_text(df[2, "path_abs"])), "read_file_text2.txt", binary = FALSE)
  testthat::expect_snapshot_file(save_txt(read_file_text(df[3, "path_abs"])), "read_file_text3.txt", binary = FALSE)
  testthat::expect_snapshot_file(save_txt(read_file_text(df[4, "path_abs"])), "read_file_text4.txt", binary = FALSE)
  testthat::expect_snapshot_file(save_txt(read_file_text(df[5, "path_abs"])), "read_file_text5.txt", binary = FALSE)
})

testthat::test_that("get_file_size returns the correct file size", {
  fc <- list(fc1, fc2)
  df <- fc[[1]][["df"]]
  file <- df[1, "path_abs"]
  expected <- file.info(file)$size
  actual <- get_file_size(file)
  testthat::expect_equal(expected, actual)
})

testthat::test_that("readbin_to_chr read a binary file as string correctly", {
  fc <- list(fc1, fc2)
  df <- fc[[1]][["df"]]
  path <- df[1, "path_abs"]
  expected <- as.character(readBin(path, what = "raw", n = get_file_size(path)))
  actual <- readbin_to_char(path)
  testthat::expect_equal(expected, actual)
})
