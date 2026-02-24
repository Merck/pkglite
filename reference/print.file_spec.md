# Print a file specification

Print a file specification

## Usage

``` r
# S3 method for class 'file_spec'
print(x, ...)
```

## Arguments

- x:

  An object of class `file_spec`.

- ...:

  Additional parameters for
  [`print()`](https://rdrr.io/r/base/print.html) (not used).

## Value

The input `file_spec` object.

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
fs <- file_spec(
  "R/",
  pattern = "\\.R$", format = "text",
  recursive = FALSE, ignore_case = TRUE, all_files = FALSE
)
fs
#> -- File specification ----------------------------------------------------
#> - Relative path: "R/"
#> - Pattern: "\\.R$"
#> - Format: "text"
#> - Recursive: FALSE
#> - Ignore case: TRUE
#> - All files: FALSE
```
