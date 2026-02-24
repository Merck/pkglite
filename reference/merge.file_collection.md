# Merge file collections

Merge file collections

## Usage

``` r
# S3 method for class 'file_collection'
merge(x, y, ...)
```

## Arguments

- x:

  File collection.

- y:

  Another file collection.

- ...:

  Additional file collections.

## Value

Merged file collection.

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
pkg <- system.file("examples/pkg1/", package = "pkglite")
fc1 <- pkg %>% collate(file_root_core())
fc2 <- pkg %>% collate(file_r(), file_man())
merge(fc1, fc2)
#> -- File collection -------------------------------------------------------
#> -- Package: pkg1 ---------------------------------------------------------
#>                path_rel format
#> 1           DESCRIPTION   text
#> 2             NAMESPACE   text
#> 3               NEWS.md   text
#> 4             README.md   text
#> 5              R/data.R   text
#> 6             R/hello.R   text
#> 7      R/pkg1-package.R   text
#> 8         R/sysdata.rda binary
#> 9        man/dataset.Rd   text
#> 10   man/hello_world.Rd   text
#> 11  man/pkg1-package.Rd   text
#> 12 man/figures/logo.png binary
```
