#Introduction to R: Arithmetic 
3+4
2*5
#order of operations 
4+(8*3)^2
#Scientific Notation
2/100000
exp(1)
log(4)
#help files
?logLik
log(2,4)
log(4,2)
log(base=4,x=2)
X <- 1
X
rm(X)
#6 comparisons
mynumber <-6

mynumber==5
mynumber = 5
mynumber != 5
mynumber >4
mynumber <3
mynumber >=2
mynumber <- 7
othernumber <- -3
mynumber*othernumber
numSamples <- 50
num_samples <- 40
rm(num_samples)
log("a_word")
log_of_word <- log("a_word")
log_of_word
log_of_negative <- log(-2)
log_of_negative
#challenge 
elephant1_kg <- 3492
elephant2_lb <- 7757
elephant1_lb <-elephant1_kg * 2.2 
elephant2_lb > elephant1_lb
myelephants <- c(elephant1_lb, elephant2_lb)
which(myelephants == max(myelephants))