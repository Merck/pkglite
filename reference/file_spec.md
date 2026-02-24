# Create a file specification

Specify which files to include

## Usage

``` r
file_spec(
  path,
  pattern = NULL,
  format = c("binary", "text"),
  recursive = TRUE,
  ignore_case = TRUE,
  all_files = FALSE
)
```

## Arguments

- path:

  Path relative to the package root), for example, `"inst/"`.

- pattern:

  Regular expression for matching the file names.

- format:

  File format type, one of `"binary"` or `"text"`.

- recursive:

  List files in the sub-directories?

- ignore_case:

  Should pattern-matching be case-insensitive?

- all_files:

  List all files including the invisible ones?

## Value

A file specification object.

## Details

Most of the parameters are passed through
[`list.files()`](https://rdrr.io/r/base/list.files.html).

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
file_spec(
  "R/",
  pattern = "\\.R$", format = "text",
  recursive = FALSE, ignore_case = TRUE, all_files = FALSE
)
#> -- File specification ----------------------------------------------------
#> - Relative path: "R/"
#> - Pattern: "\\.R$"
#> - Format: "text"
#> - Recursive: FALSE
#> - Ignore case: TRUE
#> - All files: FALSE
```
