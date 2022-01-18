# #### Data Visualisation in R ####
# #### Class 1: Basic plots and ggplot ####

library("tidyverse")
library("viridis")

# ==== Basic Data Visualisation ====
# To begin, lets load some default air quality data, and visualise the information within it
data(airquality)
str(airquality) # Basic structural information of the dataset
head(airquality, 10) # View the first 10 observations
tail(airquality, 15) # View the last 15 observations
summary(airquality) # More detailed summary of the data. This saves using individual functions for each column eg.-mean(airquality$Temp)


View(airquality) # A more user friendly view of the dataframe (you can also click on the variable in the environment)

# ==== Basic Plots ====
# A more effective way to visualise all of this data can be through graphs, or plots
# The base graph functions in R come from the default 'graphics' package
help(graphics)
library(help = "graphics")

plot(airquality$Solar.R) # Basic scatter plot of a specific variable
plot(airquality$Ozone, airquality$Wind) # Basic scatter plot showing the relationship between two variables
# With this, we can see that there is a negative correlation between Wind and Ozone values, eg., with higher Wind values we have lower Ozone values

plot(airquality) # We can also see a matrix of plots across the entire dataframe

# Base Plot has deeper customisation available, see-
browseURL("https://towardsdatascience.com/a-guide-to-data-visualisation-in-r-for-beginners-ef6d41a34174")
# However, the level of detail and customisation afforded by ggplot2 is far greater

# ==== Basic ggplot2 Syntax ====

# The main package we will be using for data visualisation is ggplot2, included in the tidyverse package
help(ggplot)

# Lets import and tidy some data and visualise it with a basic ggplot plot
ggplot(airquality, aes(Temp, Wind)) + geom_point() # While this may seem slightly more complicated than basic plot functions for a very similar result, it allows far more customisation and the syntax is actually fairly straightforward
# ggplot syntax follows the 'grammar of graphics'. See-
browseURL("https://r-unimelb.gitbook.io/rbook/putting-the-r-in-art/ggplot2-and-the-grammar-of-graphics")
browseURL("https://www.springer.com/in/book/9780387245447")
# ggplot is called, as with any function, using 'ggplot()'. The first argument is the data itself 'airquality'. The second is aesthetics 'aes()'. Aesthetics takes additional arguments, in this case, the data to plot on the x 'Temp' and y 'Wind' axes. Finally, we include a separate function for building the geometry of the plot, in this case 'geom_point()', to create a scatter/dot plot.

Basic_plot <- ggplot(airquality, aes(Temp, Wind, shape = factor(Month))) # Additional elements can be added to aesthetics, eg. shape, in this case, the Month variable as a factor
Basic_plot + geom_point(aes(colour = factor(Month)), size = airquality$Month) # Aesthetic values and size can also be added to the geometry
Basic_plot + geom_point(aes(colour = factor(Month)), size = 4) + geom_point(colour  =  "grey90", size  =  1.5) # Additional plots can overlay those that come earlier in the statement, using the same data and aesthetic

# The basic syntax is the same for any plot in ggplot
Basic_plot <- ggplot(airquality, aes(Temp)) 
Basic_plot + geom_bar(fill = 'indianred3') # A barplot. Note that only one axis is plotted, as the y (by default) is a count

Basic_plot + geom_histogram(colour = 'black', fill = 'indianred3', binwidth = 5) # Note that colour dictates the outline of the historgram bins, while fill changes the colour. binwidth and bins lets you set the width of each bin, or the number of bins. (Binwidth overrides bins)
Basic_plot + geom_histogram(colour = 'black', fill = 'indianred3', bins = 40)

# ==== Greater Customisation with ggplot2 ====
# These are fairly basic plots, but a great level of customisation is possible with ggplot2
# The theme() argument allows for deep customisation of non-data components of plots 
Basic_plot + geom_histogram(colour = 'gray2', fill = 'indianred3', bins = 40) + theme_bw() 
Basic_plot + geom_histogram(colour = 'gray2', fill = 'indianred3', bins = 40) + theme_dark()
Basic_plot + geom_histogram(colour = 'gray2', fill = 'indianred3', bins = 40) +  theme_void()

# This site contains a list of possible ready made themes, but standard themes can be much more minutely adjusted
browseURL("https://ggplot2.tidyverse.org/reference/ggtheme.html")

# ---- Multidimensional Data ----
ggplot(airquality, aes(Temp, Wind, shape = factor(Month))) + geom_point(aes(colour = factor(Month)), size = 4) # In this scatter plot, we used the 'Month' variable to change the shape and colour of the data, adding a third dimension to the plot.

Basic_plot + geom_histogram(aes(fill = factor(Month)), colour = 'gray2', bins = 40) # Note aesthetics using variable rather than preset colours require to be within the aesthetic 'aes()' argument.

# ---- Legends ----
# Legends can be customised using theme() in multiple ways, including setting position or removing it altogether
Basic_plot + geom_histogram(aes(fill = factor(Month)), colour = 'gray2', bins = 40) + theme(legend.position = "none") # Remove legend
Basic_plot + geom_histogram(aes(fill = factor(Month)), colour = 'gray2', bins = 40) + theme(legend.position = "top") # Move legend above plot
Basic_plot + geom_histogram(aes(fill = factor(Month)), colour = 'gray2', bins = 40) + theme(legend.position = "top", legend.title=element_blank()) # Remove legend title

# The formatting of the legend can also be adjusted in more detail
Basic_plot + geom_histogram(aes(fill = factor(Month)), colour = 'gray2', bins = 40) +
  theme_bw() + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black"))
# element_ allows specific non-data components of plots to be adjusted. eg. element_text for text and elecment_rect for borders and backgrounds

# ---- Labels ----
# Labels can also be easily customised in ggplot2
Histogram <- Basic_plot + geom_histogram(aes(fill = factor(Month)), colour = 'gray2', bins = 40) +
  theme_bw() + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black"))

Histogram + labs(title="Temperature by Month", x="Temp (F)", y="Number of Occurences", fill="Month")

# labs() allows labels to be customised. For more detail see:
browseURL("https://ggplot2.tidyverse.org/reference/labs.html")

# Labels can also be added onto the plot itself
Histogram + labs(title="Temperature by Month", x="Temp (F)", y="Number of Occurences", fill="Month") + annotate(geom="label", x = c(60, 95), y = c(9,9), label = c("Low End","High End"), fill="black", colour=c("steelblue1", "tomato3"))

# annotate() allows labels to be added with the x and y position on the plot and the label itself required
# rect can also be used to highlight a specific area
ggplot(airquality, aes(Temp, Wind, shape = factor(Month))) + geom_point(aes(colour = factor(Month)), size = 4) + annotate("rect", xmin=78.25, xmax=79.75, ymin=5.3, ymax=6.1, alpha=0.5) # note that alpha allows the transparency of an object to be set

# segment can add a custom line
ggplot(airquality, aes(Temp, Wind, shape = factor(Month))) + geom_point(aes(colour = factor(Month)), size = 4) + annotate(geom="segment", x=53, xend=94, y=8, yend=3, colour="plum4", lwd=1.5, alpha=0.5) # lwd sets the line width

# ---- Colours ----
# The default colours in R aren't necessarily always the best options, but this too can be customised
browseURL("https://r-charts.com/colors/") # Default colours in R

custom_colours <- c('olivedrab3', '#EEC900', 'firebrick3', 'indianred4', '#CD0000')

Histogram + scale_fill_manual(values = custom_colours)

# Pre-set colour palettes can also be used
Histogram + scale_fill_viridis(discrete = TRUE)

# For information on available colour palettes see
browseURL("https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/")

# ==== Facet Wrapping ====
# Facet wrapping can allow for more obvious comparison between specified attributes
Histogram + facet_wrap(~Day)
Histogram + facet_wrap(~Day, ncol = 4, dir = 'h')

# ==== Different Types of Plots ====

# So far we have looked mainly at scatter plots and histograms. There are many more than this, we can look at some of the main other options now, but for greater detail for many available plots see:
browseURL("http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html")

# Scatter plot
ggplot(airquality, aes(Temp, Wind, shape = factor(Month))) + geom_point(aes(colour = factor(Month)), size = 4) # This plot is very commonly used and particularly useful for identifying correlations. 

# Histogram
Histogram # Histograms are particularly useful for plotting distributions and detecting whether or not the plot is normally distributed. With sensible use of fill, different attributes can also be easily compared 

# Density Plot
ggplot(airquality, aes(x=Temp)) + geom_density() # This is similar to a histogram, in that it can show peaks and troughs in the distribution, but with a density plot, the precise shape of each factors (in this case first_party) distribution can be more easily visualised

# Boxplots

ggplot(airquality, aes(x=factor(Month), y=Temp, fill=Month)) + geom_boxplot() # This plot allows for distributions, means, range and outliers to be very easily identified. The mean is the horizontal line across each box and the top section of each box the 75%ile, with the bottom section 25%ile. The colour or shape of outliers can be altered with outlier. Or even removed eg.
ggplot(airquality, aes(x=factor(Month), y=Temp, fill=Month)) + geom_boxplot(outlier.shape = NA)

boxplot.stats(airquality$Temp)

# ==== Basic Statistical Analysis and Visualisation ====

# Here we can look back at some of the plots we have produced, as well as some new ones, and try to analyse them in more detail

# ---- Scatter Plots ----
ggplot(airquality, aes(Temp, Wind, shape = factor(Month))) + geom_point(aes(colour = factor(Month)), size = 4)
# This appears to show a weak correlation between Wind and Temperature. With higher wind levels generally indicating lower temperatures. Additionally, we can track general trends between months

# Adding lines of best fit can help to highlight this further
ggplot(airquality, aes(Temp, Wind, shape = factor(Month))) + geom_point(aes(colour = factor(Month)), size = 4) + geom_smooth(method = lm, se=FALSE)

# ---- Histogram ----

Histogram + theme_dark()
# This plot seems to suggest that Months earlier in the year generally have lower Temperatures, though by September (9), the temperature is far more spread out. We can make this easier to analyse by adding a y intercept along the mean Temp value
Histogram + theme_dark() + geom_vline(xintercept=(mean(airquality$Temp)), colour="white", lwd=2)
# Here we can see that almost all of July (7) is above the mean Temperature, while almost all of May (5) is below.

# We can also manually add intercept values.
mean(airquality$Temp)
Histogram + theme_dark() + geom_vline(xintercept= 77.89, colour="white", lwd=2)

# ---- Density Plot ----
ggplot(airquality, aes(x=Temp)) + geom_density()
# With this very simple plot, it is immediately clear that there is a Temperature peak at a little over 80F, suggesting most Temperature values are around 80F, with a sharp drop off for anything warmer than that.

# ---- Boxplots ----
ggplot(airquality, aes(x=factor(Month), y=Temp, fill=Month)) + geom_boxplot()
# Similar to the Historgram, this plot seems to suggest that Months earlier in the year generally have lower Temperatures. With this visualisation, the wider spread in September (9) is even clearer, suggesting a higher standard deviation. Additionally, June and July have the most outliers, but the smallest standard deviations. Suggesting fairly uniform Temperature spread in these months, but with some extremes.

# ==== Exporting Plots ====
# Plots can be exported in a number of formats, very easily by simply clicking Export in the Plot window. This can also be done through the COnsole, and allows somewhat more control
jpeg(file= 'Output/Histogram.jpeg')
Histogram
dev.off()

png(file= 'Output/Box.png')
Histogram + theme_dark() + geom_vline(xintercept=(mean(airquality$Temp)), colour="white", lwd=2)
dev.off()

jpeg(file= 'Output/Histogram.jpeg', res=600, width=4800, height=4800)
Histogram
dev.off()

# jpeg() starts the device and requires the destination and file name to be specified. The plot can then be run as normal, before dev.off() turns off the jpeg device and the plot should be exported to the destination you specified



