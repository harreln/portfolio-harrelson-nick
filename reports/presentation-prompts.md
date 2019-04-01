
Presentation prompts
====================

Complete the prompts before the start of class on the day of the presentation.

-   These points guide the small-group discussions.
-   Much of this work will be part of your portfolio critiques.

D1 distributions
----------------

State the number of observations: 137,221

List the variables:

-   Quality - Good or Bad
    -   Categorical variable with 2 levels
-   Continent of origin
    -   Categorical variable with 6 levels
-   Price per bottle in USD
    -   Continuous quantitative variable

State the graph type: Boxplot

Explain why the graph type is suited to the data structure:

-   The large number of observations makes it impossible to see any distinct argument when using a strip plot.
-   The outliers aren't that useful in this case, so we want to get an idea of where the majority of the data lives.
-   There is a single quantitative variable that we want to compare between categories.

Explain each design choice and cite its supporting reference

-   Distinguished good/bad wine based on the median of the points in the dataset. This makes it easier for the user to interpret and is a much easier calculation for the computer to handle ahead of time (Robbins, 2013a, 217). The same can be argued for simplifying country to continent.
-   Reordered the data based on the average price within each continent. Allows the reader to better understand the data (Robbins, 2013a, 161).
-   Chose tick mark intervals of $10. I originally chose $5 because I thought that would be most relevant to the consumer, but I thought this cluttered the graph too much. As a compromise I went with $10 intervals to keep it relevant, but also to reduce the number of lines and make the data stand out better (Robbins, 2013a, 183).
-   Flipped the axes so that the continent labels can be more easily read.
-   Chose not to display outliers, as they are so large that they change the size of the boxplots relative to the data rectangle making them hard to read/distinguish.

Comments from peers

-   vertical lines for comparisons at dollar amounts
-   inflation on prices (years)
-   stuff for class, introduction, then plot, then choices
-   where the division is between good/bad may vary

Robbins N (2013a) General principles for creating effective graphs. *Creating More Effective Graphs*. Chart House, Wayne, NJ, 154–225 <http://www.nbr-graphs.com/resources/recommended-books/>
