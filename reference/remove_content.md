# Remove content lines from a pkglite file

Remove content lines from a pkglite file

## Usage

``` r
remove_content(input, x, quiet = FALSE)
```

## Arguments

- input:

  Path to the text file.

- x:

  A character vector. Exactly matched lines in the file content will be
  removed.

- quiet:

  Suppress printing of progress?

## Value

The input file path.

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
pkg <- system.file("examples/pkg1", package = "pkglite")
txt <- tempfile(fileext = ".txt")

pkg %>%
  collate(file_default()) %>%
  pack(output = txt, quiet = TRUE) %>%
  remove_content(c("## New Features", "## Improvements"), quiet = TRUE)
```
