# Evaluate a list of file specifications

Evaluate a list of file specifications and bind the results as a file
collection.

## Usage

``` r
collate(pkg = ".", ...)
```

## Arguments

- pkg:

  Path to the package directory.

- ...:

  One or more file specification objects.

## Value

A file collection object containing the package name, file paths, and
file format types.

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
system.file("examples/pkg1/", package = "pkglite") %>%
  collate(file_default())
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
