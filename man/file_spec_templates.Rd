% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/templates.R
\name{file_spec_templates}
\alias{file_spec_templates}
\alias{file_root_core}
\alias{file_root_all}
\alias{file_r}
\alias{file_man}
\alias{file_src}
\alias{file_vignettes}
\alias{file_data}
\alias{file_tests}
\title{File specification templates}
\usage{
file_root_core()

file_root_all()

file_r()

file_man()

file_src()

file_vignettes()

file_data()

file_tests()
}
\value{
A file specification or a list of file specifications.
}
\description{
\itemize{
\item \code{file_root_core()} - core files under the package root
\item \code{file_root_all()} - all files under the package root
\item \code{file_r()} - files under \verb{R/}
\item \code{file_man()} - files under \verb{man/}
\item \code{file_src()} - files under \verb{src/}
\item \code{file_vignettes()} - files under \verb{vignettes/}
\item \code{file_data()} - files under \verb{data/}
\item \code{file_tests()} - files under \verb{tests/}
}
}
\section{Specification}{

\if{latex}{
  \itemize{
    \item Use \code{file_spec()} to generate and return a file specification
    or a list of file specifications that cover the common naming
    patterns of files under directories in source R packages.
  }
}
\if{html}{The contents of this section are shown in PDF user manual only.}
}

