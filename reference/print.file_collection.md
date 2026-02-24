# Print a file collection

Print a file collection

## Usage

``` r
# S3 method for class 'file_collection'
print(x, ...)
```

## Arguments

- x:

  An object of class `file_collection`.

- ...:

  Additional parameters for
  [`print()`](https://rdrr.io/r/base/print.html) (not used).

## Value

The input `file_collection` object.

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
fc <- system.file("examples/pkg1/", package = "pkglite") %>%
  collate(file_default())
fc
#> -- File collection -------------------------------------------------------
#> -- Package: pkg1 ---------------------------------------------------------
#>                 path_rel format
#> 1            DESCRIPTION   text
#> 2              NAMESPACE   text
#> 3                NEWS.md   text
#> 4              README.md   text
#> 5               R/data.R   text
#> 6              R/hello.R   text
#> 7       R/pkg1-package.R   text
#> 8          R/sysdata.rda binary
#> 9         man/dataset.Rd   text
#> 10    man/hello_world.Rd   text
#> 11   man/pkg1-package.Rd   text
#> 12  man/figures/logo.png binary
#> 13 vignettes/example.bib   text
#> 14    vignettes/pkg1.Rmd   text
#> 15      data/dataset.rda binary
```
