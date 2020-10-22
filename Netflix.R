install.packages("dplyr")
install.packages("tidyverse")
install.packages("janitor")
install.packages("ggplot2")
install.packages("readxl")
install.packages("ggthemes")
install.packages("stringr")
install.packages("plyr")

library(ggthemes)
library(dplyr)
library(ggplot2)
library(readxl)
library(tidyverse)
library(janitor)
library(plyr)
library(stringr)

#read file

stats <- read.csv("C:/Users/Ioana/Downloads/NetflixViewing.csv", sep = "," , header =TRUE)


#divide the titles from episodes and create a new columns "indvidualtitle" which contains the titles of the series without the episode
individualtitle <- word(stats$Title,1,sep = ":")

#THIS IS ONE OF MY FIRST ATTEMPTS, so excuse the extra complicated stepts
#bind the new vector to dataframe
stats$IndvTitle <- individualtitle

#create new dataframe with freq of title. Transfor the title in a factor and clean up the x column
newstats <- count(stats$IndvTitle)
newstats$title <- as.factor(newstats$x)
newstats$x <- NULL

#time to plot pretty stuff

#this is a messy and basic plot to show the data length
plot(x = newstats$title , y = newstats$freq)

#prettier and simple top 30 title and the frequency of watching. includes color gradient
newstats %>% 
  arrange(desc(freq)) %>%
  slice(1:30) %>%
  ggplot(., aes(x=title, y=freq, fill = freq))+
  geom_bar(stat='identity') +
  scale_color_gradient(low = "blue")+
  coord_flip() +
  geom_text(aes(label = round(freq, 1)), nudge_y= -3, color="white")


#other attempts to play with the wholw data. basic ggplot. Damn, those outliers!
newstats$title <- factor(newstats$title, levels = newstats$title[order(newstats$freq)])

ggplot(data = newstats, aes(x = title, y = freq, label = freq)) +
  geom_point()



