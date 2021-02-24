# pkglite <img src="man/figures/logo.png" alt="" align="right" height="139" />

[![CRAN
status](https://www.r-pkg.org/badges/version/pkglite)](https://CRAN.R-project.org/package=pkglite)
[![CRAN
Downloads](https://cranlogs.r-pkg.org/badges/pkglite)](https://cran.r-project.org/package=pkglite)
<!-- badges: end -->

A tool, grammar, and standard to represent and exchange
R package source code as text files. Converts one or more source
packages to a text file and restores the package structures from the file.

- To get started, see `vignette("pkglite")`.
- To create file specifications, see `vignette("filespec")`.
- The text file format is described in `vignette("format")`.

## Installation

You can install the package via CRAN:

```r
install.packages("pkglite")
```

Or, install from GitHub:

```r
remotes::install_github("Merck/pkglite")
```

## Workflow

```r
library("pkglite")
```

Pack one R package:

```r
"/path/to/package/" %>%
  collate(file_default()) %>%
  pack()
```

Pack multiple R packages:

```r
pack(
  "/path/to/pkg1/" %>% collate(file_default()),
  "/path/to/pkg2/" %>% collate(file_default()),
  output = "/path/to/pkglite.txt"
)
```

Unpack one or more packages:

```r
"/path/to/pkglite.txt" %>%
  unpack(output = "/path/to/output/")
```
