test_that("verify_ascii() should check if all texts in file are printable", {
  # test binary
  out_bin <- c(
    "fa\xE7ile test of showNonASCII():",
    "\\details{",
    "   This is a good line",
    "   This has an \xfcmlaut in it.",
    "   OK again.",
    "}"
  )
  f_bin <- tempfile()
  cat(out_bin, file = f_bin, sep = "\n")

  # test text
  out_txt <- c(
    "Just simple texts",
    "very simple :)",
    "}"
  )
  f_txt <- tempfile()
  cat(out_txt, file = f_txt, sep = "\n")

  expect_equal(verify_ascii(f_bin), FALSE)
  expect_equal(verify_ascii(f_txt), TRUE)
  expect_error(verify_ascii(), "Must provide an input file.")

  unlink(f_bin)
  unlink(f_txt)
})


test_that("remove_content() removing specified target line (must be indented by two space chars) from file", {
  target_str <- c("remove", "me")
  # indented by two space chars indicating a content line
  target_ln <- paste0("  ", target_str)

  out_txt <- c(
    "Just simple texts",
    "## New Features",
    "  very simple :)",
    target_str,
    target_ln,
    "}"
  )
  f_txt <- tempfile()
  cat(out_txt, file = f_txt, sep = "\n")

  remove_content(f_txt, target_str)

  cleaned <- readLines(f_txt)

  t_ln_cleaned <- as.logical(sum(!is.na(match(cleaned, target_ln))))
  t_str_cleaned <- as.logical(sum(!is.na(match(cleaned, target_str))))

  # non-content target kept?
  expect_equal(t_str_cleaned, TRUE)
  # content targets kept ?
  expect_equal(t_ln_cleaned, FALSE)

  unlink(f_txt)
})
