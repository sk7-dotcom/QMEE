# Assignment 1 2021/01/21

#Packages used
library(dplyr)
library(ggplot2)

## JD: The thing to do is to provide information how to download the data, not 
## revision track somebody else's giant data file.
data <- read.csv('fusion_GLOBAL_DATAFLOW_UNICEF_1.0_all.csv')

## JD: Better to put information in tables and save code for code
#North and South american country list
north_am <- c('United States', 'Mexico', 'Canada', 'Guatamala', 'Cuba', 'Haiti', 
              'Dominican Republic', 'Honduras', 'Nicaragua', 'El Salvador', 'Costa Rica',
              'Panama', 'Jamaica', 'Trinidad and Tobago', 'Belize', 'Bahamas', 
              'Barbados', 'Saint Lucia', 'Grenada', 'Saint Vincent and the Grenadines', 
              'Antigua and Barbuda', 'Dominica', 'Saint Kitts and Nevis' )

south_am <- c('Brazil', 'Colombia', 'Argentina', 'Peru', 'Venezuela (Bolivarian Republic of)', 'Chile', 
              'Ecuador', 'Bolivia (Plurinational State of)', 'Paraguay', 'Uruguay', 'Guyana', 'Suriname', 
              'French Guiana', 'Falkland Islands (Malvinas)')

## JD: Use formatting to make code like this more readable
## Also, code shouldn't be much "wider" than 72 columns
#Cleaning data for Infant mortality across North America. Countries removed in final 
#tibble because it was no longer relevant. 
north_data <- (data
	%>% group_by(TIME_PERIOD)
	%>% filter(
		Indicator == 'Infant mortality rate', Geographic.area %in% north_am
	) %>% select(TIME_PERIOD, OBS_VALUE, Geographic.area)
)

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

## JD: What does this mean? What are you trying to see with the jitter??
## JD: What do you think you would or wouldn't see with geom_point()?
#Plotted jitter instead of point, because for each point the relative difference was too small 
#to notice across all years. 
ggplot(total, aes(as.numeric(TIME_PERIOD), mean, color = Continents)) + geom_jitter() + geom_smooth() + scale_y_log10() + 
  xlab("Year") + ylab("Infant Mortalitiy (Deaths per 1000 births)")

#Regression analysis of the North and South American infant mortality trends. 

## Use summary() to visualize your regression results
summary(lm(mean ~ as.numeric(TIME_PERIOD), data = north_sum))
summary(lm(mean ~ as.numeric(TIME_PERIOD), data = south_sum))

## Grade 2.2/3 = ~A Nice exploration.
