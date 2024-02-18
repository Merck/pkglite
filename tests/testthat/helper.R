# Locate example package path
find_package <- function(pkg) {
  system.file(file.path("examples", pkg), package = "pkglite")
}

# List files under a folder in an example package
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

# Check if `file_spec()` returns the right object
file_spec_func_valid <- function() {
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

  return(
    fs_source$path == path &
      fs_source$pattern == pattern &
      fs_source$format == format &
      fs_source$recursive == recursive &
      fs_source$ignore_case == ignore_case &
      fs_source$all_files == all_files &
      class(fs_source) == "file_spec"
  )
}

# Flatten the structure of a `file_spec` list
fs_unlist <- function(fs) {
  fs_len <- length(fs)
  ls <- list()
  ls_cnt <- 0

  if (fs_len) {
    for (i in seq_len(fs_len)) {
      x <- fs[[i]]
      if (class(x) == "file_spec") {
        ls_cnt <- ls_cnt + 1
        ls[[ls_cnt]] <- x
      } else if (class(x) == "list") {
        ls_tmp <- fs_unlist(x)
        for (j in seq_len(length(ls_tmp))) {
          ls_cnt <- ls_cnt + 1
          ls[[ls_cnt]] <- ls_tmp[[j]]
        }
      }
    }
  }
  ls
}

# Check if a `file_spec` object has all of the parameters as specified
is_file_spec_type <- function(fs_source, path, pattern, format, recursive, ignore_case, all_files) {
  return(fs_source$path == path &
    fs_source$pattern == pattern &
    fs_source$format == format &
    fs_source$recursive == recursive &
    fs_source$ignore_case == ignore_case &
    fs_source$all_files == all_files &
    class(fs_source) == "file_spec")
}

# Save string to a `.txt` file
save_txt <- function(code, path = tempfile(fileext = ".txt")) {
  writeLines(code, con = path)
  path
}

# Create artifacts for testing `pack()`
create_artifacts_pack <- function() {
  pkg1 <- system.file("examples/pkg1", package = "pkglite")
  pkg2 <- system.file("examples/pkg2", package = "pkglite")
  fc1 <- pkg1 %>% collate(file_default())
  fc2 <- pkg2 %>% collate(file_default())
  txt <- tempfile(fileext = ".txt")

  list("pkg1" = pkg1, "pkg2" = pkg2, "fc1" = fc1, "fc2" = fc2, "txt" = txt)
}

# Create artifacts for testing `unpack()`
create_artifacts_unpack <- function() {
  pkg1 <- "pkg1" %>% find_package()
  pkg2 <- "pkg2" %>% find_package()
  fc1 <- pkg1 %>% collate(file_r())
  fc2 <- pkg2 %>% collate(file_r())
  txt <- tempfile(fileext = ".txt")
  pack(fc1, fc2, output = txt, quiet = TRUE)

  list("pkg1" = pkg1, "pkg2" = pkg2, "fc1" = fc1, "fc2" = fc2, "txt" = txt)
}
