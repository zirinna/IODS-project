# creating dataset human
# Sini S.
# 17.2.2017


# setting working directory
setwd("./GitHub/IODS-project")

# reading "Human development" and "Gender inequality" data into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# structure and dimensions of human development data
str(hd)
dim(hd)

# structure and dimensions of gender inequality data
str(gii)
dim(gii)

# summaries of the data
summary(hd)
summary(gii)

# shortening the column names of the human development data
colnames(hd)
colnames(hd) <- c("HDI_rank", "country", "HDI", "life_exp", "edu_exp", "edu_mean", "GNI", "GNI_rank_minus_HDI_rank")

# shortening the column names of the gender inequality data
colnames(gii)
colnames(gii) <- c("GII_rank", "country", "GII", "mat_mortality", "ad_birthr", "parl_rep", "edu2_f", "edu2_m", "labor_f", "labor_m")

# accessing dplyr
library(dplyr)

# mutating gii, adding two variables
gii <- mutate(gii, edu2 = (edu2_f / edu2_m))
gii <- mutate(gii, labor = (labor_f / labor_m))

# checking that the column names are okay
colnames(gii)

# joining the data sets
human <- inner_join(hd, gii, by = "country")

# checking that the joined data is okay
str(human)

# saving the new dataset
write.csv(human, file = "./data/human.csv")
