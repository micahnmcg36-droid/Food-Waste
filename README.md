# Introduction: <br>
The goal of the overall study was to examine which factors led to someone trying food waste reduction strategies in their own life. I was tasked with cleaning the data, condensing and creating new variables, and performing correlations and regressions to get a substantive answer to the research question, all while creating visualizations and describing the stories within the data.
<br>
# Part I: Data Management
First, I joined datasets describing subjects at baseline, 3 months, and 6 months.
I made indicators for people who appeared in 2 or 3 of the surveys, so I could easily reference them later. 
<br><br>
Next, I defined several functions: “get_response_pct”, “plot_onevar”, “counts_onevar", "make_response_df”. 
All of these help me to easily plot visuals without having to write the same lines of code over and over again.
<br><br>
I then condensed variables based on people’s responses to surveys, grouping responses like “very likely” and “somewhat likely” together to account for the fact that these are subjective, and to study the distribution of general sentiment.
<br><br>
Next, some questions had several possible answers to choose from, each recorded as its own variable, so I put them together so I could compare across them (the reasons that people said were important to them in their decisions to try the suggestions). 
<br><br>
When it came to the variables describing the reason they tried, it was the opposite problem: each row could have up to 3 (comma-separated) responses, so I had to split them up first, and then look at the frequency of each one.
<br><br>
Next, some variables had “agree”, “neutral”, and “disagree” as options, so I decided to map them to the numerical variables 1, 0, and -1, respectively. 
I chose this mapping because it measures the “level of agreement”.
# Part II: Calculations, Tables, and Display
I needed to make a table describing the number and percentage of respondents who fit into each category in the baseline and each follow-up. 
<br><br>
I also had to make some decisions on buckets for the categories: while some came from the data collection process (for example, age was collected not as a number but as a range of ages, like “30-39”, so I couldn’t then go and make a “25-35” category since I did not have that precision), some had to be created based on the numbers in each group, to have a roughly equal number across buckets. 
<br><br>
Before plotting and analyzing some of the columns that had responses to prompts, I had to change up the wording so that it was comparable between similar variables (usually these were just a word or two off, or even just a period). In order to compare, for the time being I placed responses with no match into “other”, which makes other look like it is the majority. 
<br><br>
However, that is not an entirely accurate representation because some people chose a reason offered, and I made the decision to put it into "other".
At this stage, I also made a few small fixes; for instance, I changed the wording on some responses to remove commas. 
<br><br>
This is because when I try to split on commas, Python breaks one response into multiple answers. 
The comma was not essential to understanding the statement, so I removed it in these cases to analyze and plot them correctly.
<br><br>
Finally, I was curious to see if anyone had forgotten they had tried: had they said they had tried once at 3 months but said they had never tried at 6 months?
Similarly, had they said they had tried multiple times at 3 months but then 1 or 0 times at 6 months? 
<br><br>
I found that there were no people who met either of these criteria.
# III: Correlations and Regressions
## A: Correlations
I made dummies for all of my categorical variables (purely categorical, none ordinal to start). 
I was most interested in the correlations of all the variables I needed for regression specifications with my target variable (3M_ACT_TRIED_YN / 6M_ACT_TRIED_YN) and main variable of interest (VIDEO_AVG_NCT).
<br><br>
I was less interested in the entire correlation matrix featuring every column I had, so I only showed the columns for the important variables. 
<br><br>
One thing to note when interpreting these is that as VIDEO_AVG_NCT increases, the participant is generally feeling less confident in their ability to use the skills from the video, disagreeing more that they learned a new skill that they can apply, and less likely to try (self described).
## B: Regressions
The first question was, which type of regression was best to use? 
To answer that, I needed to know how to structure my dependent variable.
<br><br>
It turned out that it was relatively balanced between the “tried more than once”, “tried once”, and “never tried” groups, but if it was not, then something like binary logistic regression would have made the most sense to use.
<br><br>
This could still be a good method for future study, as it would remain balanced and one could imagine that the group who tried once is more similar to the group who tried multiple times than the group who never tried. 
<br><br>
However, it might be the case that the group who tried once only tried once because they did not like it, or it ended up being more inconvenient than they thought it would be.
<br><br>
In this case, we had three categories, and the best options were ordinal and multinomial logistic regression. 
While ordinal logistic is a special case of multinomial logistic, it requires more assumptions, most importantly, the "parallel regression" assumption.
<br><br>
This means that the relationship between the independent variables and dependent variables is the same across all the ordinal groups.
To test this, the standard is the Brant test, invented by Rollin Brant in 1990. 
<br><br>
Unfortunately, there is currently no Python implementation of this test, but there is one in R. I exported the data from Python and imported it into R, ran the Brant Test on it (see brant_tests.R), and pasted screenshots back into the main notebook file.
<br><br>
For the actual regression specifications, the first two were given to me, and they came from the theory and existing literature on food waste. 
The first model just looked at the video average score’s effect on how many times someone tried the solution. 
<br><br>
The coefficient was not significant at the 5% level, but interpreting the value, it implies that the more someone disagrees with the video questions, the less likely they are to try the recommendations once or multiple times.
See the notebook for a more precise interpretation of the output.
<br><br>
The next model I ran included controls that come from established research on the subject, including age, income, education, gender, household size under 16, and household size over 16. 
Again, here we find a non-significant coefficient on VIDEO_AVG_NCT, and on many others, too. 
<br><br>
Going forward, it might be useful to re-run this and condense or drop small categories to cut out some of the noise and find out what is actually important.
It might be helpful to treat these as ordinal variables rather than purely categorical, so we can see the effect of increasing education or increasing income, even though we have buckets for ranges and not exact numbers.
<br><br>
Finally, I took several variables that could be helpful and evaluated which ones improved the model. 
I ran the model with each and compared the AIC scores of these with the specification from model 2. 
<br><br>
This identifies which variables added enough explanatory power to the model to justify including them.
I added the top 3 to the model and examined the output. It seems like self-reported desire to reduce food waste and interest in the topic are a really strong signal for whether someone actually tries the suggestions, which is to be expected, but it is interesting how this is not  the case with similar questions asked about the video itself. 
<br><br>
However, the video coefficient is still insignificant: this could easily be a problem with model specification, and I want to try to decrease the noise in the model moving forward.
