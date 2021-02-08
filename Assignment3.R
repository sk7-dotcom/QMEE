#Assignment  2021/02/05

#Packages Used ----
library(ggplot2)
library(dplyr)

#Data downloaded from UNICEF: https://data.unicef.org/dv_index/ ----
Total_data <- read.csv('fusion_GLOBAL_DATAFLOW_UNICEF_1.0_all.csv')
HIV_AIDS_data <- read.csv('HIV_AIDS.csv')
ES_Africa <- read.csv('ES_Africa.csv')
ES_africa <- ES_Africa[,1]

#Initial Plots ----
HIV_AIDS_data <- HIV_AIDS_data %>% mutate(Year = as.numeric(TIME_PERIOD))
ggplot(HIV_AIDS_data, aes(new_HIV, live_HIV, color = Geographic.area, size = Year)) + 
  geom_point(alpha = 0.5) + xlab('Est. no of new HIV infections under 25') +
  ylab('Est. no of people living with HIV under 25')

#Not the most effective plot(zoom for full picture), but it is clear to see that the ratio of individuals 
#living with HIV vs new cases has been steadily dropping over 15 years. To understand 
#which country in the Easter and Southern African block is driving this, I will make 
#a new table with countries and plot accordingly. 

#Country specific HIV data ----
live_HIV_ES <- Total_data %>% 
  #group_by(TIME_PERIOD)%>% 
  filter(Indicator == 'Estimated number of children (aged 0-19 years) living with HIV',
         Geographic.area %in% ES_africa, Sex == 'Total') %>% 
  select(TIME_PERIOD, OBS_VALUE, Geographic.area)

new_HIV_ES <- Total_data %>% 
  #group_by(TIME_PERIOD)%>% 
  filter(Indicator == 'Estimated number of new HIV infections (children aged 0-19 years)', 
         Geographic.area %in% ES_africa, Sex == 'Total') %>% 
  select(TIME_PERIOD, OBS_VALUE, Geographic.area)

HIV_ES <- new_HIV_ES %>%
  inner_join(live_HIV_ES, by = c('TIME_PERIOD', 'Geographic.area'), suffix = c(".new", ".live"))

HIV_ES_ratio <- HIV_ES %>%
  mutate_if(is.character, stringr::str_replace_all, pattern = '<', replacement = '') %>%
  mutate(L_N = as.numeric(OBS_VALUE.new)/as.numeric(OBS_VALUE.live))
#Final data set contains a ratio of new people diagnosed vs people living with the disease by countries in 
#Eastern and Southern Africa. The larger the ratio and larger the number of new cases. 

#HIV Plot ----

ggplot(HIV_ES_ratio, aes(as.numeric(TIME_PERIOD), L_N)) + 
  geom_smooth(alpha = 0.1) + facet_wrap(~ Geographic.area) +
  xlab('Year') + ylab('New HIV/Existing HIV Infection Ratio')

#Unlike the initial plot, here I created a ratio to see the HIV new vs live comparison 
#in one value on the y-axis where the reader only has to see whether the line is
#going up or down to observe change. Faceting by country with a comparable axis 
#made it easier to see countries where the change is minimal more clearly. 
#Was not sure how to change the number of plots per column, for example 6x3 instead of 5x4.

#Country specific AIDS data ----

death_AIDS <- Total_data %>% 
  filter(Indicator == c('Estimated rate of annual AIDS-related deaths (per 100,000 population, children aged 0-14 years)', 
                        'Estimated number of annual AIDS-related deaths (adolescents and young people aged 15-24 years)'), 
         Geographic.area %in% ES_africa, Sex == 'Total') %>%
  mutate_if(is.character, stringr::str_replace_all, pattern = '<', replacement = '') %>%
  mutate(OBS_VALUE = as.numeric(OBS_VALUE), Year = as.numeric(TIME_PERIOD)) %>%
  select(Indicator, Year, OBS_VALUE, Geographic.area)

#AIDS Plot ----

ggplot(death_AIDS, aes(Geographic.area, OBS_VALUE)) + 
  geom_point(alpha = 0.5, size = 10, aes(colour = Year)) + 
  facet_wrap(~ Indicator) +scale_y_log10() + coord_flip() + 
  theme(axis.title = element_blank())

#This plot is intended to read based on point movement. The less the circles move
#the less the number of AIDS related deaths have changed over time. The gradient 
#indicated time, so it is easy to understand whether a country is getting better 
#or worse in their capacity to control AIDS. I faceted this by indicator because I 
#noticed such a stark difference between the two age categories. 












