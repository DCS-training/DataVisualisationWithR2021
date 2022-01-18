# #### Data Visualisation in R ####
# #### Class 2: Visualising Real Data ####

library(tidyverse)

# ==== Last Week ====
# Percentages
browseURL("https://sebastiansauer.github.io/percentage_plot_ggplot2_V2/") # Offers multiple ways to add percentages to a plot

# We can look at some of them using default data
data(airquality)
ggplot(airquality, aes(Temp)) + geom_bar(fill = 'indianred3')

ggplot(airquality, aes(x = Temp)) + geom_bar(aes(y = ((..count..)/sum(..count..))*100)) + labs(y = "Percentage (%)")

# We can also add the units directly to the scale
library(scales)
ggplot(airquality, aes(x = Temp)) + geom_bar(aes(y = (..count..)/sum(..count..))) + labs(y = "Percentage") + scale_y_continuous(labels = scales::percent) # Note '::' allows you to set the specific package with the function you want to use (multiple packages have a function called 'percent')

# Types of graph
browseURL("http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html")

# Scatter plot
ggplot(airquality, aes(Temp, Wind, shape = factor(Month))) + geom_point(aes(colour = factor(Month)), size = 4) # This plot is very commonly used and particularly useful for identifying correlations. 

# Histogram
ggplot(airquality, aes(Temp)) + geom_histogram(aes(fill = factor(Month)), colour = 'gray2', bins = 40) # Histograms are particularly useful for plotting distributions and detecting whether or not the plot is normally distributed. With sensible use of fill, different attributes can also be easily compared

# Density Plot
ggplot(airquality, aes(x=Temp)) + geom_density() # This is similar to a histogram, in that it can show peaks and troughs in the distribution, but with a density plot, the precise shape of each factors (in this case first_party) distribution can be more easily visualised

# Boxplots

ggplot(airquality, aes(x=factor(Month), y=Temp, fill=Month)) + geom_boxplot() # This plot allows for distributions, means, range and outliers to be very easily identified. The mean is the horizontal line across each box and the top section of each box the 75%ile, with the bottom section 25%ile. The colour or shape of outliers can be altered with outlier. Or even removed eg.

# ==== Importing Data ====
Elec <- read_csv("Data/Election_Results.csv") # Make sure you are in the appropriate working directory!
Elec$first_party <- as_factor(Elec$first_party)
Elec$first_party <- factor(Elec$first_party, levels= c('Con', 'Lab', 'SNP', 'LD', 'DUP', 'PC', 'Green', 'SF', 'SDLP', 'UUP', 'Ind', 'UKIP', 'Spk')) # This tidies the data so the first party column is in thec correct order

ggplot(Elec, aes(x=turnout, y=majority, colour=first_party)) + geom_point()

# ==== Correlations ====
library(corrplot)

Corr <- cor(Elec[sapply(Elec, is.numeric)]) # This creates a variable with the correlation of each numeric column in the Elect dataframe. Note that only numeric type objects can be correlated like this
corrplot(Corr) # Correlation plot

# Can you see any intersting correlations? can you explain any of them?

corrplot(Corr, method = 'number') # Various different methods can be used to track correlations
corrplot(Corr, method = 'color', order = 'alphabet') # The order can also be adjusted
corrplot(Corr, order = 'AOE')
corrplot(Corr, order = 'FPC')

# These orders are based on different mathematical/statistical concepts see-
browseURL('https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html#reorder-a-correlation-matrix')


corrplot(Corr, type = 'lower') # There are three main 'types' of correlation visualisations
corrplot(Corr, order =  'AOE', type = 'lower')
corrplot(Corr, order =  'AOE', type = 'upper')

corrplot.mixed(Corr, lower = 'color', upper = 'circle') # These can be combined and adjusted individually

# ==== A Short Note on Visualisation Pitfalls ====

# The main pitfall you will come across is using an unsuitable type of visualisation. The temptation after learning new visulaisation methods might be to try and make them fit with your data/research, but this is the wrong way round. If you have a specific research question, go looking for an approiate visualisation method rather than the other way round

# Additionally, focussing too much on nice visualisations can oversimplify the output and result in misleading data (even if it is nicely coloured)

browseURL("https://clauswilke.com/dataviz/introduction.html")

# As with any coding, being in the wrong directory is a very common but easily fixed problem
browseURL("https://www.sciencedirect.com/topics/mathematics/working-directory")

# ==== Research Questions ====

# Visualisations should be used to tackle research questions, and to present the data in an easily digestible format. See if you can answer some of these questions using what we have learned about visualisation, and see if you can replicate some of the example graphs.

# Which constituency had the highest turnout?

# Graph 1
party_col <- c("#0087DC", "#E4003B", "#FDF38E", "#FAA61A", "#D46A4C", "#005B54", "#528D6B", "#326760", "#2AA82C", "#48A5EE", "#DDDDDD", "#70147A", "white") # These colours should help

# Compare turnout between countries

# Is there a relationship between turnout and the number of conservative voters?

# What About Labour voters?

# Does the correlation between turnout and conservative/labour voters differ between country?

# Graph 2
+ facet_wrap(~ country_name) # Refamiliarise yourself with facet wrap if needed

# Compare turnout, majority and electorate in one visualisation


