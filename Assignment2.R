#Assignment 2 2021/01/28 

#Packages used ----
library(dplyr)
library(ggplot2)

#Data downloaded from UNICEF: https://data.unicef.org/dv_index/ ----
data <- read.csv('fusion_GLOBAL_DATAFLOW_UNICEF_1.0_all.csv')

#Country based grouping code can be found in Country_List_Generator.R
africa_all <- read.csv('Africa.csv')
africa_all_c <- africa_all[,1]

#Data Check #1: ----
summary(data)
head(data)

data %>%
  group_by(TIME_PERIOD) %>%
  filter(grepl('HIV', Indicator), grepl('Africa', Geographic.area)) %>%
  summarize(Indicator, Geographic.area) %>%
  distinct()

data %>%
  group_by(TIME_PERIOD) %>%
  filter(grepl('AIDS', Indicator), grepl('Africa', Geographic.area)) %>%
  summarize(Indicator, Geographic.area) %>%
  distinct()

#Database has many indicators and all of them seem to be stored as 
#characters, even the numerical data. There are many observations where 
#not all the different are providing information.
#This subset will only include the HIV and AIDS data for people under 25 living in 
#one of the four African sub-regions identified from the last search. 
#I will do quality check at that level for more clarity. 


#People living with HIV under 25 ----
live_HIV_c <- data %>% 
  group_by(TIME_PERIOD)%>% 
  filter(Indicator == 'Estimated number of children (aged 0-19 years) living with HIV', 
         Geographic.area %in% africa_all_c, Sex == 'Total') %>% 
  select(TIME_PERIOD, OBS_VALUE, Geographic.area)

live_HIV_y <- data %>% 
  group_by(TIME_PERIOD)%>% 
  filter(Indicator == 'Estimated number of adolescents and young people (aged 15-24 years) living with HIV', 
         Geographic.area %in% africa_all_c, Sex == 'Total') %>% 
  select(TIME_PERIOD, OBS_VALUE, Geographic.area)

live_HIV <- rbind(live_HIV_c, live_HIV_y)

#Average across all years 
live_HIV_sum <- live_HIV %>% 
  group_by(TIME_PERIOD, Geographic.area) %>% 
  summarise(live_HIV = mean(as.numeric(OBS_VALUE))) 
  

#New infections of HIV under 25 ----
new_HIV_c <- data %>% 
  group_by(TIME_PERIOD)%>% 
  filter(Indicator == 'Estimated number of new HIV infections (children aged 0-19 years)', 
         Geographic.area %in% africa_all_c, Sex == 'Total') %>% 
  select(TIME_PERIOD, OBS_VALUE, Geographic.area)

new_HIV_y <- data %>% 
  group_by(TIME_PERIOD)%>% 
  filter(Indicator == 'Estimated number of adolescents and young people (aged 15-24 years) living with HIV', 
         Geographic.area %in% africa_all_c, Sex == 'Total') %>% 
  select(TIME_PERIOD, OBS_VALUE, Geographic.area)

new_HIV <- rbind(new_HIV_c, new_HIV_y)

#Average across all years 
new_HIV_sum <- new_HIV %>% 
  group_by(TIME_PERIOD, Geographic.area) %>% 
  summarise(new_HIV = mean(as.numeric(OBS_VALUE)))

#AIDS Deaths under 25 ----
death_AIDS_c <- data %>% 
  group_by(TIME_PERIOD)%>% 
  filter(Indicator == 'Estimated rate of annual AIDS-related deaths (per 100,000 population, children aged 0-14 years)', 
         Geographic.area %in% africa_all_c, Sex == 'Total') %>% 
  select(TIME_PERIOD, OBS_VALUE, Geographic.area)

death_AIDS_y <- data %>% 
  group_by(TIME_PERIOD)%>% 
  filter(Indicator == 'Estimated number of annual AIDS-related deaths (adolescents and young people aged 15-24 years)', 
         Geographic.area %in% africa_all_c, Sex == 'Total') %>% 
  select(TIME_PERIOD, OBS_VALUE, Geographic.area)

death_AIDS <- rbind(death_AIDS_c, death_AIDS_y)

#Average across all years 
death_AIDS_sum <- death_AIDS %>% 
  group_by(TIME_PERIOD, Geographic.area) %>% 
  summarise(death_AIDS = mean(as.numeric(OBS_VALUE)))

#Joining data for new datatable ----

HIV_AIDS_data <- new_HIV_sum %>%
  inner_join(live_HIV_sum, by = c('TIME_PERIOD', 'Geographic.area'))
  

#Data Check #2: ----

summary(HIV_AIDS_data)
#All numeric data is no longer a character, so there is some more meaning in this 
#summary.
HIV_AIDS_data %>%
  group_by(TIME_PERIOD) %>%
  summarize(count = n())
#Count across 20 years all have 4 observations as expected. 

HIV_AIDS_data %>%
  group_by(Geographic.area) %>%
  summarize(count = n())
#Count across 4 regions seems to be 20 as expected. 

death_AIDS_sum %>%
  group_by(Geographic.area) %>%
  summarise(NA_per_row = sum(is.na(death_AIDS))) %>%
  arrange(desc(NA_per_row))
#Middle Ease and North Africa does not seem to collect AIDS data. Will not 
#convert to 0 because in this it will be misleading. 

#Initial Plots ----

ggplot(HIV_AIDS_data, aes(as.numeric(TIME_PERIOD), new_HIV, color = Geographic.area)) + 
  geom_jitter() + scale_y_log10() + xlab('Years') + 
  ylab('Est. no. of new HIV infections in individuals under 25')

pdf('Africa_AIDS_2000_2019.pdf')
ggplot(death_AIDS_sum, aes(as.numeric(TIME_PERIOD), death_AIDS, color = Geographic.area)) + 
  geom_jitter() + xlab('Years') + 
  ylab('Est. no. of deaths from AIDS (per 100,000 people)')
def.off()
#Middle-East and and North Africa data is missing for AIDS deaths in the 15-25 range, 
#but this is not preventing code from running so I have ignored this warning for now. 
#May redo AIDS data with new indicator and smaller age group for next week.


