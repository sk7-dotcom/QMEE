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

JD: I really like this project, but the visualizations need work.

1. Construct some (i.e., more than one) ggplots using your data. (If you already made one for a previous           assignment, try making another.) 
2. Discuss:
   what you are trying to show
   some of the choices that you have made
   the basis for these choices (e.g., Cleveland hierarchy, proximity of comparisons, or other principles of        graphical communication)

For this assignment I delved once again into HIV and AIDS data from Africa to learn more about the changes in infections and deaths over time. I started with a modified plot from last week where I found that over time sub-Saharan Africa, Eastern and Southern Africa have shown the greatest decrease in new and existing HIV infections. They still have the highest infection compared to the continent, but their trend was most dramatic.

JD: I like the idea of the time courses that you show (it is called a phase plot when you make time implicit in the xy-plane like that). I don't think size is a good choice for indicating the direction of time, though, and certainly the size range of your points is too large. It reads (and the plot looks) like you're not aware the sub-Saharan Africa is not a separate place, but instead the sum of your first and last categories. The legend is alphabetical, which should almost always be avoided, but seems particularly bad when you have this sort of structure (the third is the sum of the first and fourth). Nothing at all can be seen of North Africa: did you try plotting these data on a log scale?

To look deeper into the specific countries that have driven this shift in Easter and Southern Africa, I looked at country level data in the second plot. Instead of having HIV data on the x and y axis, I created a new/existing HIV ratio to make the numeric aspect of the plot only exist on the y-axis for easy reading. Here is it clear that Madagascar was having a hard time in 2010 but has since gotten better in new HIV infections. Mauritius had the steepest drop till 2007 where the numbers started to tread upwards again. South Africa has also seen a steady drop in cases over time. 

JD: This is a cool idea, but is hard to interpret without looking at how much HIV is in each of these countries (and how the measurements are being done). The ratio could go down if a country reassessed and found it had more old cases than it thought, for example. Madagascar has quite few cases (as we learn on the next page), and the instabilities you see may be methodological problems.

To understand how this has affected AIDS related death in these countries, I looked into AIDS-related death in two age groups 0-14 and 15-25. This plot was particularly informative about backward trends based on age group. EG. in Madagascar, the number of AIDS related deaths has stays the same for 15 years, but the number of deaths in the 0-14 age group is on the rise. The situation is similar in Angola where death is on the rise in the youngest category. 

JD: This seems like not a good way of conveying visual information, with color representing time. Countries are again in alphabetical order (but reversed visually from the previous plot). The panel titles are misleading (because most of the words can't be seen).

Grade 1.8/3

(Visual Graphic comments embedded in code)

________________________________

Assignment #4

Formulate a hypothesis about your data, and discuss how you would test it statistically.

Last weeks data analysis revealed that in the Eastern and Southern part of the African 
continent Mauritius and Madagascar has the most dynamic increases and decreases in their new HIV case count. There is UNICEF data from 2009 onward that records the number of babies that inherited HIV from their mothers as well as data on children that have constantly been on anti-retrovirus therapies. 

I hypothesize that in Mauritius and Madagascar, the increase or decrease in new HIV infections can be correlated to the increase in mother-baby transmission and increase in access to anti-retrovirus therapies respectively. I will determine the extent of the correlation based on the value generated by a Pearson Correlation Coefficient that is 0.7 or greater and its affiliated p-value. I will compare this to the confidence internal generated by the linear regression. 

**BMB: this is fine. I'm not sure what you want to do with the 0.7 cutoff in the correlation coefficient? It's bad to dichotomize if you don't have to (perhaps *slightly* better to dichotomize based on a statistic like the correlation coefficient than based on a p-value, but still: why?)  When you say you're going to look at a correlation, I'm not sure how you're going to compute it (since you've selected only two countries). Is this going to be some kind of time-series correlation (i.e. a correlation between *changes* in mother-baby transmission/HAART and *changes* in new HIV infections)? Time-series analysis can be tricky (we can talk about this).  It feels weird to select only the most extreme values out of a large set of countries; why not analyze them all? Do you think that Mauritius and Madagascar are qualitatively different from the countries with less extreme changes over time? (Examining a large data set and picking out the most extreme elements to analyze can get you in a lot of statistical (conceptual) trouble ...) How will the prevalence of HAART (anti-retroviral therapy) *in babies* affect the number of new HIV cases? Treated *adults* are less likely to transmit the disease, but babies and children aren't going to be transmitting much. There will probably be a strong correlation between HAART for kids and for adults (quality of /investment in health care, etc.), but it would be good to try to think about *mechanisms*.

Grade: 2.1/3

___________________________

Assignment # 5

-> Formulate two different hypotheses about your data, and describe how you would test them with two different permutation tests. Challenge yourself to come up with conceptually different tests, if this is reasonable for your data set.

-> Implement one or both of these tests in R. You can use permutation, or you can use a classic test if you explain clearly how it corresponds to a permutation test. Best would be to use both.

Was hard to do permutations on HIV data so I used some data from my lab. This experiment was testing what the effect of knocking out antigen presentation would have on tumor progression when mice were treated with an Oncolytic Virus vs a PBS control. The experiment had WT mice treated with Vaccinia and PBS as well as KO mice treated with Vaccinia (Vaccinia) and PBS. For the sake of this permutation, I will compare across groups on a single day or between Day 1 and Day 10. (typically when mice reach endpoint or are tumor free) 

Hypothesis 1# Since we expect the antigen-presentation deficient model to do worse in the context of cancer progression, I hypothesize that the mean tumor size is bigger on Day 10 in KO mice compared to WT mice treated with Vaccinia. 

Hypothesis 2# Since we expect WT mice treated with the Oncolytic Virus to have a smaller tumor than those that were treated with PBS, the second hypothesis is that the mean tumor size on Day 10 for PBS treatment is bigger than Day 10 for Vaccinia treatment. 

I have analyzed the two hypothesis with a classical permutation test written through a for loop because the sample size was small enough. I will systematically change the tumor size values in each hypothesis while keeping the groups constant and test the hypotheses by looking at the distributions of the difference in the mean between the two groups. I will assess the significance of the difference in the means by calculating the number of permutations of the data that were >= to the real mean and divide that by all the possibilities. The will also run a t-test for comparison. 

Results: 

Hypothesis 1: Totally opposite to our prediction, the tumors regressed faster in the KO mice than then WT mice, with the mean tumor size being larger in the WT. Biologically this points to as issue with the model either due to an unintended KO of another gene or something else.Additionally, the two tailed p-value associated with the difference in means was 0.22 when calculated by the classical permutation test and 0.25 with the t.test, both of which are bigger than 0.05. 

Hypothesis 2: The mean tumor size for the Oncolytic virus treatment group was almost half the size of the PBS treated group, however, the p-value from the permutation test was 0.23 and the t.test was 0.21. This could be a product of the small number of replicates. We cannot reject the null hypothesis, but we might be on the right tract w.r.t. the biology. 




