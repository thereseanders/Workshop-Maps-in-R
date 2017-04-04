## Cleaning Per Capita Net State Domestic Product at Current Prices

rm(list = ls())

setwd("/Users/thereseanders/Documents/UNI/USC/Resources/R/Maps\ Workshop/data")

library(dplyr)
library(tidyr)
library(stringr)
library(readxl)

# Reading data
dat <- read_excel("india_pcndp.xls")

# Setting column names
names(dat) <- str_replace_all(dat[4,], "[:punct:]", "")
names(dat)

# Removing growth measures (columns 10 through 15)
sub <- dat[,1:9]

# Cleaning and subsetting the data
cleaned <- sub %>%
  filter(str_detect(Sl, "[0-9]+\\.")) %>%
  select(-Sl,
         state = StateUT,
         y0607 = `20062007`,
         y0708 = `20072008`,
         y0809 = `200809`,
         y0910 = `200910`,
         y1011 = `201011`,
         -`20042005`, -`201112`) %>%
  gather(year, ndp, y0607:y1011)

# Recoding some names to make them match the map
cleaned <- cleaned %>%
  mutate(state = replace(state, state == "A & N islands", "Andaman and Nicobar"),
         state = replace(state, state == "Jammu & Kashmir", "Jammu and Kashmir"),
         state = replace(state, state == "Delhi", "NCT of Delhi"))


# writing to file
write.csv(cleaned, "cleaned_india_pcndp.csv", row.names = F)
