#Assignment 6

#Packages Used ----
library(ggplot2)
library(dplyr)
library(ggpubr)

#Data downloaded from UNICEF: https://data.unicef.org/dv_index/ ----
Total_data <- read.csv('HIV_AIDS.csv')
data <- read.csv('fusion_GLOBAL_DATAFLOW_UNICEF_1.0_all.csv')
HIV_AIDS_data <- read.csv('HIV_AIDS.csv')
ES_Africa <- read.csv('ES_Africa.csv')

Countries <- ES_Africa[,1]

#Data clean-up ----
HIV_AIDS <- HIV_AIDS_data %>% 
  filter(Geographic.area %in% Countries) %>%
  mutate(TIME_PERIOD = as.numeric(TIME_PERIOD)) %>%
  filter(TIME_PERIOD >=2005) %>%
  select(TIME_PERIOD, new_HIV, Geographic.area) %>%
  group_by(TIME_PERIOD) %>%
  summarise(new_HIV = mean(new_HIV, na.rm = TRUE)) 

M_to_C <- data %>% 
  filter(Indicator == 'Mother-to-child HIV transmission rate', 
         Geographic.area %in% Countries) %>% 
  mutate(TIME_PERIOD = as.numeric(TIME_PERIOD), OBS_VALUE = as.numeric(OBS_VALUE)) %>%
  filter(TIME_PERIOD >=2005) %>%
  select(TIME_PERIOD, OBS_VALUE, Geographic.area) %>%
  group_by(TIME_PERIOD) %>%
  summarise(M_to_C = mean(OBS_VALUE, na.rm = TRUE)) 
  
Plot_ready <- HIV_AIDS %>%
  inner_join(M_to_C, by = c('TIME_PERIOD'))

#Diagnostic Test ----
m1 <- lm(new_HIV ~ M_to_C + Geographic.area, data=Plot_ready)

#Plot
plot(m1)

#Correlation test ----

res <- cor.test(Plot_ready$M_to_C, Plot_ready$new_HIV, 
                method = "pearson")
res

ggscatter(Plot_ready, x = "M_to_C", y = "new_HIV", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Mother-to-child HIV transmission per 100", ylab = "Est. No. of new HIV cases")

                      