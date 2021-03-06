New HIV Cases and the Mother to Child transmission rate in Africa
-----------------------------------------------------------------

Last day we hypothesized that new HIV infections can be correlated to
the increase in mother-baby transmission i.e. as the mother to child
transmission rate increases the number of new HIV cases in young adults
also increases. We will investigate this in the context of Eastern and
Southern African countries with the Pearson Correlation and do some
pairwise testing to see if the phenomenon is different for males vs
females.

``` r
#Packages Used ----
library(dplyr)
library(ggpubr)
library(emmeans)
```

This data has been downloaded from
<a href="https://data.unicef.org/dv_index/" class="uri">https://data.unicef.org/dv_index/</a>

``` r
data <- read.csv('fusion_GLOBAL_DATAFLOW_UNICEF_1.0_all.csv')
ES_Africa <- read.csv('ES_Africa.csv')
Countries <- ES_Africa[,1]
```

I used the tidyverse to clean up the relevant data from the total
dataset. I have created two final tibbles for the two analyses to
follow. From previous work with this dataset, we know that there are
some countries withint the larger set that have not collected data for
certain indicators and I have excluded them below.

``` r
#Data clean-up ----
HIV_AIDS_S <- data %>% 
  filter(Geographic.area %in% Countries, Indicator == 'Estimated number of new HIV infections (children aged 0-19 years)', Sex == c('Male', 'Female')) %>%
  mutate(TIME_PERIOD = as.numeric(TIME_PERIOD), OBS_VALUE = as.numeric(OBS_VALUE)) %>%
  filter(TIME_PERIOD >=2006) %>%
  group_by(TIME_PERIOD, Sex) %>%
  summarise(new_HIV = mean(OBS_VALUE, na.rm = TRUE)) 

HIV_AIDS <- data %>% 
  filter(Geographic.area %in% Countries, Indicator == 'Estimated number of new HIV infections (children aged 0-19 years)', Sex == c('Total')) %>%
  mutate(TIME_PERIOD = as.numeric(TIME_PERIOD), OBS_VALUE = as.numeric(OBS_VALUE)) %>%
  filter(TIME_PERIOD >=2006) %>%
  group_by(TIME_PERIOD) %>%
  summarise(new_HIV = mean(OBS_VALUE, na.rm = TRUE)) 

M_to_C <- data %>% 
  filter(Indicator == 'Mother-to-child HIV transmission rate', 
         Geographic.area %in% Countries) %>% 
  mutate(TIME_PERIOD = as.numeric(TIME_PERIOD), OBS_VALUE = as.numeric(OBS_VALUE)) %>%
  filter(TIME_PERIOD >=2006) %>%
  group_by(TIME_PERIOD) %>%
  summarise(M_to_C = mean(OBS_VALUE, na.rm = TRUE)) 
  
Plot_ready <- HIV_AIDS %>%
  inner_join(M_to_C, by = c('TIME_PERIOD')); head(Plot_ready)

Plot_ready_S <- HIV_AIDS_S %>%
  inner_join(M_to_C, by = c('TIME_PERIOD'))
```

##### Diagnostic Plots

To start the analysis, I have drawn four diagnostic plots to assess the
linearity, normality, homoscedasticity and any influencial outliers in
the data.

*Plot 1 (Residuals vs Fitted)*

There is a tendency towards non-linearity in this data as indicated by
the slightly bend to the line here. This actually got worse when data
was transformed, so for the moment I did not alter anything to address
this plot.

*Plot 2 (Normal QQ)*

This plot seems to suggest a relatively normal distribution, there are
some strays on the top end. To address this, I performed a Sharpiro-Wink
test and and both p-values were \> 0.05. We can reject the alternate
hypothesis that the data is not normally distributed, this does not mean
that it is therefore normally distributed but perhaps we don’t need to
worry yet about the implications on the model as much.

*Plot 3 (Scale-Location)*

The line seems to skew left since, 3 out of 4 residuals are on one side,
suggesting that they are not that evenly distributed across the dataset.

*Plot 4 (Residuals vs Leverage)*

The large majority of points seem to be outside the range of Cook’s
distance, but one point seems to be beyond Cook’s distance. After
looking into the data it is the most recent point from 2019. One could
make the argument for old data, but excluding this point to improve
these graphs is not an option.

``` r
#Diagnostic Test ----
m1 <- lm(new_HIV~ M_to_C, data=Plot_ready)

#Plot
m2 <- plot(m1, id.n=4)
```

![](Assignment6_files/figure-markdown_github/m2-1.png)![](Assignment6_files/figure-markdown_github/m2-2.png)![](Assignment6_files/figure-markdown_github/m2-3.png)![](Assignment6_files/figure-markdown_github/m2-4.png)

``` r
#shapiro.test(Plot_ready$new_HIV) # => p = 0.1532
#shapiro.test(Plot_ready$M_to_C) # => p = 0.08411
```

##### Pearson-Correlation Plots

To understand whether there is a positive correlation between
Mother-to-child transmission rates and the number of new HIV cases, I
plotted a scatter graph with pearson-correlation and the associated
p-value. From this data there seems to be a clear positive correlation
and a significant p-value associated with this data. This does suggest
that we can reject the null hypothesis.

``` r
#Correlation test ----

plot <- ggscatter(Plot_ready, x = "M_to_C", y = "new_HIV",
                  add = "reg.line", conf.int = TRUE,
                  cor.coef = TRUE, cor.method = "pearson", xlab = "Mother-to-child HIV transmission rate per 100", ylab = "Est. No. of new HIV cases"); plot
```

    ## `geom_smooth()` using formula 'y ~ x'

![](Assignment6_files/figure-markdown_github/plot-1.png)

##### Comapring Males to Females using emmeans

To study whether there is a difference in the correlation above w.r.t.
Sex, I used the emmeans package and took into account sex based
difference in the data. The lack of overlap with the confidence
intervals around the two means alone indicate a significant different
between the two groups, with the females being nearly double to that of
the male data.

``` r
#emmeans pairwise comparison on the bases of sex ----

lmboth <- lm(new_HIV~M_to_C + Sex, data=Plot_ready_S)
e1 <- emmeans(lmboth, "Sex")
p <- plot(e1); p
```

![](Assignment6_files/figure-markdown_github/p-1.png)
