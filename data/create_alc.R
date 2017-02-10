# Sini S.
# 10.2.2017
# student alcohol consumption data
# (from here: https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION )

# setting working directory
setwd("./GitHub/IODS-project")

# reading the mat data
mat <- read.table("./data/student-mat.csv", sep=";", header=TRUE)
colnames(mat)

# checking the column names, structure and dimensions of the mat data
colnames(mat)
str(mat)
dim(mat)

# reading the por data
por <- read.table("./data/student-mat.csv", sep=";", header=TRUE)

# checking the column names, structure and dimensions of the por data
colnames(por)
str(por)
dim(por)

# accessing dplyr library
library(dplyr)

# selecting columns to join datasets by
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# joining the two datasets, keeping only students present in both sets
math_por <- inner_join(mat, por, by = join_by)

# creating a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))
colnames(alc)
dim(alc)

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpsing at the combined data
glimpse(alc)


# defining a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# defining a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# glimpsing the data
glimpse(alc)

# saving the dataset
write.csv(alc, file = "./data/alc.csv")

# reading the data again to see it was saved correctly
alcis <- read.csv("./data/alc.csv", sep=",", header=TRUE)

# glimpse 
glimpse(alcis)