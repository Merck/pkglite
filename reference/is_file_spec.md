# Is this a file specification object?

Is this a file specification object?

## Usage

``` r
is_file_spec(object)
```

## Arguments

- object:

  Any R object

## Value

Logical. `TRUE` if it is a file specification object, `FALSE` otherwise.

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
file_spec(
  "R/",
  pattern = "\\.R$", format = "text",
  recursive = FALSE, ignore_case = TRUE, all_files = FALSE
) %>%
  is_file_spec()
#> [1] TRUE
```
