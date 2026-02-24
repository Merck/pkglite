# Is this a file collection object?

Is this a file collection object?

## Usage

``` r
is_file_collection(object)
```

## Arguments

- object:

  Any R object.

## Value

Logical. `TRUE` if it is a file collection object, `FALSE` otherwise.

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
system.file("examples/pkg1/", package = "pkglite") %>%
  collate(file_default()) %>%
  is_file_collection()
#> [1] TRUE
```
