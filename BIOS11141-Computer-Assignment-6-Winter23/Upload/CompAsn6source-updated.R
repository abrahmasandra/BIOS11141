ORFTable <- function(sequence, minLength) {
    if(suppressMessages(require(Rcpp))) {
        sourceCpp("ORF1-1.cpp")
    } else {
        return("Rcpp is required")
    }
    ORFs <- findORF(sequence, minLength)
    output <- cbind("Start" = ORFs[[1]], "Stop" = ORFs[[2]], "Length" = ORFs[[2]] - ORFs[[1]] + 1, "Frame" = (ORFs[[1]] - 1) %% 3 + 1)
    return(output)
}

compStrand <- function(sequence) {
    return(rev(chartr("atcg", "tagc", sequence)))
}
print(paste0("Functions successfully loaded | ", date()))


args <- commandArgs(trailingOnly=TRUE) #taking in arguments from command line
integer <- substr(args[1],17,17)
print(paste0("chromosome:",integer))

#create name of out files
outfile_forw1 <- "./Homo_sapiens_Chr1_ORFs_forward.csv"
outfile_rev1 <- "./Homo_sapiens_Chr1_ORFs_reverse.csv"

#replace with integer number of chromosome
substr(outfile_forw1,19,19) <- integer
substr(outfile_rev1,19,19) <- integer


chromosome <- seqinr::read.fasta(args[1])[[1]]
print(paste0("Chromosome sequence successfully loaded | ", date()))

write.csv(x = ORFTable(args[1], 100), file = outfile_forw1, row.names = F)
print(paste0("Forward ORFs written out | ", date()))

write.csv(x = ORFTable(compStrand(args[1]), 100), file = outfile_rev1, row.names = F)
print(paste0("Reverse ORFs written out | ", date()))

print("Program complete")