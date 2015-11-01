args <- commandArgs(TRUE)
r <- as.character(args[1])
x <- as.character(args[2])
n <- as.character(args[3])

finalEvaluation <- function(pathofile,selectedList,sampleName) {
  outputfile <- paste(dirname(pathofile),"/",sampleName,"_report.csv",sep="")
  pathoscope.table <- read.table(pathofile, header=T, check.names=FALSE, skip=1, sep = "\t")
  finalList <- read.table(selectedList, header=F, sep = "\t")
  selectedSpecies <- pathoscope.table[gsub('[|][a-z0-9|_A-Z.]*[|]','',pathoscope.table$Genome) %in% finalList$V1,]
  selectedSpecies$`Final Guess`<-selectedSpecies$`Final Guess`/sum(selectedSpecies$`Final Guess`)
  selectedSpecies$Genome<-gsub('[|][a-z0-9|_A-Z.]*[|]','',selectedSpecies$Genome)
  write.csv(selectedSpecies[,1:2], file=outputfile, row.names=FALSE)
}

finalEvaluation(r, x, n)