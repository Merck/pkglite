test_that("cli_text prints concatenated texts with \n as separator", {
  strs <- c("str1", "str2", "str999")
  cli_text(strs)
  expect_output(cli_text(strs), regexp = "str1\\nstr2\\nstr999")
})

test_that("cli_h1 prints string as header with prefix and suffix", {
  strs <- "This is a test heading"
  strl <- "This is a really longgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg heading"
  cli_h1(strs)
  cli_h1(strl)
  expect_output(cli_h1(strs), regexp = ".*?This is a test heading.*?\\-+.*")
  expect_output(cli_h1(strl), regexp = ".*?This is a really long+ heading.*?\\-*")
})

test_that("cli_rule combines strings and prints as header with prefix and suffix", {
  strs <- "This is a test heading "
  strs2 <- "plus other things"
  strl <- "This is a heading with some special symbols like *,;%#$."
  strs3 <- ""
  cli_rule(strs, strs2)
  cli_rule(strl, strs2)
  expect_output(cli_rule(strs, strs2), regexp = "\\-\\- This is a test heading plus other things \\-+")
  expect_output(cli_rule(strl, strs2), regexp = "\\-\\- This is a heading with some special symbols like \\*,;%#\\$\\.plus other things \\-+")
})

test_that("cli_li prints string with a leading bullet point", {
  strs <- "This is a test heading "
  strs2 <- "plus other things"
  cli_li(strs, strs2)
  expect_output(cli_li(strs, strs2), regexp = "- This is a test heading plus other things")
})

test_that("cli_str create strings with double quotation in blue when printed in console", {
  strs <- "This is a test string"
  expect_equal(cli_str(strs), crayon::blue(paste0('"', strs, '"')))
})

test_that("cli_bool creates boolean object in blue color", {
  strs <- TRUE
  expect_equal(cli_bool(strs), crayon::blue(strs))
})

test_that("cli_num output string as header with prefix and suffix", {
  nums <- 123
  expect_equal(cli_num(nums), crayon::green(nums))
})

test_that("cli_pkg creates package name in blue", {
  strs <- "test_pkg_name_in_blue"
  expect_equal(cli_pkg(strs), crayon::blue(strs))
})

test_that("cli_path_src output string in green with double quotations surrounded", {
  fd1 <- "/opt"
  fd2 <- "folder"
  fd3 <- "another-folder"
  expect_equal(cli_path_src(fd1, fd2, fd3), crayon::green('"/opt/folder/another-folder"'))
})

test_that("cli_path_dst output string in blue with double quotations surrounded", {
  fd1 <- "/opt"
  fd2 <- "folder"
  fd3 <- "another-folder"
  expect_equal(cli_path_dst(fd1, fd2, fd3), crayon::blue('"/opt/folder/another-folder"'))
})
