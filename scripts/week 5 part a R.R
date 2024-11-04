library(tidyselect)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)

summary(surveys$hindfoot_length)
# a lot of NAs

#psuedocode ifelse(test or condition, what to do if test true or false/not true)
#boolean test what values are greater and fales to value 29.29
surveys$hindfoot_length <29.29

#using if then else logic to ascribe big and small to categories of hindfoot_length Vs True and False
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length <29.29, yes = "small", no = "big")
head(surveys$hindfoot_cat) #shows the transformed categories 
head(surveys$hindfoot_length)#shows original table values so we can make sure that the transformation worked

# a more robust way to perform the above, we know that 29.29 is the average and that there are NAs to remove
surveys$hindfoot_length <-ifelse(surveys$hindfoot_length < mean (surveys$hindfoot_length, na.rm = TRUE), yes = "small", no = "big")
head(surveys$hindfoot_cat)

#case_when() instead of ifelse looks at if hindfootlength is greater than 29.29 the make big and if not then label small so last arguement is a catchall
surveys %>%
  mutate(hindfoot_cat = case_when( 
         hindfoot_length > 29.29 ~ "big", 
         TRUE ~ "small")) %>%
  select(hindfoot_length, hindfoot_cat) %>%
  head()#this ends up classifying NAs as small and that is not right

surveys %>%
  mutate(hindfoot_cat = case_when( 
    hindfoot_length > 29.29 ~ "big",
    is.na(hindfoot_length) ~ NA_character_, #also other types: NA_integer_
    TRUE ~ "small")) %>%
  select(hindfoot_length, hindfoot_cat) %>%
  head()

#more categories? 
surveys %>%
  mutate(hindfoot_cat = case_when( 
    hindfoot_length > 31.5 ~ "big",
    hindfoot_length > 29 ~ "medium",
    is.na(hindfoot_length) ~ NA_character_, #also other types: NA_integer_
    TRUE ~ "small")) %>%
  select(hindfoot_length, hindfoot_cat) %>%
  group_by(hindfoot_cat)%>%
  tally()