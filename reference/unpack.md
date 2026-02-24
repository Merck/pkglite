# Unpack packages from a text file

Unpack packages from a text file

## Usage

``` r
unpack(input, output = ".", install = FALSE, quiet = FALSE, ...)
```

## Arguments

- input:

  Path to the text file.

- output:

  Path to the output directory. Each package is placed under a
  subdirectory named after the package name. Default is the current
  working directory.

- install:

  Try install the unpacked package(s)?

- quiet:

  Suppress printing of progress?

- ...:

  Additional parameters for
  [`remotes::install_local()`](https://remotes.r-lib.org/reference/install_local.html).

## Value

The output directory path.

## Details

If `install = TRUE`, the packages will be installed by the order of
appearance in the `input` file. When internal dependencies exist between
these packages, make sure they are packed in the order where the
low-level dependencies appear first.

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
# pack two packages
pkg1 <- system.file("examples/pkg1", package = "pkglite")
pkg2 <- system.file("examples/pkg2", package = "pkglite")

fc1 <- pkg1 %>% collate(file_default())
fc2 <- pkg2 %>% collate(file_default())

txt <- tempfile(fileext = ".txt")
pack(fc1, fc2, output = txt, quiet = TRUE)

# unpack the two packages
out <- file.path(tempdir(), "twopkgs")
txt %>% unpack(output = out, quiet = TRUE)

out %>%
  file.path("pkg1") %>%
  list.files()
#> [1] "DESCRIPTION" "NAMESPACE"   "NEWS.md"     "R"           "README.md"  
#> [6] "data"        "man"         "vignettes"  
out %>%
  file.path("pkg2") %>%
  list.files()
#> [1] "DESCRIPTION" "NAMESPACE"   "NEWS.md"     "R"           "README.md"  
#> [6] "data"        "man"         "vignettes"  
```
