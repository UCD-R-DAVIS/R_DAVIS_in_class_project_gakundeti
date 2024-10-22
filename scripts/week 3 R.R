#Vector math
x <- 1:10 #creates a list of values from 1 thru 10
x #prints the list in the console
x + c(3) #adds three to each

y <- 100:109
y
x + y #adds the x list to the y list sequentially
cbind(x,y, x+y) #creates the lists next to eachother in the console

z<- 1:2
z
x + z
cbind(x, y, x+z)

z <- 1:3
cbind(x, z, x + z)#three is not a multiple of 10 so R will recycle until it finishes

a <- x + z
x[c(TRUE, FALSE)]
x[c(TRUE, FALSE, FALSE)] #this is longer than x but no warning and R recycles

#Missing data
NA #Missing value
NaN #not a number also seen as missing value
"NA" #R will not recognize this as a missing value it sees it as a text string


heights <- c(2, 4, 4, NA, 6)
max(heights)
sum(heights)#R cannot calculate with an NA vector 
mean(heights, na.rm = TRUE)
mean(heights, na.rm=T)#now R can calculate with the NAs removed

is.na(heights) #lets us know where the NA is using TRUE
!is.na(heights) #lets us know where the NA is by FALSE
heights[!is.na(heights)] #this removes the NA from the vector
heights[complete.cases(heights)] #does the same thing removing the NA

#Subsetting 
animals<- c('mouse', 'rat', 'dog', 'cat') #creates an animal vector
animals[2] #specifies name of animals as they appear in the vector
animals[c(2,3)] #specifies multiple animals from the vecotr based upon order appearance
animals[c(2,3,2,3,2,3)]

#Logical vector subsetting
weight <- c(14,76,81,25,46)#creates a vector 
weight[c(TRUE, TRUE, FALSE, FALSE, FALSE)]#This pulls the first two values from the vector
weight[weight>50]#only values that are greater than 50 from the vector
weight>50#indicates which values in the vector meets the logic statement with TRUE and FALSE

#Multiple Tests
weight[weight >50 | weight < 20] #pulls only the values that meet the logical expression
weight[weight >=46] #logical statement 

#Lists 
c(4,6, "dog") #all values are in same row
list(4, 6, "dog") #gives us three seperate vectors
a<- list(4,6,"dog") #its like a junk door to store things
class(a)#tells that this is a list
str(a)#gives background on the variable formats

#data frames
data.frame(letters)#data frame changes structure from list, instead of a row the letters are now in one column 
df<- data.frame(letters)
length(df) #number of columns
dim(df) #26 rows, 1 column
nrow(df) #26 rows
ncol(df)#1 column
df2 <-data.frame(letters, letters)
str(df2) #with repeated varible one is given a number to distinguish 
dim(df2) #26 rows and 2 columns
data.frame(letters, "dog") #repeats dog for each letter
data.frame(letters, 1) #repeats 1 for each letter
data.frame(letters, 1:2) #this recycle the numbers 1 and 2 per letter 
data.frame(letters, 1:3) #vector numbers are odd while list values even so error
as.data.frame(t(df))#counts the lettere

#Matrices have to be all character or all numeric
matrix(nrow=10, ncol=10) #10 columns and 10 rows with MA
matrix(1:10, nrow = 10, ncol = 10) #filling in the matrix with values of numbers across rows
matrix(1:10, nrow = 10, ncol = 10, byrow=TRUE) #this has the numbers by column
m <- matrix(1:10, nrow = 10, ncol= 10, byrow= TRUE) #[1,]row 1 and [,1]column 1
m [1, 3] #extracts one value from the matrix given row and column 
m[c(1,2), c(5,6)] #extracting more than one value

#Arrays are three dimensions x, y, and z (gives a height value)



#factors has a level value or order to them
response <- factor (c("no", "yes", "maybe", "no", "maybe", "no"))
class(response) #this is a factor
levels(response) #this gives the types of distinct responses in this factor
nlevels(response) #the number of responses avaliable 
typeof(response) #R sees it as a number to count and that each response is a level, order is alphabetical order
response <- factor(response, levels = c("yes", "maybe", "no")) #customize/reorganize the list appearance 
response

#Convert to character
as.character(response) #displays the character responses
year_fct <-factor(c(1990, 1983, 1977, 1998, 1990))
year_fct #R factor by increasing levels
as.numeric(year_fct) #This gives the numeric order so 1990 is 3rd lowest
as.numeric(as.character(year_fct)) #this gives the actual values as they appear in the factor list

#Renaming 
levels(response)
levels(response)[1] <- "YES"
response#verify that the value is in all caps for just yes
levels(response) <-c("YES", "MAYBE", "NO")
response # all values are in caps

#why a factor is different from a character? Factors differ from characters in that they are stored as integers and have numeric labels, but they are categorial type values
#why might we want to use factors and provide an example? Factors are used to work with categorical variables, variables that have a fixed and known set of possible values. Factors are used in statistical modeling; since categorical variables enter into statistical models


