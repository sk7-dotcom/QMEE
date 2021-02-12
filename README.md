# All QMEE Winter 2021 Assignments

Assignment#1 Prompt:

Choose a data set that might be fun for you to explore for examples in this class (and possibly for the class project). Acquire the data (or make a plan to acquire it), and add a paragraph to the README.md file in your course repo describing it. Please give us some context for the data and describe the biological questions you would hope to answer (if you also want to translate your biological questions into statistical questions that’s fine, but you should always start by framing the biological questions; the translation from biological to statistical questions is one of the hardest parts of data analysis).

Input some piece of this data (use some public data set if your real data set is not quickly available) into R, and do a substantive calculation using the data. You should upload a text file or spreadsheet, and an R script that reads it and does the calculation. You should confirm that these work by running them from beginning to end in a clean R session (in RStudio you can “Restart R”, then “Run All” from the “Run” icon above the script window) before submitting by email.

# UNICEF: Worldwide data on Infant Mortalitiy from 1962 to 2020.

Biological question:

Considering the vast differences in climate, infectious diseases and healthcare facilities in North and South America I hypothesized that the infant mortality rate in South America would be significantly higher then in North America. I studied this here briefly looking at UNICEF data on this subject to understand whether there is a difference and how this statistic had changed since the 1950s.  

From this analysis, it would suggest the deaths per 1000 live births has fallen drastically since the 1950s across both continents. Although there was a vast disparity in infant mortality from the 1960s to around 2010, the numbers have become more even across the two continents since.

Other questions to consider:

1. Does the disparty in infant mortality extend into child mortality?
2. What are the contributing factors that have caused the more recent stabilization in the Mortality Rate? (i.e. vaccines, pre- and post- natal care etc) 

_____________

Assignment#2 Prompt:

1. Examine the structure of the data you imported
2. Examine the data for mistakes, and to make sure you understand the R classes
3. Make one or two plots that might help you see whether your data have any errors or anomalies
4. Describe what sort of investigations you might do with your data, and how you might break your project into replicable components: save      this in your repo as a file called README.md
5. Make sure you know how to use source, save and load in R: finish a task, and then close R without saving your workspace and efficiently       redo the task.

# HIV and AIDS over 20 years 

Potential questions:

1. How have the number of people living with HIV changed over 20 years? 
2. Where are the majority of HIV positive individuals located on the African continent? 
3. Has there been an increase in AIDS related deaths in the recent years? 

From my data management so far, the major steps seem to include some QC to make sure the data is not missing anything fundamental, 
a lot of data clean up, to make tibbles that are more appropriate for plotting (this seems to be challenging the first time and subsequently more repetitive and finally something I have not done much of is statistical analysis to see if the data generated is significant and meaningful. 

_____________

Assignment#3 Prompt: 

1. Construct some (i.e., more than one) ggplots using your data. (If you already made one for a previous           assignment, try making another.) 
2. Discuss:
   what you are trying to show
   some of the choices that you have made
   the basis for these choices (e.g., Cleveland hierarchy, proximity of comparisons, or other principles of        graphical communication)

For this assignment I delved once again into HIV and AIDS data from Africa to learn more about the changes in infections and deaths over time. I started with a modified plot from last week where I found that over time sub-Saharan Africa, Eastern and Southern Africa have shown the greatest decrease in new and existing HIV infections. They still have the highest infection compared to the continent, but their trend was most dramatic.

To look deeper into the specific countries that have driven this shift in Easter and Southern Africa, I looked at country level data in the second plot. Instead of having HIV data on the x and y axis, I created a new/existing HIV ratio to make the numeric aspect of the plot only exist on the y-axis for easy reading. Here is it clear that Madagascar was having a hard time in 2010 but has since gotten better in new HIV infections. Mauritius had the steepest drop till 2007 where the numbers started to tread upwards again. South Africa has also seen a steady drop in cases over time. 

To understand how this has affected AIDS related death in these countries, I looked into AIDS-related death in two age groups 0-14 and 15-25. This plot was particularly informative about backward trends based on age group. EG. in Madagascar, the number of AIDS related deaths has stays the same for 15 years, but the number of deaths in the 0-14 age group is on the rise. The situation is similar in Angola where death is on the rise in the youngest category. 

(Visual Graphic comments embedded in code)

________________________________

Assignment #4

Formulate a hypothesis about your data, and discuss how you would test it statistically.

Last weeks data analysis revealed that in the Easter and Southern part of the African 
continent Mauritius and Madagascar has the most dynamic increases and decreases in their new HIV case count. There is UNICEF data from 2009 onward that records the number of babies that inherited HIV from their mothers as well as data on children that have constantly been on anti-retrovirus therapies. 

I hypothesis that in Mauritius and Madagascar, the increase or decrease in new HIV infections can be correlated to the increase in mother-baby transmission and increase in access to anti-retrovirus therapies respectively. I will determine the extent of the correlation based on the value generated by a Pearson Correlation Coefficient that is 0.7 or greater. 

