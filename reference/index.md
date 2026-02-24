# Package index

## Pack packages

Pack package(s) into a text file

- [`pack()`](https://merck.github.io/pkglite/reference/pack.md) : Pack
  packages into a text file

## Unpack packages

Unpack package(s) from a text file

- [`unpack()`](https://merck.github.io/pkglite/reference/unpack.md) :
  Unpack packages from a text file

## File specifications

Specifies the files to include in a package

- [`file_spec()`](https://merck.github.io/pkglite/reference/file_spec.md)
  : Create a file specification
- [`file_auto()`](https://merck.github.io/pkglite/reference/file_auto.md)
  : File specification (automatic guess)
- [`file_default()`](https://merck.github.io/pkglite/reference/file_default.md)
  : File specification (default combination)
- [`file_ectd()`](https://merck.github.io/pkglite/reference/file_ectd.md)
  : File specification (eCTD submission)
- [`file_root_core()`](https://merck.github.io/pkglite/reference/file_spec_templates.md)
  [`file_root_all()`](https://merck.github.io/pkglite/reference/file_spec_templates.md)
  [`file_r()`](https://merck.github.io/pkglite/reference/file_spec_templates.md)
  [`file_man()`](https://merck.github.io/pkglite/reference/file_spec_templates.md)
  [`file_src()`](https://merck.github.io/pkglite/reference/file_spec_templates.md)
  [`file_vignettes()`](https://merck.github.io/pkglite/reference/file_spec_templates.md)
  [`file_data()`](https://merck.github.io/pkglite/reference/file_spec_templates.md)
  [`file_tests()`](https://merck.github.io/pkglite/reference/file_spec_templates.md)
  : File specification templates
- [`is_file_spec()`](https://merck.github.io/pkglite/reference/is_file_spec.md)
  : Is this a file specification object?
- [`print(`*`<file_spec>`*`)`](https://merck.github.io/pkglite/reference/print.file_spec.md)
  : Print a file specification

## File collections

Evaluated file specifications

- [`collate()`](https://merck.github.io/pkglite/reference/collate.md) :
  Evaluate a list of file specifications
- [`is_file_collection()`](https://merck.github.io/pkglite/reference/is_file_collection.md)
  : Is this a file collection object?
- [`print(`*`<file_collection>`*`)`](https://merck.github.io/pkglite/reference/print.file_collection.md)
  : Print a file collection
- [`merge(`*`<file_collection>`*`)`](https://merck.github.io/pkglite/reference/merge.file_collection.md)
  : Merge file collections
- [`prune()`](https://merck.github.io/pkglite/reference/prune.md) :
  Remove files from a file collection
- [`sanitize()`](https://merck.github.io/pkglite/reference/sanitize.md)
  : Sanitize file collection

## Utilities

Utility functions

- [`verify_ascii()`](https://merck.github.io/pkglite/reference/verify_ascii.md)
  : Check if a file contains only ASCII characters
- [`remove_content()`](https://merck.github.io/pkglite/reference/remove_content.md)
  : Remove content lines from a pkglite file

## Dictionaries

Standard file extensions and patterns

- [`ext_text()`](https://merck.github.io/pkglite/reference/ext_text.md)
  : Common file extensions (text)
- [`ext_binary()`](https://merck.github.io/pkglite/reference/ext_binary.md)
  : Common file extensions (binary)
- [`pattern_file_root_core()`](https://merck.github.io/pkglite/reference/file_name_patterns.md)
  [`pattern_file_root_all()`](https://merck.github.io/pkglite/reference/file_name_patterns.md)
  [`pattern_file_src()`](https://merck.github.io/pkglite/reference/file_name_patterns.md)
  [`pattern_file_sanitize()`](https://merck.github.io/pkglite/reference/file_name_patterns.md)
  : Common File name patterns

## Deprecated

Deprecated functions that will be removed

- [`sanitize_file_collection()`](https://merck.github.io/pkglite/reference/sanitize_file_collection.md)
  : Sanitize file collection (deprecated)
