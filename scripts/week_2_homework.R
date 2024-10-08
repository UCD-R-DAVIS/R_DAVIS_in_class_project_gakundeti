#Question 1 run code
set.seed(15) #It helps in creating the same random numbers each time a random function is called. This helps in creating repeatable data sets for analysis 
hw2 <- runif(50, 4, 50)#generates random deviates of the uniform distribution with a min and max argument
hw2 <- replace(hw2, c(4,12,22,27), NA) #It allows you to swap out unwanted values with new ones
hw2

#Question 2 modify vector and set a range
prod1 <- hw2[!is.na(hw2)] #removed all NAs from hw2
prod1[14:38] #pulls the 14th through the 38th values
prod1<-prod1[prod1 >= 14 & prod1 <= 38] #this pulls values that are within that range
prod1

#Question 3 quotient of 3 and sum of 10 per value
times3 <- prod1*3 #this takes values from prod1 and multiples each by 3 
times3
cbind(prod1, times3) #displays prod1 next to times3 to help visualize it executed the math correctly
plus10 <- times3 + 10 #this takes values from times3 and adds 10 to each
cbind(prod1, times3, plus10)

#Question 4 select every other number in your plus 10 vector
plus10[c(TRUE, FALSE)]

