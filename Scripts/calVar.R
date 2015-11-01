args <- commandArgs(TRUE)
r <- as.character(args[1])
x <- as.integer(args[2])
n <- as.integer(args[3])
v1 <- as.double(args[4])
v2 <- as.double(args[5])

calCoverage <- function(file,genomeLength,step,threshold1,threshold2) {
#	print(file)
#	print(print(file))
#	print(step)
#	print(threshold1)
#	print(threshold2)
  outputfile <- paste(dirname(file),"/report.txt",sep="")
  fileName <- basename(file)
  if(genomeLength>0) {
    count <- c(0)
    alldata <- read.csv(file, header=F, stringsAsFactors=FALSE, sep="\t")
    index <- step
    while(index<=genomeLength+step) {
      count<-c(count, nrow(na.omit(alldata[alldata$V4>(index-step)&alldata$V4<index,])))
      index <- index+step
    }
    count <- count[2:length(count)]
    
    avgReads <- mean(count)
    nor.count <- count/avgReads
    nor.count2 <- count/sum(count)
		var1 <- var(nor.count[nor.count!=0])
		var2 <- var(nor.count2[nor.count2!=0])
		
		print(var1)
		print(var2)
		if( (var1<=threshold1) && (var2<=threshold2)) {
			print(fileName)
			write(sprintf("%s\t%.3f\t%#.4g", fileName, var1, var2), file=outputfile, append=TRUE)
			pdf(paste(file,".pdf",sep=""),width=10,height=5)
		  x <- c(seq(0, genomeLength, by=step))
	  	plot(x, count, xlab="Position", ylab="Counts", pch=20)
	  	title(fileName)
	  	dev.off()
		}    
  } else {
    print("NA")
    write("NA", file=outputfile, append =TRUE)
  }
}
  
calCoverage(r, x, n, v1, v2)



