setwd("~/UCF/UCF Fall '19/Data Visualization/R/A5")

library(GGally)
library(tidyverse)
library(ggplot2)

income <- read.csv("income_per_person_gdppercapita_ppp_inflation_adjusted.csv")
life_exp <- read.csv("life_expectancy_years.csv") 
birth_rate <- read.csv("crude_birth_rate_births_per_1000_population.csv") 
marriage <- read.csv("age_at_1st_marriage_women.csv") 
agriculture <- read.csv("agricultural_land_percent_of_land_area.csv") 

income <- filter(income, country == 'United States')
life_exp <- filter(life_exp, country == 'United States')
birth_rate <- filter(birth_rate, country == 'United States')
marriage <- filter(marriage, country == 'United States')
agriculture <- filter(agriculture, country == 'United States')

income <- t(income)
life_exp <- t(life_exp)
birth_rate <- t(birth_rate)
marriage <- t(marriage)
agriculture <- t(agriculture)

income <- rownames_to_column(data.frame(income))
life_exp <- rownames_to_column(data.frame(life_exp))
birth_rate <- rownames_to_column(data.frame(birth_rate))
marriage <- rownames_to_column(data.frame(marriage))
agriculture <- rownames_to_column(data.frame(agriculture))

colnames(income) <- c('country', 'United States')
colnames(life_exp) <- c('country', 'United States')
colnames(birth_rate) <- c('country', 'United States')
colnames(marriage) <- c('country', 'United States')
colnames(agriculture) <- c('country', 'United States')

all <- left_join(income, life_exp, by="country", suffix = c('.income', '.life_exp'))
all <- left_join(all, birth_rate, by="country", suffix = c('.all', '.birth_rate'))
all <- left_join(all, marriage, by="country", suffix = c('.all', '.marriage'))
all <- left_join(all, agriculture, by="country", suffix = c('.all', '.agriculture'))

colnames(all) <- c('Years', 'Income', 'Life.expectancy', 'Birth.rate', 'Marriage', 'Agriculture')

ggpairs(all, columns=2:6, title = "", axisLabels = "show", columnLabels = colnames(all[, 2:6]))

ggplot(all, aes(x = Income, y = Life.expectancy)) 
  + geom_point() 
  + geom_smooth(method = "loess", col = "red") 
  + ggtitle('Loess for Income and Life expectancy')

ggplot(all, aes(x = Income, y = Birth.rate)) 
  + geom_point() 
  + geom_smooth(method = "loess", col = "red") 
  + ggtitle('Loess for Income and Birth rate')

ggplot(all, aes(x = Income, y = Marriage)) 
  + geom_point() 
  + geom_smooth(method = "loess", col = "red") 
  + ggtitle('Loess for Income and Marriage')

ggplot(all, aes(x = Income, y = Agriculture)) 
  + geom_point() 
  + geom_smooth(method = "loess", col = "red") 
  + ggtitle('Loess for Income and Agriculture')



