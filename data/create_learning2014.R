# name: Sini S.
# date: 3.2.2017
# about: Creating dataframe learning2014

# installing dplyr library
install.packages("dplyr")

# reading data from the webpage
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# dimensions of the dataset
dim(lrn14)
# the dataset has 183 rows and 60 columns

# structure of the data
str(lrn14)
# rows in the data describe the variables, and columns the observations

# selecting questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# accessing dplyr library
library(dplyr)

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

# selecting the columns related to deep learning and creating column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# selecting the columns related to surface learning and creating column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# selecting the columns related to strategic learning and creating column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choosing columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# selecting the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# selecting rows where points is greater than zero
learning2014 <- filter(learning2014, Points > 0)

# checking the dimensions of the newly created dataset
dim(learning2014)

# checking the names of the columns
colnames(learning2014)

# changing the name of the second column to "age"
colnames(learning2014)[2] <- "age"

# changing the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# printing out the new column names of the data
colnames(learning2014)

# setting working directory
setwd("C:/Users/zirinna/Documents/GitHub/IODS-project")

# saving the dataset
write.table(learning2014, file = "./data/learning2014.txt")

# reading the data again to see it was saved correctly
lrn15 <- read.table("./data/learning2014.txt", sep=" ", header=TRUE)

# checking that the data is okay
str(lrn15)
head(lrn15)
