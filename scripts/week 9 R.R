#Iteration
#be able to understand when and why to iterate code 
#be able to start with a single use and build up to iteration
#use for loops and map functions to iterate

head(iris)
head(mtcars)

#subsetting refesher
#square brackets for indexing, pulls out the first column in the dataframe
iris[1]
#double brackets pulls out a vector of values in the column
iris[[1]]
#this is the same as stating the double brackets
iris$Sepal.Length

#gives all values in column 1
iris[,1]
#gives specific value found in column 1 row 1
iris[1,1]
#gives the same answer as above
iris$Sepal.Length[1] 

#For loops 
#when you want to do something down rows of data 
#takes an index value and run it through your function 
#layout: use of i to specify index value (although you could use any value here)

for(i in 1:10){
  print(i)
}#for every index value in the range from 1 to 10 print that value and this gets stored in the environment. What's interesting is what is stored is the last value that went through which is 10 key difference between a function is that nothing is stored for function

for(i in 1:10){
  print(iris$Sepal.Length[i])#if we want to look at he first 10 values for sepal length in the data
}#output is those 10 values

#see if this matches up with what the head function shows
head(iris$Sepal.Length, n = 10)#it matches

#each output alternates between the two lines of codes writen
for(i in 1:10){
  print(iris$Sepal.Length[i])
  print(mtcars$mpg[i])#this can run on its own printing the last value that was run from value 10
}

#store output a vector filled with a bunch of nas that is the length of the dataframe
results <-rep(NA, nrow(mtcars))#nrow counts out how many rows are in whatever objects you feed it to and that's the number it will feed NAs to so 32

for(i in 1:nrow(mtcars)){#goes through every rown in mtcars dataset, nrows is flexible to respond if anything changes in the dataset 
  results[i] <- mtcars$wt[i]*100#for each row we want it to store a value calculated that is times by 100 for wt
}

results #this shows the value multiplied by 100
mtcars$wt #this is the regular value

#Map Family of Functions 
# map functions are useful when you want to do something across multiple columns
#two arguments: the data & the function 
#this generates a default output which is a list and a warning message on arguments that are not numeric
map(iris, mean) #function map and then dataset and then function to calculate in each column

#gives an output similar to a tibble 
map_df(iris, mean)

#look at the dataset
head(mtcars)

#create my own function that takes two different arguments create a character that puts together argument x with y values
print_mpg<- function(x,y){
  paste(x, "gets", y, "miles per gallon")#pastes two valuse together using paste to make one string
}

#map2_chr(input1, input2, function) takes two different inputs and it spits out as a character
map2_chr(rownames(mtcars), mtcars$mpg, print_mpg)#put our mpg function get a list of 32 character strings

#embed "anonymous" function which embeds in mamp function and doesn't save anywhere in your environment
map2_chr(rownames(mtcars), mtcars$mpg, function(x, y)
  paste(x, "gets", y, "miles per gallon"))# same output as function above but wihtout the use of the curly brackets

