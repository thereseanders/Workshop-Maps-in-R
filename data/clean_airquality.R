## Cleaning Air Quality Data
# Subsetting to reduce file size

rm(list = ls())

setwd("/Users/thereseanders/Documents/UNI/USC/Resources/R/Maps\ Workshop/data")

library(dplyr)

# Reading data
dat <- read.csv("daily_88101_2016.csv",
                stringsAsFactors = F)

cleaned <- filter(dat, State.Name == "California")

# Writing to file
write.csv(cleaned, "cleaned_airquality.csv", row.names = F)
