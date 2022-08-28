# pkglite 0.2.1

## Enhancements

- The file extension dictionary is extended to include many more file types
  used in R packages, such as `.stan` and `.brew` (#20, #34).
- Removed cli dependency (#26).
- Added independent testing for cli replacement functions (#29).
- Use `stop(call. = FALSE)` (#19).
- Run roxygen2 7.2.1 to generate valid HTML5 in Rd files (#35).

# pkglite 0.2.0

## New features

- Added a file specification template `file_tests()` (#2).
- New method to `merge()` file collection objects (#3).
- New method to `prune()` (remove files from) file collection objects (#4).
- Added `vignette("filecollection")` on curating file collections (#12).

## Bug fixes

- `collate()` now only collates files by applying shell-style tests (#7).

## Enhancements

- Added SAS binary file formats to dictionary (#8).
- Replaced `1:k` with `seq_len(k)` (#6).
- Removed the redundant `LazyData` field (#5).

# pkglite 0.1.1

- Added missing value section to Rd files.

# pkglite 0.1.0

- Initial version.
- Added a `NEWS.md` file to track changes to the package.
