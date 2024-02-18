test_that("pack returns the text file correctly", {
  res <- create_artifacts_pack()
  x <- pack(res$fc1, res$fc2, output = res$txt, quiet = TRUE)

  local_edition(3)
  expect_snapshot_file(save_txt(x %>% readLines()), "pack.txt")
})

test_that("get_fc_pkg returns the package name correctly", {
  res <- create_artifacts_pack()
  expect_equal(get_fc_pkg(list(res$fc1, res$fc2)), c("pkg1", "pkg2"))
})

test_that("fc_to_text returns the strings correctly", {
  res <- create_artifacts_pack()
  lst_fc <- list(res$fc1, res$fc2)

  local_edition(3)
  expect_snapshot_file(save_txt(fc_to_text(lst_fc[[1]]) %>% unlist()), "fc_to_text1.txt")
  expect_snapshot_file(save_txt(fc_to_text(lst_fc[[2]]) %>% unlist()), "fc_to_text2.txt")
})

test_that("file_to_vec returns the strings correctly", {
  res <- create_artifacts_pack()
  fc <- list(res$fc1, res$fc2)
  df <- fc[[1]][["df"]]
  pkg_name <- fc[[1]][["pkg_name"]]
  nfiles <- nrow(df)
  res <- lapply(
    1:nfiles, function(i) {
      path_rel <- df[i, "path_rel"]
      file_to_vec(
        df[i, "path_abs"],
        format = df[i, "format"],
        pkg_name = pkg_name,
        path_rel = path_rel
      )
    }
  ) %>% unlist()

  local_edition(3)
  expect_snapshot_file(save_txt(res), "file_to_vec.txt")
})

test_that("read_file_text returns the strings correctly", {
  res <- create_artifacts_pack()
  fc <- list(res$fc1, res$fc2)
  df <- fc[[1]][["df"]]

  local_edition(3)
  expect_snapshot_file(save_txt(read_file_text(df[1, "path_abs"])), "read_file_text1.txt")
  expect_snapshot_file(save_txt(read_file_text(df[2, "path_abs"])), "read_file_text2.txt")
  expect_snapshot_file(save_txt(read_file_text(df[3, "path_abs"])), "read_file_text3.txt")
  expect_snapshot_file(save_txt(read_file_text(df[4, "path_abs"])), "read_file_text4.txt")
  expect_snapshot_file(save_txt(read_file_text(df[5, "path_abs"])), "read_file_text5.txt")
})

test_that("get_file_size returns the correct file size", {
  res <- create_artifacts_pack()
  fc <- list(res$fc1, res$fc2)
  df <- fc[[1]][["df"]]
  file <- df[1, "path_abs"]
  expected <- file.info(file)$size
  actual <- get_file_size(file)
  expect_equal(expected, actual)
})

test_that("readbin_to_chr read a binary file as string correctly", {
  res <- create_artifacts_pack()
  fc <- list(res$fc1, res$fc2)
  df <- fc[[1]][["df"]]
  path <- df[1, "path_abs"]
  expected <- as.character(readBin(path, what = "raw", n = get_file_size(path)))
  actual <- readbin_to_char(path)
  expect_equal(expected, actual)
})
