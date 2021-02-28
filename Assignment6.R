Assignment 6

#Packages Used ----
library(ggplot2)
library(dplyr)
library("lmPerm")
library("coin")
library("gtools")

#Data downloaded from UNICEF: https://data.unicef.org/dv_index/ ----
Total_data <- read.csv('HIV_AIDS.csv')
data <- read.csv('fusion_GLOBAL_DATAFLOW_UNICEF_1.0_all.csv')

HIV_AIDS <- HIV_AIDS_data %>% 
  filter(Geographic.area == 'Mozambique') %>%
  mutate(TIME_PERIOD = as.numeric(TIME_PERIOD)) %>%
  filter(TIME_PERIOD >=2005) %>%
  select(TIME_PERIOD, new_HIV)

M_to_C <- data %>% 
  filter(Geographic.area == 'Mozambique', 
         Indicator == 'Mother-to-child HIV transmission rate') %>% 
  mutate(TIME_PERIOD = as.numeric(TIME_PERIOD), OBS_VALUE = as.numeric(OBS_VALUE)) %>%
  filter(TIME_PERIOD >=2005) %>%
  select(TIME_PERIOD, OBS_VALUE)
  
Plot_ready <- HIV_AIDS %>%
  inner_join(M_to_C, by = c('TIME_PERIOD'))
  
ggplot(Plot_ready, aes(OBS_VALUE, new_HIV)) + 
  geom_point() + geom_smooth(method="lm", formula=y~x) + xlab('Mother-to-child HIV transmission rate') +
  ylab('Estimated number of new HIV infections (0-19 years)')

There are always trade-offs between simplicity, transparency, length of code, computational efficiency …

The simplest way to do this would be something like:
  
set.seed(101) ## for reproducibility
nsim <- 9999
res <- numeric(nsim) ## set aside space for results
for (i in 1:nsim) {
  ## standard approach: scramble response value
  perm <- sample(nrow(ants))
  bdat <- transform(ants,colonies=colonies[perm])
  ## compute & store difference in means; store the value
  res[i] <- mean(bdat$colonies[bdat$place=="field"])-
    mean(bdat$colonies[bdat$place=="forest"])
}
obs <- mean(ants$colonies[ants$place=="field"])-
  mean(ants$colonies[ants$place=="forest"])
## append the observed value to the list of results
res <- c(res,obs)
set.seed(<integer>) resets the random-number stream to a specified place. You can use any integer you like. You should always use set.seed() before running computations involving randomizations
for loops are a way to repeat computations many times: e.g. see here for an introduction
transform() is a base-R analog of tidyverse mutate()
sample() is a general-purpose tool: by default it samples a specified number of values without replacement, which means that it generates a re-ordering of the numbers, e.g. set.seed(101); sample(5) produces a vector (2,1,3,5,4). colonies[perm] above scrambles the response variable with respect to the predictors (in this case, to the “field” vs. “forest” location)
A picture of the results:
  
  hist(res,col="gray",las=1,main="")
abline(v=obs,col="red")
                                  


                      