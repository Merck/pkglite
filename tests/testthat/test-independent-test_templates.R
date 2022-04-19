# check if the file_spec() is returning the right object
file_spec_func_valid <- function() {
  path <- "R/"
  pattern <- "\\.R$"
  format <- "text"
  recursive <- FALSE
  ignore_case <- TRUE
  all_files <- FALSE

  fs_source <- file_spec(
    path = path, pattern = pattern, format = format,
    recursive = recursive, ignore_case = ignore_case, all_files = all_files
  )

  return(
    fs_source$path == path
    & fs_source$pattern == pattern
    & fs_source$format == format
    & fs_source$recursive == recursive
    & fs_source$ignore_case == ignore_case
    & fs_source$all_files == all_files
    & class(fs_source) == "file_spec"
  )
}

# flatten the structure of a file_spec list
fs_unlist <- function(fs) {
  fs_len <- length(fs)
  ls <- list()
  ls_cnt <- 0

  if (fs_len) {
    for (i in seq_len(fs_len)) {
      x <- fs[[i]]
      if (class(x) == "file_spec") {
        ls_cnt <- ls_cnt + 1
        ls[[ls_cnt]] <- x
      }
      else if (class(x) == "list") {
        ls_tmp <- fs_unlist(x)
        for (j in seq_len(length(ls_tmp))) {
          ls_cnt <- ls_cnt + 1
          ls[[ls_cnt]] <- ls_tmp[[j]]
        }
      }
    }
  }
  ls
}

# check if a file_spec object has all of the parameters as specified
is_file_spec_type <- function(fs_source, path, pattern, format, recursive, ignore_case, all_files) {
  return(fs_source$path == path
  & fs_source$pattern == pattern
  & fs_source$format == format
  & fs_source$recursive == recursive
  & fs_source$ignore_case == ignore_case
  & fs_source$all_files == all_files
  & class(fs_source) == "file_spec")
}

testthat::test_that("file_root_core() creates the correct 'file_spec' object", {
  is_root_core <- is_file_spec_type(
    fs_source = file_root_core(),
    path = "",
    pattern = "^DESCRIPTION$|^NAMESPACE$|^README$|^README\\.Rmd$|^README\\.md$|^NEWS$|^NEWS\\.md$|^LICENSE$|^LICENCE$|^LICENSE\\.note$|^LICENCE\\.note$|\\.Rbuildignore$|\\.Rinstignore$|^configure$|^configure\\.win$|^configure\\.ac$|^configure\\.in$|^cleanup$|^cleanup\\.win$",
    format = "text",
    recursive = FALSE,
    ignore_case = FALSE,
    all_files = TRUE
  )

  testthat::expect_equal(is_root_core, TRUE)
})


testthat::test_that("file_root_all() creates the correct 'file_spec' object", {
  is_root_all <- is_file_spec_type(
    fs_source = file_root_all(),
    path = "",
    pattern = "^DESCRIPTION$|^NAMESPACE$|^README$|^NEWS$|^LICENSE$|^LICENCE$|^configure$|^cleanup$|*[.]",
    format = "text",
    recursive = FALSE,
    ignore_case = TRUE,
    all_files = TRUE
  )

  testthat::expect_equal(is_root_all, TRUE)
})


testthat::test_that("file_r() creates the correct 'file_spec' objects", {
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
      }
      else if
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

  testthat::expect_equal(is_spec_code, TRUE)
  testthat::expect_equal(is_spec_data, TRUE)
})


testthat::test_that("file_man() creates the correct 'file_spec' objects", {
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
      }
      else if
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
      }
      else if
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

  testthat::expect_equal(is_spec_rd, TRUE)
  testthat::expect_equal(is_spec_fig_binary, TRUE)
  testthat::expect_equal(is_spec_fig_text, TRUE)
})


testthat::test_that("file_src() creates the correct 'file_spec' object", {
  is_src <- is_file_spec_type(
    fs_source = file_src(),
    path = "src/",
    pattern = "\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.hpp$|\\.hxx$|\\.hh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.in$|\\.ucrt$|\\.ac$",
    format = "text",
    recursive = TRUE,
    ignore_case = TRUE,
    all_files = FALSE
  )

  testthat::expect_equal(is_src, TRUE)
})


testthat::test_that("file_data() creates the correct 'file_spec' object", {
  is_data <- is_file_spec_type(
    fs_source = file_data(),
    path = "data/",
    pattern = "\\.rda$|\\.RData$",
    format = "binary",
    recursive = FALSE,
    ignore_case = TRUE,
    all_files = FALSE
  )

  testthat::expect_equal(is_data, TRUE)
})


testthat::test_that("file_vignettes() creates the correct 'file_spec' objects", {
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
        pattern = "\\.R$|\\.r$|\\.s$|\\.q$|\\.Rd$|\\.rd$|\\.svg$|\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.hpp$|\\.hxx$|\\.hh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.in$|\\.ucrt$|\\.ac$|\\.Rmd$|\\.md$|\\.csl$|\\.Rnw$|\\.tex$|\\.ltx$|\\.rsp$|\\.cls$|\\.sty$|\\.bib$|\\.bst$|\\.asis$|\\.el$|\\.Rproj$|\\.dcf$|\\.yml$|\\.yaml$|\\.note$|\\.csv$|\\.tsv$|\\.txt$|\\.html$|\\.htm$|\\.shtml$|\\.css$|\\.js$|\\.json$|\\.xml$|\\.scss$|\\.less$|\\.rtf$|\\.save$|\\.Rout$|\\.stan$|\\.bug$|\\.jags$|\\.py$|\\.ipynb$|\\.sh$|\\.java$|\\.bat$|\\.m4$|\\.cmake$|\\.sql$|\\.lua$|\\.rs$|\\.jl$|\\.pl$|\\.pm$|\\.brew$|\\.po$|\\.pot$|\\.geojson$|\\.kml$|\\.prj$|\\.cpg$|\\.qpj$|\\.fasta$|\\.fastq$|\\.vcf$|\\.ped$|\\.bim$|\\.fam$|\\.gff$|\\.gtf$",
        format = "text",
        recursive = TRUE,
        ignore_case = TRUE,
        all_files = TRUE
      )
      ) {
        is_spec_text <- TRUE
      }
      else if
      (!is_spec_binary & is_file_spec_type(
          fs_source = fs,
          path = "vignettes/",
          pattern = "\\.rda$|\\.rds$|\\.RData$|\\.jpg$|\\.jpeg$|\\.pdf$|\\.png$|\\.bmp$|\\.gif$|\\.tif$|\\.tiff$|\\.emf$|\\.svgz$|\\.ico$|\\.webp$|\\.eps$|\\.ppm$|\\.pgm$|\\.pbm$|\\.pnm$|\\.o$|\\.so$|\\.rdb$|\\.rdx$|\\.woff2$|\\.woff$|\\.otf$|\\.ttf$|\\.eot$|\\.docx$|\\.xlsx$|\\.pptx$|\\.xltx$|\\.potx$|\\.doc$|\\.xls$|\\.ppt$|\\.odt$|\\.ods$|\\.odp$|\\.odg$|\\.odc$|\\.odf$|\\.odi$|\\.odm$|\\.odb$|\\.sas7bdat$|\\.sas7bcat$|\\.xpt$|\\.xpt5$|\\.xpt8$|\\.zip$|\\.tar$|\\.gz$|\\.tgz$|\\.bz2$|\\.7z$|\\.xz$|\\.sqlite$|\\.sqlite3$|\\.pyc$|\\.jar$|\\.mo$|\\.shx$|\\.shp$|\\.laz$|\\.sbx$|\\.sbn$|\\.nc$|\\.gpkg$|\\.bam$|\\.bai$|\\.wav$|\\.mp3$|\\.mid$|\\.ogg$|\\.au$|\\.m4a$|\\.mp4$|\\.avi$|\\.mov$|\\.mkv$|\\.webm$",
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

  testthat::expect_equal(is_spec_text, TRUE)
  testthat::expect_equal(is_spec_binary, TRUE)
})


testthat::test_that("file_default() creates the correct 'file_spec' objects", {
  fs_source <- file_default()
  # linearize the file_spec list
  fs_ls <- fs_unlist(fs_source)
  is_root_core <- FALSE
  is_spec_code <- FALSE
  is_spec_data <- FALSE
  is_spec_rd <- FALSE
  is_spec_fig_binary <- FALSE
  is_spec_fig_text <- FALSE
  is_src <- FALSE
  is_spec_text <- FALSE
  is_spec_binary <- FALSE
  is_data <- FALSE

  fs_len <- length(fs_ls)

  if (fs_len == 10) {
    for (i in seq_len(fs_len)) {
      fs <- fs_ls[[i]]
      if (!is_root_core & is_file_spec_type(
        fs_source = fs,
        path = "",
        pattern = "^DESCRIPTION$|^NAMESPACE$|^README$|^README\\.Rmd$|^README\\.md$|^NEWS$|^NEWS\\.md$|^LICENSE$|^LICENCE$|^LICENSE\\.note$|^LICENCE\\.note$|\\.Rbuildignore$|\\.Rinstignore$|^configure$|^configure\\.win$|^configure\\.ac$|^configure\\.in$|^cleanup$|^cleanup\\.win$",
        format = "text",
        recursive = FALSE,
        ignore_case = FALSE,
        all_files = TRUE
      )
      ) {
        is_root_core <- TRUE
      }
      else if (!is_spec_code & is_file_spec_type(
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
      }
      else if
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
      else if (!is_spec_rd & is_file_spec_type(
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
      }
      else if
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
      }
      else if
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
      else if
      (!is_src & is_file_spec_type(
          fs_source = fs,
          path = "src/",
          pattern = "\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.hpp$|\\.hxx$|\\.hh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.in$|\\.ucrt$|\\.ac$",
          format = "text",
          recursive = TRUE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_src <- TRUE
      }

      else if (!is_spec_text & is_file_spec_type(
        fs_source = fs,
        path = "vignettes/",
        pattern = "\\.R$|\\.r$|\\.s$|\\.q$|\\.Rd$|\\.rd$|\\.svg$|\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.hpp$|\\.hxx$|\\.hh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.in$|\\.ucrt$|\\.ac$|\\.Rmd$|\\.md$|\\.csl$|\\.Rnw$|\\.tex$|\\.ltx$|\\.rsp$|\\.cls$|\\.sty$|\\.bib$|\\.bst$|\\.asis$|\\.el$|\\.Rproj$|\\.dcf$|\\.yml$|\\.yaml$|\\.note$|\\.csv$|\\.tsv$|\\.txt$|\\.html$|\\.htm$|\\.shtml$|\\.css$|\\.js$|\\.json$|\\.xml$|\\.scss$|\\.less$|\\.rtf$|\\.save$|\\.Rout$|\\.stan$|\\.bug$|\\.jags$|\\.py$|\\.ipynb$|\\.sh$|\\.java$|\\.bat$|\\.m4$|\\.cmake$|\\.sql$|\\.lua$|\\.rs$|\\.jl$|\\.pl$|\\.pm$|\\.brew$|\\.po$|\\.pot$|\\.geojson$|\\.kml$|\\.prj$|\\.cpg$|\\.qpj$|\\.fasta$|\\.fastq$|\\.vcf$|\\.ped$|\\.bim$|\\.fam$|\\.gff$|\\.gtf$",
        format = "text",
        recursive = TRUE,
        ignore_case = TRUE,
        all_files = TRUE
      )
      ) {
        is_spec_text <- TRUE
      }
      else if
      (!is_spec_binary & is_file_spec_type(
          fs_source = fs,
          path = "vignettes/",
          pattern = "\\.rda$|\\.rds$|\\.RData$|\\.jpg$|\\.jpeg$|\\.pdf$|\\.png$|\\.bmp$|\\.gif$|\\.tif$|\\.tiff$|\\.emf$|\\.svgz$|\\.ico$|\\.webp$|\\.eps$|\\.ppm$|\\.pgm$|\\.pbm$|\\.pnm$|\\.o$|\\.so$|\\.rdb$|\\.rdx$|\\.woff2$|\\.woff$|\\.otf$|\\.ttf$|\\.eot$|\\.docx$|\\.xlsx$|\\.pptx$|\\.xltx$|\\.potx$|\\.doc$|\\.xls$|\\.ppt$|\\.odt$|\\.ods$|\\.odp$|\\.odg$|\\.odc$|\\.odf$|\\.odi$|\\.odm$|\\.odb$|\\.sas7bdat$|\\.sas7bcat$|\\.xpt$|\\.xpt5$|\\.xpt8$|\\.zip$|\\.tar$|\\.gz$|\\.tgz$|\\.bz2$|\\.7z$|\\.xz$|\\.sqlite$|\\.sqlite3$|\\.pyc$|\\.jar$|\\.mo$|\\.shx$|\\.shp$|\\.laz$|\\.sbx$|\\.sbn$|\\.nc$|\\.gpkg$|\\.bam$|\\.bai$|\\.wav$|\\.mp3$|\\.mid$|\\.ogg$|\\.au$|\\.m4a$|\\.mp4$|\\.avi$|\\.mov$|\\.mkv$|\\.webm$",
          format = "binary",
          recursive = TRUE,
          ignore_case = TRUE,
          all_files = TRUE
        )
      ) {
        is_spec_binary <- TRUE
      }
      else if
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


  testthat::expect_equal(is_root_core, TRUE)
  testthat::expect_equal(is_spec_code, TRUE)
  testthat::expect_equal(is_spec_data, TRUE)
  testthat::expect_equal(is_spec_rd, TRUE)
  testthat::expect_equal(is_spec_fig_binary, TRUE)
  testthat::expect_equal(is_spec_fig_text, TRUE)
  testthat::expect_equal(is_src, TRUE)
  testthat::expect_equal(is_spec_text, TRUE)
  testthat::expect_equal(is_spec_binary, TRUE)
  testthat::expect_equal(is_data, TRUE)
})


testthat::test_that("file_ectd() creates the correct 'file_spec' objects", {
  fs_source <- file_ectd()
  # linearize the file_spec list
  fs_ls <- fs_unlist(fs_source)
  is_root_core <- FALSE
  is_spec_code <- FALSE
  is_spec_data <- FALSE
  is_spec_rd <- FALSE
  is_spec_fig_binary <- FALSE
  is_spec_fig_text <- FALSE
  is_src <- FALSE
  is_data <- FALSE

  fs_len <- length(fs_ls)

  if (fs_len == 8) {
    for (i in seq_len(fs_len)) {
      fs <- fs_ls[[i]]
      if (!is_root_core & is_file_spec_type(
        fs_source = fs,
        path = "",
        pattern = "^DESCRIPTION$|^NAMESPACE$|^README$|^README\\.Rmd$|^README\\.md$|^NEWS$|^NEWS\\.md$|^LICENSE$|^LICENCE$|^LICENSE\\.note$|^LICENCE\\.note$|\\.Rbuildignore$|\\.Rinstignore$|^configure$|^configure\\.win$|^configure\\.ac$|^configure\\.in$|^cleanup$|^cleanup\\.win$",
        format = "text",
        recursive = FALSE,
        ignore_case = FALSE,
        all_files = TRUE
      )
      ) {
        is_root_core <- TRUE
      }
      else if (!is_spec_code & is_file_spec_type(
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
      }
      else if
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
      else if (!is_spec_rd & is_file_spec_type(
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
      }
      else if
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
      }
      else if
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
      else if
      (!is_src & is_file_spec_type(
          fs_source = fs,
          path = "src/",
          pattern = "\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.hpp$|\\.hxx$|\\.hh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.in$|\\.ucrt$|\\.ac$",
          format = "text",
          recursive = TRUE,
          ignore_case = TRUE,
          all_files = FALSE
        )
      ) {
        is_src <- TRUE
      }
      else if
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

  testthat::expect_equal(is_root_core, TRUE)
  testthat::expect_equal(is_spec_code, TRUE)
  testthat::expect_equal(is_spec_data, TRUE)
  testthat::expect_equal(is_spec_rd, TRUE)
  testthat::expect_equal(is_spec_fig_binary, TRUE)
  testthat::expect_equal(is_spec_fig_text, TRUE)
  testthat::expect_equal(is_src, TRUE)
  testthat::expect_equal(is_data, TRUE)
})

testthat::test_that("file_auto() creates the correct 'file_spec' objects", {
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
        pattern = "\\.R$|\\.r$|\\.s$|\\.q$|\\.Rd$|\\.rd$|\\.svg$|\\.c$|\\.h$|\\.cpp$|\\.cc$|\\.hpp$|\\.hxx$|\\.hh$|\\.f$|\\.f90$|\\.f95$|\\.f03$|\\.win$|\\.in$|\\.ucrt$|\\.ac$|\\.Rmd$|\\.md$|\\.csl$|\\.Rnw$|\\.tex$|\\.ltx$|\\.rsp$|\\.cls$|\\.sty$|\\.bib$|\\.bst$|\\.asis$|\\.el$|\\.Rproj$|\\.dcf$|\\.yml$|\\.yaml$|\\.note$|\\.csv$|\\.tsv$|\\.txt$|\\.html$|\\.htm$|\\.shtml$|\\.css$|\\.js$|\\.json$|\\.xml$|\\.scss$|\\.less$|\\.rtf$|\\.save$|\\.Rout$|\\.stan$|\\.bug$|\\.jags$|\\.py$|\\.ipynb$|\\.sh$|\\.java$|\\.bat$|\\.m4$|\\.cmake$|\\.sql$|\\.lua$|\\.rs$|\\.jl$|\\.pl$|\\.pm$|\\.brew$|\\.po$|\\.pot$|\\.geojson$|\\.kml$|\\.prj$|\\.cpg$|\\.qpj$|\\.fasta$|\\.fastq$|\\.vcf$|\\.ped$|\\.bim$|\\.fam$|\\.gff$|\\.gtf$",
        format = "text",
        recursive = TRUE,
        ignore_case = TRUE,
        all_files = TRUE
      )
      ) {
        is_spec_text <- TRUE
      }
      else if
      (!is_spec_binary & is_file_spec_type(
          fs_source = fs,
          path = "inst/",
          pattern = "\\.rda$|\\.rds$|\\.RData$|\\.jpg$|\\.jpeg$|\\.pdf$|\\.png$|\\.bmp$|\\.gif$|\\.tif$|\\.tiff$|\\.emf$|\\.svgz$|\\.ico$|\\.webp$|\\.eps$|\\.ppm$|\\.pgm$|\\.pbm$|\\.pnm$|\\.o$|\\.so$|\\.rdb$|\\.rdx$|\\.woff2$|\\.woff$|\\.otf$|\\.ttf$|\\.eot$|\\.docx$|\\.xlsx$|\\.pptx$|\\.xltx$|\\.potx$|\\.doc$|\\.xls$|\\.ppt$|\\.odt$|\\.ods$|\\.odp$|\\.odg$|\\.odc$|\\.odf$|\\.odi$|\\.odm$|\\.odb$|\\.sas7bdat$|\\.sas7bcat$|\\.xpt$|\\.xpt5$|\\.xpt8$|\\.zip$|\\.tar$|\\.gz$|\\.tgz$|\\.bz2$|\\.7z$|\\.xz$|\\.sqlite$|\\.sqlite3$|\\.pyc$|\\.jar$|\\.mo$|\\.shx$|\\.shp$|\\.laz$|\\.sbx$|\\.sbn$|\\.nc$|\\.gpkg$|\\.bam$|\\.bai$|\\.wav$|\\.mp3$|\\.mid$|\\.ogg$|\\.au$|\\.m4a$|\\.mp4$|\\.avi$|\\.mov$|\\.mkv$|\\.webm$",
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

  testthat::expect_equal(is_spec_text, TRUE)
  testthat::expect_equal(is_spec_binary, TRUE)
})

testthat::test_that("cat_patterns() generate the right string pattern", {
  str <- c("x", "y", "z")
  str_target <- "x|y|z"
  str_source <- cat_patterns(str)

  testthat::expect_equal(str_source, str_target)
})

testthat::test_that("ends_with() generate the right string pattern", {
  str <- c("x", "y", "z")
  str_target <- c("\\.x$", "\\.y$", "\\.z$")
  str_source <- ends_with(str)

  testthat::expect_equal(str_source, str_target)
})
