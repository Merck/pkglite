set.seed(42)

sysdata <- data.frame(a = rnorm(100), b = rnorm(100), c = rnorm(100))
save(sysdata, file = "inst/examples/pkg1/R/sysdata.rda")
save(sysdata, file = "inst/examples/pkg2/R/sysdata.rda")

dataset <- data.frame(x = rnorm(100), y = rnorm(100), z = rnorm(100))
save(dataset, file = "inst/examples/pkg1/data/dataset.rda")
save(dataset, file = "inst/examples/pkg2/data/dataset.rda")

write.table(dataset, file = "inst/examples/pkg1/inst/extdata/dataset.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(dataset, file = "inst/examples/pkg2/inst/extdata/dataset.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
