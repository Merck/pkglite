# pkglite

A tool, grammar, and standard to represent and exchange R package source
code as text files. Converts one or more source packages to a text file
and restores the package structures from the file.

- To get started, see
  [`vignette("pkglite")`](https://merck.github.io/pkglite/articles/pkglite.md).
- To generate file specifications, see
  [`vignette("filespec")`](https://merck.github.io/pkglite/articles/filespec.md).
- To curate file collections, see
  [`vignette("filecollection")`](https://merck.github.io/pkglite/articles/filecollection.md).
- The text file format is described in
  [`vignette("format")`](https://merck.github.io/pkglite/articles/format.md).

## Installation

You can install the package via CRAN:

``` r
install.packages("pkglite")
```

Or, install from GitHub:

``` r
remotes::install_github("Merck/pkglite")
```

## Workflow

``` r
library("pkglite")
```

Pack one R package:

``` r
"/path/to/package/" %>%
  collate(file_default()) %>%
  pack()
```

Pack multiple R packages:

``` r
pack(
  "/path/to/pkg1/" %>% collate(file_default()),
  "/path/to/pkg2/" %>% collate(file_default()),
  output = "/path/to/pkglite.txt"
)
```

Unpack one or more packages:

``` r
"/path/to/pkglite.txt" %>%
  unpack(output = "/path/to/output/")
```

## Citation

If you use this software, please cite it as below.

> Zhao, Y., Xiao, N., Anderson, K., & Zhang, Y. (2023). Electronic
> common technical document submission with analysis using R. *Clinical
> Trials*, **20**(1), 89–92. <https://doi.org/10.1177/17407745221123244>

A BibTeX entry for LaTeX users is

``` bibtex
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
