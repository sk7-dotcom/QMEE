north_am <- c('United States', 'Mexico', 'Canada', 'Guatamala', 'Cuba', 'Haiti', 
              'Dominican Republic', 'Honduras', 'Nicaragua', 'El Salvador', 'Costa Rica',
              'Panama', 'Jamaica', 'Trinidad and Tobago', 'Belize', 'Bahamas', 
              'Barbados', 'Saint Lucia', 'Grenada', 'Saint Vincent and the Grenadines', 
              'Antigua and Barbuda', 'Dominica', 'Saint Kitts and Nevis' )

north_am <- data.frame(north_am)
write.csv(north_am, file ="north_am.csv", row.names=FALSE)

south_am <- c('Brazil', 'Colombia', 'Argentina', 'Peru', 'Venezuela (Bolivarian Republic of)', 'Chile', 
              'Ecuador', 'Bolivia (Plurinational State of)', 'Paraguay', 'Uruguay', 'Guyana', 'Suriname', 
              'French Guiana', 'Falkland Islands (Malvinas)')

south_am <- data.frame(south_am)
write.csv(south_am, file ="south_am.csv", row.names=FALSE)

Africa <- c('West and Central Africa', 'Middle East and North Africa', 'Eastern and Southern Africa')

Africa_list <- data.frame(Africa)
write.csv(Africa, file ="Africa.csv", row.names=FALSE)

#Sample
ES_Africa<- c('Angola','Botswana','Comoros','Djibouti','Eritrea','Ethiopia',
              'Kenya','Lesotho','Madagascar','Malawi','Mauritius','Mozambique',
              'Namibia', 'Reunion','Rwanda', 'Seychelles', 'Somalia', 'South Africa',
              'Sudan','Swaziland','Tanzania','Uganda','Zambia','Zimbabwe')

ES_Africa <- data.frame(ES_Africa)
write.csv(ES_Africa, file ="ES_Africa.csv", row.names=FALSE)