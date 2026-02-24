# File specification (eCTD submission)

A combination of file specifications for eCTD submissions.

## Usage

``` r
file_ectd()
```

## Value

A list of file specifications.

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
file_ectd()
#> [[1]]
#> -- File specification ----------------------------------------------------
#> - Relative path: ""
#> - Pattern: "^DESCRIPTION$|^NAMESPACE$|^README$|^README\\.Rmd$|^README\\.md$|^NEWS$|^NEWS\\.md$|^LICENSE$|^LICENCE$|^LICENSE\\.note$|^LICENCE\\.note$|\\.Rbuildignore$|\\.Rinstignore$|^configure$|^configure\\.win$|^configure\\.ucrt$|^configure\\.ac$|^configure\\.in$|^cleanup$|^cleanup\\.win$|^cleanup\\.ucrt$"
#> - Format: "text"
#> - Recursive: FALSE
#> - Ignore case: FALSE
#> - All files: TRUE
#> 
#> [[2]]
#> [[2]][[1]]
#> -- File specification ----------------------------------------------------
#> - Relative path: "R/"
#> - Pattern: "\\.R$|\\.r$|\\.s$|\\.q$"
#> - Format: "text"
#> - Recursive: FALSE
#> - Ignore case: TRUE
#> - All files: FALSE
#> 
#> [[2]][[2]]
#> -- File specification ----------------------------------------------------
#> - Relative path: "R/"
#> - Pattern: "^sysdata\\.rda$"
#> - Format: "binary"
#> - Recursive: FALSE
#> - Ignore case: TRUE
#> - All files: FALSE
#> 
#> 
#> [[3]]
#> [[3]][[1]]
#> -- File specification ----------------------------------------------------
#> - Relative path: "man/"
#> - Pattern: "\\.Rd$|\\.rd$"
#> - Format: "text"
#> - Recursive: FALSE
#> - Ignore case: TRUE
#> - All files: FALSE
#> 
#> [[3]][[2]]
#> -- File specification ----------------------------------------------------
#> - Relative path: "man/figures/"
#> - Pattern: "\\.jpg$|\\.jpeg$|\\.pdf$|\\.png$"
#> - Format: "binary"
#> - Recursive: FALSE
#> - Ignore case: TRUE
#> - All files: FALSE
#> 
#> [[3]][[3]]
#> -- File specification ----------------------------------------------------
#> - Relative path: "man/figures/"
#> - Pattern: "\\.svg$"
#> - Format: "text"
#> - Recursive: FALSE
#> - Ignore case: TRUE
#> - All files: FALSE
#> 
#> 
#> [[4]]
#> [[4]][[1]]
#> -- File specification ----------------------------------------------------
#> - Relative path: "src/"
#> - Pattern: "^Makevars$|^Makevars\\.win$|^Makevars\\.ucrt$|^Makefile$|^Makefile\\.win$|^Makefile\\.ucrt$|^CMakeLists\\.txt$"
#> - Format: "text"
#> - Recursive: TRUE
#> - Ignore case: FALSE
#> - All files: FALSE
#> 
#> [[4]][[2]]
#> -- File specification ----------------------------------------------------
#> - Relative path: "src/"
#> - Pattern: "\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.ipp$|\\.cxx$|\\.hpp$|\\.hxx$|\\.hh$|\\.cu$|\\.cuh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.ucrt$|\\.in$|\\.ac$|\\.mk$|\\.guess$|\\.def$"
#> - Format: "text"
#> - Recursive: TRUE
#> - Ignore case: TRUE
#> - All files: FALSE
#> 
#> 
#> [[5]]
#> -- File specification ----------------------------------------------------
#> - Relative path: "data/"
#> - Pattern: "\\.rda$|\\.RData$"
#> - Format: "binary"
#> - Recursive: FALSE
#> - Ignore case: TRUE
#> - All files: FALSE
#> 
```
