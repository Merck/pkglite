# pkglite <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->
[![R-CMD-check](https://github.com/Merck/pkglite/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Merck/pkglite/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/Merck/pkglite/branch/master/graph/badge.svg)](https://app.codecov.io/gh/Merck/pkglite?branch=master)
[![CRAN status](https://www.r-pkg.org/badges/version/pkglite)](https://CRAN.R-project.org/package=pkglite)
[![CRAN Downloads](https://cranlogs.r-pkg.org/badges/pkglite)](https://CRAN.R-project.org/package=pkglite)
<!-- badges: end -->

A tool, grammar, and standard to represent and exchange
R package source code as text files. Converts one or more source
packages to a text file and restores the package structures from the file.

- To get started, see `vignette("pkglite")`.
- To generate file specifications, see `vignette("filespec")`.
- To curate file collections, see `vignette("filecollection")`.
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

## Citation

If you use this software, please cite it as below.

> Zhao, Y., Xiao, N., Anderson, K., & Zhang, Y. (2023).
> Electronic common technical document submission with analysis using R.
> _Clinical Trials_, **20**(1), 89--92.
> https://doi.org/10.1177/17407745221123244

A BibTeX entry for LaTeX users is

```bibtex
@article{zhao2023electronic,
  title   = {Electronic common technical document submission with analysis using {R}},
  author  = {Zhao, Yujie and Xiao, Nan and Anderson, Keaven and Zhang, Yilong},
  journal = {Clinical Trials},
  volume  = {20},
  number  = {1},
  pages   = {89--92},
  year    = {2023},
  doi     = {10.1177/17407745221123244}
}
```
