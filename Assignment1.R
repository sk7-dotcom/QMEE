# Assignment 1 2021/01/21

#Packages used
library(dplyr)
library(ggplot2)
data <- read.csv('fusion_GLOBAL_DATAFLOW_UNICEF_1.0_all.csv')

#North and South american country list
north_am <- c('United States', 'Mexico', 'Canada', 'Guatamala', 'Cuba', 'Haiti', 
              'Dominican Republic', 'Honduras', 'Nicaragua', 'El Salvador', 'Costa Rica',
              'Panama', 'Jamaica', 'Trinidad and Tobago', 'Belize', 'Bahamas', 
              'Barbados', 'Saint Lucia', 'Grenada', 'Saint Vincent and the Grenadines', 
              'Antigua and Barbuda', 'Dominica', 'Saint Kitts and Nevis' )

south_am <- c('Brazil', 'Colombia', 'Argentina', 'Peru', 'Venezuela (Bolivarian Republic of)', 'Chile', 
              'Ecuador', 'Bolivia (Plurinational State of)', 'Paraguay', 'Uruguay', 'Guyana', 'Suriname', 
              'French Guiana', 'Falkland Islands (Malvinas)')

#Cleaning data for Infant mortality across North America. Countries removed in final 
#tibble because it was no longer relevant. 
north_data <- data %>% group_by(TIME_PERIOD) %>% filter(Indicator == 'Infant mortality rate', 
                                                        Geographic.area %in% north_am) %>% select(TIME_PERIOD, OBS_VALUE, Geographic.area)

#Summary tibble with averages across years for comparison to South America. 
north_sum <- north_data %>% group_by(TIME_PERIOD) %>% summarise(mean = mean(as.numeric(OBS_VALUE)))


#Same as above for South America
south_data <- data %>% group_by(TIME_PERIOD) %>% filter(Indicator == 'Infant mortality rate', 
                                                        Geographic.area %in% south_am) %>% select(TIME_PERIOD, OBS_VALUE, Geographic.area)

south_sum <- south_data %>% group_by(TIME_PERIOD) %>% summarise(mean = mean(as.numeric(OBS_VALUE)))


#Creating a data frame with Continental tags for better plotting. 
Continents <- c(rep('North America', 70), rep('South America', 70))

total_data <- rbind(north_sum, south_sum)

total <- data.frame(Continents, total_data)

#Plotted jitter instead of point, because for each point the relative difference was too small 
#to notice across all years. 
ggplot(total, aes(as.numeric(TIME_PERIOD), mean, color = Continents)) + geom_jitter() + geom_smooth() + scale_y_log10() + 
  xlab("Year") + ylab("Infant Mortalitiy (Deaths per 1000 births)")

#Regression analysis of the North and South American infant mortality trends. 

lm(mean ~ as.numeric(TIME_PERIOD), data = north_sum)


lm(mean ~ as.numeric(TIME_PERIOD), data = south_sum)
