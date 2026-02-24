# Check if a file contains only ASCII characters

Check if a file contains only ASCII characters

## Usage

``` r
verify_ascii(input, quiet = FALSE)
```

## Arguments

- input:

  Path to the text file.

- quiet:

  Print the elements containing non-ASCII characters?

## Value

Logical. `TRUE` if the file only contains ASCII characters, `FALSE`
otherwise.

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
pkg <- system.file("examples/pkg1", package = "pkglite")
txt <- tempfile(fileext = ".txt")

pkg %>%
  collate(file_default()) %>%
  pack(output = txt, quiet = TRUE) %>%
  verify_ascii()
#> [1] TRUE
```
