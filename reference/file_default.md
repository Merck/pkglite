# File specification (default combination)

A default combination of common file specifications.

## Usage

``` r
file_default()
```

## Value

A list of file specifications.

## Specification

The contents of this section are shown in PDF user manual only.

## Examples

``` r
file_default()
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
#> [[5]][[1]]
#> -- File specification ----------------------------------------------------
#> - Relative path: "vignettes/"
#> - Pattern: "\\.R$|\\.r$|\\.s$|\\.q$|\\.Rd$|\\.rd$|\\.svg$|\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.ipp$|\\.cxx$|\\.hpp$|\\.hxx$|\\.hh$|\\.cu$|\\.cuh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.ucrt$|\\.in$|\\.ac$|\\.mk$|\\.guess$|\\.def$|\\.Rmd$|\\.qmd$|\\.orig$|\\.md$|\\.tex$|\\.csl$|\\.Rnw$|\\.Snw$|\\.Rtex$|\\.Stex$|\\.rsp$|\\.Rasciidoc$|\\.Rhtml$|\\.lyx$|\\.ltx$|\\.dtx$|\\.cls$|\\.sty$|\\.aux$|\\.bib$|\\.bibtex$|\\.bst$|\\.bbl$|\\.asis$|\\.el$|\\.Rproj$|\\.dcf$|\\.yml$|\\.yaml$|\\.toml$|\\.note$|\\.csv$|\\.tsv$|\\.txt$|\\.ps$|\\.dot$|\\.drawio$|\\.html$|\\.htm$|\\.shtml$|\\.css$|\\.scss$|\\.sass$|\\.less$|\\.js$|\\.cjs$|\\.mjs$|\\.jsx$|\\.wasm$|\\.json$|\\.ndjson$|\\.jsonl$|\\.jsonld$|\\.json5$|\\.topojson$|\\.xml$|\\.xsd$|\\.xsl$|\\.xslt$|\\.dtd$|\\.rtf$|\\.save$|\\.Rout$|\\.log$|\\.stan$|\\.bug$|\\.jags$|\\.py$|\\.ipynb$|\\.sh$|\\.java$|\\.bat$|\\.m4$|\\.cmake$|\\.sql$|\\.graphql$|\\.lua$|\\.rs$|\\.lock$|\\.jl$|\\.pl$|\\.pm$|\\.brew$|\\.scala$|\\.awk$|\\.rb$|\\.sas$|\\.m$|\\.asm$|\\.po$|\\.pot$|\\.geojson$|\\.kml$|\\.prj$|\\.cpg$|\\.qpj$|\\.fasta$|\\.fas$|\\.fa$|\\.faa$|\\.fai$|\\.fastq$|\\.vcf$|\\.ped$|\\.bim$|\\.fam$|\\.gff$|\\.gff3$|\\.gtf$|\\.markdown$|\\.rst$|\\.typ$|\\.ini$|\\.conf$|\\.slurm$|\\.ris$|\\.cff$|\\.fwf$|\\.arff$|\\.graphml$|\\.gexf$"
#> - Format: "text"
#> - Recursive: TRUE
#> - Ignore case: TRUE
#> - All files: TRUE
#> 
#> [[5]][[2]]
#> -- File specification ----------------------------------------------------
#> - Relative path: "vignettes/"
#> - Pattern: "\\.rda$|\\.rds$|\\.RData$|\\.jpg$|\\.jpeg$|\\.pdf$|\\.png$|\\.bmp$|\\.gif$|\\.tif$|\\.tiff$|\\.emf$|\\.svgz$|\\.ico$|\\.webp$|\\.eps$|\\.ppm$|\\.pgm$|\\.pbm$|\\.pnm$|\\.xcf$|\\.psd$|\\.graffle$|\\.o$|\\.so$|\\.rdb$|\\.rdx$|\\.woff2$|\\.woff$|\\.otf$|\\.ttf$|\\.eot$|\\.docx$|\\.xlsx$|\\.pptx$|\\.xltx$|\\.potx$|\\.doc$|\\.xls$|\\.ppt$|\\.xlsb$|\\.xlsm$|\\.odt$|\\.ods$|\\.odp$|\\.odg$|\\.odc$|\\.odf$|\\.odi$|\\.odm$|\\.odb$|\\.sas7bdat$|\\.sas7bcat$|\\.xpt$|\\.xpt5$|\\.xpt8$|\\.zip$|\\.tar$|\\.gz$|\\.tgz$|\\.bz2$|\\.7z$|\\.xz$|\\.sqlite$|\\.sqlite3$|\\.dbf$|\\.accdb$|\\.mdb$|\\.pyc$|\\.jar$|\\.mo$|\\.shx$|\\.shp$|\\.laz$|\\.sbx$|\\.sbn$|\\.nc$|\\.gpkg$|\\.bam$|\\.bai$|\\.wav$|\\.mp3$|\\.mid$|\\.ogg$|\\.au$|\\.m4a$|\\.mp4$|\\.avi$|\\.mov$|\\.mkv$|\\.webm$|\\.bin$|\\.epub$|\\.hdf5$|\\.h5$|\\.parquet$|\\.feather$|\\.msgpack$|\\.pickle$|\\.pkl$|\\.npy$|\\.npz$|\\.safetensors$|\\.pt$|\\.pth$|\\.keras$|\\.tfrecord$|\\.pb$|\\.ckpt$|\\.onnx$"
#> - Format: "binary"
#> - Recursive: TRUE
#> - Ignore case: TRUE
#> - All files: TRUE
#> 
#> 
#> [[6]]
#> -- File specification ----------------------------------------------------
#> - Relative path: "data/"
#> - Pattern: "\\.rda$|\\.RData$"
#> - Format: "binary"
#> - Recursive: FALSE
#> - Ignore case: TRUE
#> - All files: FALSE
#> 
```
