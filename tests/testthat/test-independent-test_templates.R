test_that("file_root_core() creates the correct 'file_spec' object", {
  is_root_core <- is_file_spec_type(
    fs_source = file_root_core(),
    path = "",
    pattern = "^DESCRIPTION$|^NAMESPACE$|^README$|^README\\.Rmd$|^README\\.md$|^NEWS$|^NEWS\\.md$|^LICENSE$|^LICENCE$|^LICENSE\\.note$|^LICENCE\\.note$|\\.Rbuildignore$|\\.Rinstignore$|^configure$|^configure\\.win$|^configure\\.ucrt$|^configure\\.ac$|^configure\\.in$|^cleanup$|^cleanup\\.win$|^cleanup\\.ucrt$",
    format = "text",
    recursive = FALSE,
    ignore_case = FALSE,
    all_files = TRUE
  )

  expect_equal(is_root_core, TRUE)
})

test_that("file_root_all() creates the correct 'file_spec' object", {
  is_root_all <- is_file_spec_type(
    fs_source = file_root_all(),
    path = "",
    pattern = "^DESCRIPTION$|^NAMESPACE$|^README$|^NEWS$|^LICENSE$|^LICENCE$|^configure$|^cleanup$|*[.]",
    format = "text",
    recursive = FALSE,
    ignore_case = TRUE,
    all_files = TRUE
  )

  expect_equal(is_root_all, TRUE)
})

test_that("file_r() creates the correct 'file_spec' objects", {
  fs_source <- file_r()
  is_spec_code <- FALSE
  is_spec_data <- FALSE

  fs_len <- length(fs_source)

  if (fs_len == 2) {
    for (i in seq_len(fs_len)) {
      fs <- fs_source[[i]]
      if (!is_spec_code & is_file_spec_type(
        fs_source = fs,
        path = "R/",
        pattern = "\\.R$|\\.r$|\\.s$|\\.q$",
        format = "text",
        recursive = FALSE,
        ignore_case = TRUE,
        all_files = FALSE
      )
      ) {
        is_spec_code <- TRUE
      } else if
      (!is_spec_data & is_file_spec_type(
          fs_source = fs,
          path = "R/",
          pattern = "^sysdata\\.rda$",
          format = "binary",
          recursive = FALSE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_spec_data <- TRUE
      }
    }
  }

  expect_equal(is_spec_code, TRUE)
  expect_equal(is_spec_data, TRUE)
})

test_that("file_man() creates the correct 'file_spec' objects", {
  fs_source <- file_man()

  is_spec_rd <- FALSE
  is_spec_fig_binary <- FALSE
  is_spec_fig_text <- FALSE

  fs_len <- length(fs_source)

  if (fs_len == 3) {
    for (i in seq_len(fs_len)) {
      fs <- fs_source[[i]]
      if (!is_spec_rd & is_file_spec_type(
        fs_source = fs,
        path = "man/",
        pattern = "\\.Rd$|\\.rd$",
        format = "text",
        recursive = FALSE,
        ignore_case = TRUE,
        all_files = FALSE
      )
      ) {
        is_spec_rd <- TRUE
      } else if
      (!is_spec_fig_binary & is_file_spec_type(
          fs_source = fs,
          path = "man/figures/",
          pattern = "\\.jpg$|\\.jpeg$|\\.pdf$|\\.png$",
          format = "binary",
          recursive = FALSE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_spec_fig_binary <- TRUE
      } else if
      (!is_spec_fig_text & is_file_spec_type(
          fs_source = fs,
          path = "man/figures/",
          pattern = "\\.svg$",
          format = "text",
          recursive = FALSE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_spec_fig_text <- TRUE
      }
    }
  }

  expect_equal(is_spec_rd, TRUE)
  expect_equal(is_spec_fig_binary, TRUE)
  expect_equal(is_spec_fig_text, TRUE)
})

test_that("file_src() creates the correct 'file_spec' object", {
  is_spec_src_make <- is_file_spec_type(
    fs_source = file_src()[[1]],
    path = "src/",
    pattern = "^Makevars$|^Makevars\\.win$|^Makevars\\.ucrt$|^Makefile$|^Makefile\\.win$|^Makefile\\.ucrt$|^CMakeLists\\.txt$",
    format = "text",
    recursive = TRUE,
    ignore_case = FALSE,
    all_files = FALSE
  )

  is_spec_src_src <- is_file_spec_type(
    fs_source = file_src()[[2]],
    path = "src/",
    pattern = "\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.ipp$|\\.cxx$|\\.hpp$|\\.hxx$|\\.hh$|\\.cu$|\\.cuh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.ucrt$|\\.in$|\\.ac$|\\.mk$|\\.guess$|\\.def$",
    format = "text",
    recursive = TRUE,
    ignore_case = TRUE,
    all_files = FALSE
  )

  expect_equal(is_spec_src_make, TRUE)
  expect_equal(is_spec_src_src, TRUE)
})

test_that("file_data() creates the correct 'file_spec' object", {
  is_data <- is_file_spec_type(
    fs_source = file_data(),
    path = "data/",
    pattern = "\\.rda$|\\.RData$",
    format = "binary",
    recursive = FALSE,
    ignore_case = TRUE,
    all_files = FALSE
  )

  expect_equal(is_data, TRUE)
})

test_that("file_vignettes() creates the correct 'file_spec' objects", {
  fs_source <- file_vignettes()
  is_spec_text <- FALSE
  is_spec_binary <- FALSE

  fs_len <- length(fs_source)

  if (fs_len == 2) {
    for (i in seq_len(fs_len)) {
      fs <- fs_source[[i]]
      if (!is_spec_text & is_file_spec_type(
        fs_source = fs,
        path = "vignettes/",
        pattern = "\\.R$|\\.r$|\\.s$|\\.q$|\\.Rd$|\\.rd$|\\.svg$|\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.ipp$|\\.cxx$|\\.hpp$|\\.hxx$|\\.hh$|\\.cu$|\\.cuh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.ucrt$|\\.in$|\\.ac$|\\.mk$|\\.guess$|\\.def$|\\.Rmd$|\\.qmd$|\\.orig$|\\.md$|\\.tex$|\\.csl$|\\.Rnw$|\\.Snw$|\\.Rtex$|\\.Stex$|\\.rsp$|\\.Rasciidoc$|\\.Rhtml$|\\.lyx$|\\.ltx$|\\.dtx$|\\.cls$|\\.sty$|\\.aux$|\\.bib$|\\.bibtex$|\\.bst$|\\.bbl$|\\.asis$|\\.el$|\\.Rproj$|\\.dcf$|\\.yml$|\\.yaml$|\\.toml$|\\.note$|\\.csv$|\\.tsv$|\\.txt$|\\.ps$|\\.dot$|\\.drawio$|\\.html$|\\.htm$|\\.shtml$|\\.css$|\\.scss$|\\.sass$|\\.less$|\\.js$|\\.cjs$|\\.mjs$|\\.jsx$|\\.wasm$|\\.json$|\\.ndjson$|\\.jsonl$|\\.jsonld$|\\.json5$|\\.topojson$|\\.xml$|\\.xsd$|\\.xsl$|\\.xslt$|\\.dtd$|\\.rtf$|\\.save$|\\.Rout$|\\.log$|\\.stan$|\\.bug$|\\.jags$|\\.py$|\\.ipynb$|\\.sh$|\\.java$|\\.bat$|\\.m4$|\\.cmake$|\\.sql$|\\.graphql$|\\.lua$|\\.rs$|\\.lock$|\\.jl$|\\.pl$|\\.pm$|\\.brew$|\\.scala$|\\.awk$|\\.rb$|\\.sas$|\\.m$|\\.asm$|\\.po$|\\.pot$|\\.geojson$|\\.kml$|\\.prj$|\\.cpg$|\\.qpj$|\\.fasta$|\\.fas$|\\.fa$|\\.faa$|\\.fai$|\\.fastq$|\\.vcf$|\\.ped$|\\.bim$|\\.fam$|\\.gff$|\\.gff3$|\\.gtf$|\\.markdown$|\\.rst$|\\.typ$|\\.ini$|\\.conf$|\\.slurm$|\\.ris$|\\.cff$|\\.fwf$|\\.arff$|\\.graphml$|\\.gexf$",
        format = "text",
        recursive = TRUE,
        ignore_case = TRUE,
        all_files = TRUE
      )
      ) {
        is_spec_text <- TRUE
      } else if
      (!is_spec_binary & is_file_spec_type(
          fs_source = fs,
          path = "vignettes/",
          pattern = "\\.rda$|\\.rds$|\\.RData$|\\.jpg$|\\.jpeg$|\\.pdf$|\\.png$|\\.bmp$|\\.gif$|\\.tif$|\\.tiff$|\\.emf$|\\.svgz$|\\.ico$|\\.webp$|\\.eps$|\\.ppm$|\\.pgm$|\\.pbm$|\\.pnm$|\\.xcf$|\\.psd$|\\.graffle$|\\.o$|\\.so$|\\.rdb$|\\.rdx$|\\.woff2$|\\.woff$|\\.otf$|\\.ttf$|\\.eot$|\\.docx$|\\.xlsx$|\\.pptx$|\\.xltx$|\\.potx$|\\.doc$|\\.xls$|\\.ppt$|\\.xlsb$|\\.xlsm$|\\.odt$|\\.ods$|\\.odp$|\\.odg$|\\.odc$|\\.odf$|\\.odi$|\\.odm$|\\.odb$|\\.sas7bdat$|\\.sas7bcat$|\\.xpt$|\\.xpt5$|\\.xpt8$|\\.zip$|\\.tar$|\\.gz$|\\.tgz$|\\.bz2$|\\.7z$|\\.xz$|\\.sqlite$|\\.sqlite3$|\\.dbf$|\\.accdb$|\\.mdb$|\\.pyc$|\\.jar$|\\.mo$|\\.shx$|\\.shp$|\\.laz$|\\.sbx$|\\.sbn$|\\.nc$|\\.gpkg$|\\.bam$|\\.bai$|\\.wav$|\\.mp3$|\\.mid$|\\.ogg$|\\.au$|\\.m4a$|\\.mp4$|\\.avi$|\\.mov$|\\.mkv$|\\.webm$|\\.bin$|\\.epub$|\\.hdf5$|\\.h5$|\\.parquet$|\\.feather$|\\.msgpack$|\\.pickle$|\\.pkl$|\\.npy$|\\.npz$|\\.safetensors$|\\.pt$|\\.pth$|\\.keras$|\\.tfrecord$|\\.pb$|\\.ckpt$|\\.onnx$",
          format = "binary",
          recursive = TRUE,
          ignore_case = TRUE,
          all_files = TRUE
        )
      ) {
        is_spec_binary <- TRUE
      }
    }
  }

  expect_equal(is_spec_text, TRUE)
  expect_equal(is_spec_binary, TRUE)
})

test_that("file_default() creates the correct 'file_spec' objects", {
  fs_source <- file_default()
  # linearize the file_spec list
  fs_ls <- fs_unlist(fs_source)
  is_root_core <- FALSE
  is_spec_code <- FALSE
  is_spec_data <- FALSE
  is_spec_rd <- FALSE
  is_spec_fig_binary <- FALSE
  is_spec_fig_text <- FALSE
  is_spec_src_make <- FALSE
  is_spec_src_src <- FALSE
  is_spec_text <- FALSE
  is_spec_binary <- FALSE
  is_data <- FALSE

  fs_len <- length(fs_ls)

  if (fs_len == 11) {
    for (i in seq_len(fs_len)) {
      fs <- fs_ls[[i]]
      if (!is_root_core & is_file_spec_type(
        fs_source = fs,
        path = "",
        pattern = "^DESCRIPTION$|^NAMESPACE$|^README$|^README\\.Rmd$|^README\\.md$|^NEWS$|^NEWS\\.md$|^LICENSE$|^LICENCE$|^LICENSE\\.note$|^LICENCE\\.note$|\\.Rbuildignore$|\\.Rinstignore$|^configure$|^configure\\.win$|^configure\\.ucrt$|^configure\\.ac$|^configure\\.in$|^cleanup$|^cleanup\\.win$|^cleanup\\.ucrt$",
        format = "text",
        recursive = FALSE,
        ignore_case = FALSE,
        all_files = TRUE
      )
      ) {
        is_root_core <- TRUE
      } else if (!is_spec_code & is_file_spec_type(
        fs_source = fs,
        path = "R/",
        pattern = "\\.R$|\\.r$|\\.s$|\\.q$",
        format = "text",
        recursive = FALSE,
        ignore_case = TRUE,
        all_files = FALSE
      )
      ) {
        is_spec_code <- TRUE
      } else if
      (!is_spec_data & is_file_spec_type(
          fs_source = fs,
          path = "R/",
          pattern = "^sysdata\\.rda$",
          format = "binary",
          recursive = FALSE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_spec_data <- TRUE
      } else if (!is_spec_rd & is_file_spec_type(
        fs_source = fs,
        path = "man/",
        pattern = "\\.Rd$|\\.rd$",
        format = "text",
        recursive = FALSE,
        ignore_case = TRUE,
        all_files = FALSE
      )
      ) {
        is_spec_rd <- TRUE
      } else if
      (!is_spec_fig_binary & is_file_spec_type(
          fs_source = fs,
          path = "man/figures/",
          pattern = "\\.jpg$|\\.jpeg$|\\.pdf$|\\.png$",
          format = "binary",
          recursive = FALSE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_spec_fig_binary <- TRUE
      } else if
      (!is_spec_fig_text & is_file_spec_type(
          fs_source = fs,
          path = "man/figures/",
          pattern = "\\.svg$",
          format = "text",
          recursive = FALSE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_spec_fig_text <- TRUE
      } else if
      (!is_spec_src_make & is_file_spec_type(
          fs_source = fs,
          path = "src/",
          pattern = "^Makevars$|^Makevars\\.win$|^Makevars\\.ucrt$|^Makefile$|^Makefile\\.win$|^Makefile\\.ucrt$|^CMakeLists\\.txt$",
          format = "text",
          recursive = TRUE,
          ignore_case = FALSE,
          all_files = FALSE
        )
      ) {
        is_spec_src_make <- TRUE
      } else if
      (!is_spec_src_src & is_file_spec_type(
          fs_source = fs,
          path = "src/",
          pattern = "\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.ipp$|\\.cxx$|\\.hpp$|\\.hxx$|\\.hh$|\\.cu$|\\.cuh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.ucrt$|\\.in$|\\.ac$|\\.mk$|\\.guess$|\\.def$",
          format = "text",
          recursive = TRUE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_spec_src_src <- TRUE
      } else if (!is_spec_text & is_file_spec_type(
        fs_source = fs,
        path = "vignettes/",
        pattern = "\\.R$|\\.r$|\\.s$|\\.q$|\\.Rd$|\\.rd$|\\.svg$|\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.ipp$|\\.cxx$|\\.hpp$|\\.hxx$|\\.hh$|\\.cu$|\\.cuh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.ucrt$|\\.in$|\\.ac$|\\.mk$|\\.guess$|\\.def$|\\.Rmd$|\\.qmd$|\\.orig$|\\.md$|\\.tex$|\\.csl$|\\.Rnw$|\\.Snw$|\\.Rtex$|\\.Stex$|\\.rsp$|\\.Rasciidoc$|\\.Rhtml$|\\.lyx$|\\.ltx$|\\.dtx$|\\.cls$|\\.sty$|\\.aux$|\\.bib$|\\.bibtex$|\\.bst$|\\.bbl$|\\.asis$|\\.el$|\\.Rproj$|\\.dcf$|\\.yml$|\\.yaml$|\\.toml$|\\.note$|\\.csv$|\\.tsv$|\\.txt$|\\.ps$|\\.dot$|\\.drawio$|\\.html$|\\.htm$|\\.shtml$|\\.css$|\\.scss$|\\.sass$|\\.less$|\\.js$|\\.cjs$|\\.mjs$|\\.jsx$|\\.wasm$|\\.json$|\\.ndjson$|\\.jsonl$|\\.jsonld$|\\.json5$|\\.topojson$|\\.xml$|\\.xsd$|\\.xsl$|\\.xslt$|\\.dtd$|\\.rtf$|\\.save$|\\.Rout$|\\.log$|\\.stan$|\\.bug$|\\.jags$|\\.py$|\\.ipynb$|\\.sh$|\\.java$|\\.bat$|\\.m4$|\\.cmake$|\\.sql$|\\.graphql$|\\.lua$|\\.rs$|\\.lock$|\\.jl$|\\.pl$|\\.pm$|\\.brew$|\\.scala$|\\.awk$|\\.rb$|\\.sas$|\\.m$|\\.asm$|\\.po$|\\.pot$|\\.geojson$|\\.kml$|\\.prj$|\\.cpg$|\\.qpj$|\\.fasta$|\\.fas$|\\.fa$|\\.faa$|\\.fai$|\\.fastq$|\\.vcf$|\\.ped$|\\.bim$|\\.fam$|\\.gff$|\\.gff3$|\\.gtf$|\\.markdown$|\\.rst$|\\.typ$|\\.ini$|\\.conf$|\\.slurm$|\\.ris$|\\.cff$|\\.fwf$|\\.arff$|\\.graphml$|\\.gexf$",
        format = "text",
        recursive = TRUE,
        ignore_case = TRUE,
        all_files = TRUE
      )
      ) {
        is_spec_text <- TRUE
      } else if
      (!is_spec_binary & is_file_spec_type(
          fs_source = fs,
          path = "vignettes/",
          pattern = "\\.rda$|\\.rds$|\\.RData$|\\.jpg$|\\.jpeg$|\\.pdf$|\\.png$|\\.bmp$|\\.gif$|\\.tif$|\\.tiff$|\\.emf$|\\.svgz$|\\.ico$|\\.webp$|\\.eps$|\\.ppm$|\\.pgm$|\\.pbm$|\\.pnm$|\\.xcf$|\\.psd$|\\.graffle$|\\.o$|\\.so$|\\.rdb$|\\.rdx$|\\.woff2$|\\.woff$|\\.otf$|\\.ttf$|\\.eot$|\\.docx$|\\.xlsx$|\\.pptx$|\\.xltx$|\\.potx$|\\.doc$|\\.xls$|\\.ppt$|\\.xlsb$|\\.xlsm$|\\.odt$|\\.ods$|\\.odp$|\\.odg$|\\.odc$|\\.odf$|\\.odi$|\\.odm$|\\.odb$|\\.sas7bdat$|\\.sas7bcat$|\\.xpt$|\\.xpt5$|\\.xpt8$|\\.zip$|\\.tar$|\\.gz$|\\.tgz$|\\.bz2$|\\.7z$|\\.xz$|\\.sqlite$|\\.sqlite3$|\\.dbf$|\\.accdb$|\\.mdb$|\\.pyc$|\\.jar$|\\.mo$|\\.shx$|\\.shp$|\\.laz$|\\.sbx$|\\.sbn$|\\.nc$|\\.gpkg$|\\.bam$|\\.bai$|\\.wav$|\\.mp3$|\\.mid$|\\.ogg$|\\.au$|\\.m4a$|\\.mp4$|\\.avi$|\\.mov$|\\.mkv$|\\.webm$|\\.bin$|\\.epub$|\\.hdf5$|\\.h5$|\\.parquet$|\\.feather$|\\.msgpack$|\\.pickle$|\\.pkl$|\\.npy$|\\.npz$|\\.safetensors$|\\.pt$|\\.pth$|\\.keras$|\\.tfrecord$|\\.pb$|\\.ckpt$|\\.onnx$",
          format = "binary",
          recursive = TRUE,
          ignore_case = TRUE,
          all_files = TRUE
        )
      ) {
        is_spec_binary <- TRUE
      } else if
      (!is_data & is_file_spec_type(
          fs_source = fs,
          path = "data/",
          pattern = "\\.rda$|\\.RData$",
          format = "binary",
          recursive = FALSE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_data <- TRUE
      }
    }
  }

  expect_equal(is_root_core, TRUE)
  expect_equal(is_spec_code, TRUE)
  expect_equal(is_spec_data, TRUE)
  expect_equal(is_spec_rd, TRUE)
  expect_equal(is_spec_fig_binary, TRUE)
  expect_equal(is_spec_fig_text, TRUE)
  expect_equal(is_spec_src_make, TRUE)
  expect_equal(is_spec_src_src, TRUE)
  expect_equal(is_spec_text, TRUE)
  expect_equal(is_spec_binary, TRUE)
  expect_equal(is_data, TRUE)
})


test_that("file_ectd() creates the correct 'file_spec' objects", {
  fs_source <- file_ectd()
  # linearize the file_spec list
  fs_ls <- fs_unlist(fs_source)
  is_root_core <- FALSE
  is_spec_code <- FALSE
  is_spec_data <- FALSE
  is_spec_rd <- FALSE
  is_spec_fig_binary <- FALSE
  is_spec_fig_text <- FALSE
  is_spec_src_make <- FALSE
  is_spec_src_src <- FALSE
  is_data <- FALSE

  fs_len <- length(fs_ls)

  if (fs_len == 9) {
    for (i in seq_len(fs_len)) {
      fs <- fs_ls[[i]]
      if (!is_root_core & is_file_spec_type(
        fs_source = fs,
        path = "",
        pattern = "^DESCRIPTION$|^NAMESPACE$|^README$|^README\\.Rmd$|^README\\.md$|^NEWS$|^NEWS\\.md$|^LICENSE$|^LICENCE$|^LICENSE\\.note$|^LICENCE\\.note$|\\.Rbuildignore$|\\.Rinstignore$|^configure$|^configure\\.win$|^configure\\.ucrt$|^configure\\.ac$|^configure\\.in$|^cleanup$|^cleanup\\.win$|^cleanup\\.ucrt$",
        format = "text",
        recursive = FALSE,
        ignore_case = FALSE,
        all_files = TRUE
      )
      ) {
        is_root_core <- TRUE
      } else if (!is_spec_code & is_file_spec_type(
        fs_source = fs,
        path = "R/",
        pattern = "\\.R$|\\.r$|\\.s$|\\.q$",
        format = "text",
        recursive = FALSE,
        ignore_case = TRUE,
        all_files = FALSE
      )
      ) {
        is_spec_code <- TRUE
      } else if
      (!is_spec_data & is_file_spec_type(
          fs_source = fs,
          path = "R/",
          pattern = "^sysdata\\.rda$",
          format = "binary",
          recursive = FALSE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_spec_data <- TRUE
      } else if (!is_spec_rd & is_file_spec_type(
        fs_source = fs,
        path = "man/",
        pattern = "\\.Rd$|\\.rd$",
        format = "text",
        recursive = FALSE,
        ignore_case = TRUE,
        all_files = FALSE
      )
      ) {
        is_spec_rd <- TRUE
      } else if
      (!is_spec_fig_binary & is_file_spec_type(
          fs_source = fs,
          path = "man/figures/",
          pattern = "\\.jpg$|\\.jpeg$|\\.pdf$|\\.png$",
          format = "binary",
          recursive = FALSE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_spec_fig_binary <- TRUE
      } else if
      (!is_spec_fig_text & is_file_spec_type(
          fs_source = fs,
          path = "man/figures/",
          pattern = "\\.svg$",
          format = "text",
          recursive = FALSE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_spec_fig_text <- TRUE
      } else if
      (!is_spec_src_make & is_file_spec_type(
          fs_source = fs,
          path = "src/",
          pattern = "^Makevars$|^Makevars\\.win$|^Makevars\\.ucrt$|^Makefile$|^Makefile\\.win$|^Makefile\\.ucrt$|^CMakeLists\\.txt$",
          format = "text",
          recursive = TRUE,
          ignore_case = FALSE,
          all_files = FALSE
        )
      ) {
        is_spec_src_make <- TRUE
      } else if
      (!is_spec_src_src & is_file_spec_type(
          fs_source = fs,
          path = "src/",
          pattern = "\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.ipp$|\\.cxx$|\\.hpp$|\\.hxx$|\\.hh$|\\.cu$|\\.cuh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.ucrt$|\\.in$|\\.ac$|\\.mk$|\\.guess$|\\.def$",
          format = "text",
          recursive = TRUE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_spec_src_src <- TRUE
      } else if
      (!is_data & is_file_spec_type(
          fs_source = fs,
          path = "data/",
          pattern = "\\.rda$|\\.RData$",
          format = "binary",
          recursive = FALSE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_data <- TRUE
      }
    }
  }

  expect_equal(is_root_core, TRUE)
  expect_equal(is_spec_code, TRUE)
  expect_equal(is_spec_data, TRUE)
  expect_equal(is_spec_rd, TRUE)
  expect_equal(is_spec_fig_binary, TRUE)
  expect_equal(is_spec_fig_text, TRUE)
  expect_equal(is_spec_src_make, TRUE)
  expect_equal(is_spec_src_src, TRUE)
  expect_equal(is_data, TRUE)
})

test_that("file_auto() creates the correct 'file_spec' objects", {
  fs_source <- file_auto("inst/")
  is_spec_text <- FALSE
  is_spec_binary <- FALSE

  fs_len <- length(fs_source)

  if (fs_len == 2) {
    for (i in seq_len(fs_len)) {
      fs <- fs_source[[i]]
      if (!is_spec_text & is_file_spec_type(
        fs_source = fs,
        path = "inst/",
        pattern = "\\.R$|\\.r$|\\.s$|\\.q$|\\.Rd$|\\.rd$|\\.svg$|\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.ipp$|\\.cxx$|\\.hpp$|\\.hxx$|\\.hh$|\\.cu$|\\.cuh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.ucrt$|\\.in$|\\.ac$|\\.mk$|\\.guess$|\\.def$|\\.Rmd$|\\.qmd$|\\.orig$|\\.md$|\\.tex$|\\.csl$|\\.Rnw$|\\.Snw$|\\.Rtex$|\\.Stex$|\\.rsp$|\\.Rasciidoc$|\\.Rhtml$|\\.lyx$|\\.ltx$|\\.dtx$|\\.cls$|\\.sty$|\\.aux$|\\.bib$|\\.bibtex$|\\.bst$|\\.bbl$|\\.asis$|\\.el$|\\.Rproj$|\\.dcf$|\\.yml$|\\.yaml$|\\.toml$|\\.note$|\\.csv$|\\.tsv$|\\.txt$|\\.ps$|\\.dot$|\\.drawio$|\\.html$|\\.htm$|\\.shtml$|\\.css$|\\.scss$|\\.sass$|\\.less$|\\.js$|\\.cjs$|\\.mjs$|\\.jsx$|\\.wasm$|\\.json$|\\.ndjson$|\\.jsonl$|\\.jsonld$|\\.json5$|\\.topojson$|\\.xml$|\\.xsd$|\\.xsl$|\\.xslt$|\\.dtd$|\\.rtf$|\\.save$|\\.Rout$|\\.log$|\\.stan$|\\.bug$|\\.jags$|\\.py$|\\.ipynb$|\\.sh$|\\.java$|\\.bat$|\\.m4$|\\.cmake$|\\.sql$|\\.graphql$|\\.lua$|\\.rs$|\\.lock$|\\.jl$|\\.pl$|\\.pm$|\\.brew$|\\.scala$|\\.awk$|\\.rb$|\\.sas$|\\.m$|\\.asm$|\\.po$|\\.pot$|\\.geojson$|\\.kml$|\\.prj$|\\.cpg$|\\.qpj$|\\.fasta$|\\.fas$|\\.fa$|\\.faa$|\\.fai$|\\.fastq$|\\.vcf$|\\.ped$|\\.bim$|\\.fam$|\\.gff$|\\.gff3$|\\.gtf$|\\.markdown$|\\.rst$|\\.typ$|\\.ini$|\\.conf$|\\.slurm$|\\.ris$|\\.cff$|\\.fwf$|\\.arff$|\\.graphml$|\\.gexf$",
        format = "text",
        recursive = TRUE,
        ignore_case = TRUE,
        all_files = TRUE
      )
      ) {
        is_spec_text <- TRUE
      } else if
      (!is_spec_binary & is_file_spec_type(
          fs_source = fs,
          path = "inst/",
          pattern = "\\.rda$|\\.rds$|\\.RData$|\\.jpg$|\\.jpeg$|\\.pdf$|\\.png$|\\.bmp$|\\.gif$|\\.tif$|\\.tiff$|\\.emf$|\\.svgz$|\\.ico$|\\.webp$|\\.eps$|\\.ppm$|\\.pgm$|\\.pbm$|\\.pnm$|\\.xcf$|\\.psd$|\\.graffle$|\\.o$|\\.so$|\\.rdb$|\\.rdx$|\\.woff2$|\\.woff$|\\.otf$|\\.ttf$|\\.eot$|\\.docx$|\\.xlsx$|\\.pptx$|\\.xltx$|\\.potx$|\\.doc$|\\.xls$|\\.ppt$|\\.xlsb$|\\.xlsm$|\\.odt$|\\.ods$|\\.odp$|\\.odg$|\\.odc$|\\.odf$|\\.odi$|\\.odm$|\\.odb$|\\.sas7bdat$|\\.sas7bcat$|\\.xpt$|\\.xpt5$|\\.xpt8$|\\.zip$|\\.tar$|\\.gz$|\\.tgz$|\\.bz2$|\\.7z$|\\.xz$|\\.sqlite$|\\.sqlite3$|\\.dbf$|\\.accdb$|\\.mdb$|\\.pyc$|\\.jar$|\\.mo$|\\.shx$|\\.shp$|\\.laz$|\\.sbx$|\\.sbn$|\\.nc$|\\.gpkg$|\\.bam$|\\.bai$|\\.wav$|\\.mp3$|\\.mid$|\\.ogg$|\\.au$|\\.m4a$|\\.mp4$|\\.avi$|\\.mov$|\\.mkv$|\\.webm$|\\.bin$|\\.epub$|\\.hdf5$|\\.h5$|\\.parquet$|\\.feather$|\\.msgpack$|\\.pickle$|\\.pkl$|\\.npy$|\\.npz$|\\.safetensors$|\\.pt$|\\.pth$|\\.keras$|\\.tfrecord$|\\.pb$|\\.ckpt$|\\.onnx$",
          format = "binary",
          recursive = TRUE,
          ignore_case = TRUE,
          all_files = TRUE
        )
      ) {
        is_spec_binary <- TRUE
      }
    }
  }

  expect_equal(is_spec_text, TRUE)
  expect_equal(is_spec_binary, TRUE)
})

test_that("cat_patterns() generate the right string pattern", {
  str <- c("x", "y", "z")
  str_target <- "x|y|z"
  str_source <- cat_patterns(str)

  expect_equal(str_source, str_target)
})

test_that("ends_with() generate the right string pattern", {
  str <- c("x", "y", "z")
  str_target <- c("\\.x$", "\\.y$", "\\.z$")
  str_source <- ends_with(str)

  expect_equal(str_source, str_target)
})
