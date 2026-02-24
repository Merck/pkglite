# Remove files from a file collection

Remove files from a file collection

## Usage

``` r
prune(x, path)

# S3 method for class 'file_collection'
prune(x, path)
```

## Arguments

- x:

  File collection.

- path:

  Character vector. Relative paths of the files to remove.

## Value

Pruned file collection.

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
system.file("examples/pkg1/", package = "pkglite") %>%
  collate(file_default()) %>%
  prune(path = c("NEWS.md", "man/figures/logo.png"))
#> -- File collection -------------------------------------------------------
#> -- Package: pkg1 ---------------------------------------------------------
#>                 path_rel format
#> 1            DESCRIPTION   text
#> 2              NAMESPACE   text
#> 3              README.md   text
#> 4               R/data.R   text
#> 5              R/hello.R   text
#> 6       R/pkg1-package.R   text
#> 7          R/sysdata.rda binary
#> 8         man/dataset.Rd   text
#> 9     man/hello_world.Rd   text
#> 10   man/pkg1-package.Rd   text
#> 11 vignettes/example.bib   text
#> 12    vignettes/pkg1.Rmd   text
#> 13      data/dataset.rda binary
```
