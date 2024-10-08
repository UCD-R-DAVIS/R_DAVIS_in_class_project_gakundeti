#Introduction to R: Arithmetic--- 
3+4
2*5

#Order of operations--- 
4+(8*3)^2
(4+8)*3^2 #parenthese changes things

#Scientific Notation--
2/100000
exp(1)
log(4)
4e3

#Power Functions and help function---
exp(1)
?exp

#log Functions
log(100)
log(100, base=10)
log(100,10)
log(10,100)#order changes things
log(base=10, x=100)#within a function so doesnt change what x was set to below

#Setting X variable to a number---
X <- 1
X
log(X)#doing a mathematical evaluation on a variable doesn't change the value of the variable
x <- 1
x <- 3
x = 2
x
x == 5 #asking R if x equals 5 but x equals 2 so false
x != 4 #asking R if x doesn't equal 4 which is true cause it equals 2

#Remove--- 
rm(X)

#Error---
log("word")#non-numeric error
log(-40)#produces a value NaNs as a warning which isn't a missing value


#Comparisons---
x > 4
x < 4
x >= 2 #is x greater than or equal to 2
X <= -1 #is x less than or equal to 2

#Assign variable--- 
x <- x+1
x
y <- x + 2
x+y
numSamples <- 50
numsamples <- 40 #R is case sensitive so you have two variables
num_Samples <- 50 
n#hit tab for a dropdown list and tab again to select

#Challenge---
elephant1_kg <- 3492
elephant2_lb <- 7757
elephant1_lb <-elephant1_kg * 2.2#convert elephant 1 weight from kg to lbs
elephant2_lb > elephant1_lb
myelephants <- c(elephant1_lb, elephant2_lb)
which(myelephants == max(myelephants))

#Project Management---
getwd()#gives file path of R project folder or your working directory. This is where your computer starts from
dir.create("./scripts")#creates a folder in your R project
#~/data/ #creates a shortcut to a file

#Vector and data types---
weight_g<- c(50,60,65,82) #concatenation function
weight_g#calls the list
animals <- c("mouse", "rat", "dog") #quotes tells R these values are characters
animals
class(animals)#tells format of variable between character and numeric
class(weight_g)
length(animals)#tells how many values are in the list 
length(weight_g)
str(animals)#structure function mentions its a character variable that ranges from three variables and gives the variables
weight_one_value <- c(50)

#Change a vector---
weight_g <- c(weight_g, 90)#add 90 at the end
weight_g
weight_g <- c(3,weight_g)#add 3 at the top
weight_g

#Challenge---
num_char <- c(1, 2, 3, "a")#chooses lowest common denominator
#vectors have to be the same class of values
num_logical <- c(1, 2, 3, TRUE)
#coerces values to be all the same, e.g. when TRUE is included
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

num_char <- c(1, 2, 3, "a")
class(num_char)#is a character list as soon as a character appears
num_logical <- c(1, 2, 3, TRUE)
class(num_logical)#is numeric and not sure why??
char_logical <- c("a", "b", "c", TRUE)
class(char_logical)#is a character and not sure why or diagram of order
tricky <- c(1, 2, 3, "4")
class(tricky)#character because of the numeric in quotes is a character
combined_logical <- c(num_logical, char_logical)#TRUE was converted to a number 1 and for character true was given quotes
# converting objects from one class into another class coercion. These conversions happen according to a hierarchy, whereby some types get preferentially coerced into other types.

# Subsetting---
animals <- c("mouse", "rat", "dog", "cat")
animals
animals[2]# out calls rat
animals [c(2,3)]#calls out rat and dog
animals[animals == "cat" | animals == "rat"] # returns both rat and cat
weight_g <- c(21, 34, 39, 54, 55)
weight_g[c(TRUE, TRUE, FALSE, FALSE, FALSE)]#only keeps the first two numbers and drops out the false values
weight_g
weight_g > 50 #identifies which numbers satisfy the inequality by true and false
weight_g[weight_g > 50] #identifies the actual values that meet the inequality
weight_g[weight_g > 50 | weight_g < 22]#pulls values that validate the inequality

#Symbols 
#And = &
animals %in% c("rat", "cat", "dog", "duck", "goat")#This adds goats to animals list
animals[animals %in% c("rat", "cat", "dog", "duck", "goat")]#not sure what this is doing
"four" > "five" #it is looking at what is alphabetically later as the greater
"four" >"one hundred"
"4">"100"
