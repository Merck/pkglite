cli_text <- function(...) {
  cat(paste0(..., "\n"), sep = "")
}

cli_h1 <- function(x) {
  line <- "-"
  width <- getOption("width")
  prefix <- crayon::cyan(paste0(line, line, " "))
  x <- crayon::bold(x)
  suffix <- crayon::bold(" ")
  line_length <- width - crayon::col_nchar(prefix) - crayon::col_nchar(x) - crayon::col_nchar(suffix)
  line_length <- max(0, line_length)
  cli_text(prefix, x, suffix, crayon::cyan(strrep(line, line_length)))
}

cli_rule <- function(x, y) {
  line <- "-"
  width <- getOption("width")
  prefix <- paste0(line, line, " ")
  suffix <- " "
  line_length <- width - nchar(prefix) - crayon::col_nchar(x) - crayon::col_nchar(y) - nchar(suffix)
  line_length <- max(0, line_length)
  cli_text(prefix, x, y, suffix, strrep(line, line_length))
}

cli_li <- function(...) {
  bullet <- "\u2022"
  cli_text(bullet, " ", ...)
}

cli_str <- function(...) {
  crayon::blue(encodeString(..., quote = "\""))
}

cli_bool <- function(...) {
  crayon::blue(...)
}

cli_num <- function(...) {
  crayon::green(...)
}

cli_pkg <- function(...) {
  crayon::blue(...)
}

cli_path_src <- function(...) {
  crayon::green(encodeString(file.path(...), quote = "\""))
}

cli_path_dst <- function(...) {
  crayon::blue(encodeString(file.path(...), quote = "\""))
}
