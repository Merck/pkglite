# Changelog

## pkglite 0.2.5

CRAN release: 2026-02-24

### Maintenance

- Update maintainer email
  ([\#61](https://github.com/Merck/pkglite/issues/61)).
- Update GitHub Actions workflows to the latest versions
  ([\#61](https://github.com/Merck/pkglite/issues/61)).

## pkglite 0.2.4

CRAN release: 2024-11-09

### Enhancements

- Increase the default file specification coverage for
  [`file_src()`](https://merck.github.io/pkglite/reference/file_spec_templates.md).
  This helps identifying the correct file collections for R packages
  with `src/Makevars` or `src/Makefile`, for example, packages that
  interface with Stan via the rstan package
  ([\#56](https://github.com/Merck/pkglite/issues/56)).
- Expand the binary file extension dictionary to cover files frequently
  used in machine learning frameworks
  ([\#57](https://github.com/Merck/pkglite/issues/57)).

## pkglite 0.2.3

CRAN release: 2024-09-25

### Enhancements

- Expand the text and binary file extension dictionary by using the
  latest data from 21,369 CRAN packages. This increases the default file
  specifications coverage when discovering files
  ([\#51](https://github.com/Merck/pkglite/issues/51)).
- Add a BibTeX key to `inst/CITATION` so that the BibTeX item generated
  by `citation("pkglite")` is rendered with a proper default key.
  ([\#53](https://github.com/Merck/pkglite/issues/53)).

## pkglite 0.2.2

CRAN release: 2024-02-21

### Enhancements

- Move previous test logic that has “test file scope” into
  `tests/testthat/helper.R` to follow best practices
  ([\#45](https://github.com/Merck/pkglite/issues/45)).

## pkglite 0.2.1

CRAN release: 2022-08-28

### Enhancements

- The file extension dictionary is extended to include many more file
  types used in R packages, such as `.stan` and `.brew`
  ([\#20](https://github.com/Merck/pkglite/issues/20),
  [\#34](https://github.com/Merck/pkglite/issues/34)).
- Removed cli dependency
  ([\#26](https://github.com/Merck/pkglite/issues/26)).
- Added independent testing for cli replacement functions
  ([\#29](https://github.com/Merck/pkglite/issues/29)).
- Use `stop(call. = FALSE)`
  ([\#19](https://github.com/Merck/pkglite/issues/19)).
- Run roxygen2 7.2.1 to generate valid HTML5 in Rd files
  ([\#35](https://github.com/Merck/pkglite/issues/35)).

## pkglite 0.2.0

CRAN release: 2021-05-22

### New features

- Added a file specification template
  [`file_tests()`](https://merck.github.io/pkglite/reference/file_spec_templates.md)
  ([\#2](https://github.com/Merck/pkglite/issues/2)).
- New method to [`merge()`](https://rdrr.io/r/base/merge.html) file
  collection objects ([\#3](https://github.com/Merck/pkglite/issues/3)).
- New method to
  [`prune()`](https://merck.github.io/pkglite/reference/prune.md)
  (remove files from) file collection objects
  ([\#4](https://github.com/Merck/pkglite/issues/4)).
- Added
  [`vignette("filecollection")`](https://merck.github.io/pkglite/articles/filecollection.md)
  on curating file collections
  ([\#12](https://github.com/Merck/pkglite/issues/12)).

### Bug fixes

- [`collate()`](https://merck.github.io/pkglite/reference/collate.md)
  now only collates files by applying shell-style tests
  ([\#7](https://github.com/Merck/pkglite/issues/7)).

### Enhancements

- Added SAS binary file formats to dictionary
  ([\#8](https://github.com/Merck/pkglite/issues/8)).
- Replaced `1:k` with `seq_len(k)`
  ([\#6](https://github.com/Merck/pkglite/issues/6)).
- Removed the redundant `LazyData` field
  ([\#5](https://github.com/Merck/pkglite/issues/5)).

## pkglite 0.1.1

CRAN release: 2021-03-08

- Added missing value section to Rd files.

## pkglite 0.1.0

- Initial version.
- Added a `NEWS.md` file to track changes to the package.
