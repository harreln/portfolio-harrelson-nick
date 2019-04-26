
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

D2 multiway
-----------

State the number of observations: 177

List the variables:

-   Market value (USD billions)
    -   continuous quantitative variable
-   Commodity
    -   nominal categorical with 24 levels
-   Year
    -   ordinal categorical with 8 levels
-   Drought Intensity
    -   ordinal catergorical with 6 levels

State the graph type: multiway plot

Explain why the graph type is suited to the data structure:

There is enough overlap between the years and commoditities for a multiway plot. The commodities that fell out of the top 20 are simply not listed for those years. This plot helps explain the trends within each commodity while still allowing you to get a picture of the overall market.

Explain each design choice and cite its supporting reference

-   Reordered the commodities based on median market value. Allows the reader to better understand the data (Robbins, 2013a, 161).
-   Made commodity the facet to organize by, I think it told the more interesting story.
-   Multiway plot prevents superimposed data (Robbins, 2013a, 170).
-   Chose to augment with drought data to add more context.

Comments from peers

Does the data structure satisfy the portfolio display requirements? From the Doumont paper, what type of story is being told? Is the graph type suited to the data structure? Other suggestion etc

fraction of market value total new multiway using drought and commodities

D3 correlations
---------------

State the number of observations:

List the variables:

-   Happiness Index (0-10)
    -   Continuous quantitative variable
-   GDP (Billions of USD)
    -   Continuous quantitative variable
-   Populations
    -   Continuous quantitative variable
-   Region
    -   Categorical variable with 9 levels

State the graph type: scatter plot

Explain why the graph type is suited to the data structure:

-   we are exploring the correlation between two quantitative variables
-   facets used to divide the data by given factors
-   population, is not critical, but easily shown via the point size

Explain each design choice and cite its supporting reference

-   Reordered the factes based on median happiness. Allows the reader to better understand the data (Robbins, 2013a, 161).
-   Chose to augment with population data for more context.
-   Log scale used to fix aspect ratio.
-   Made points slightly transparent to increase readability. Overlapping plotting symbols must be distinct (Robbins, 2013a, 165).
-   Used facets instead of different colors to divide regions. Avoiding superposed data increases readibility (Robbins, 2013a, 171).

Comments from peers

-   Does the data structure satisfy the portfolio display requirements?
-   From the Doumont paper, what type of story is being told?
-   Is the graph type suited to the data structure?
-   Other suggestion
-   etc

label points of interest mean for years might remove blobs does gdp buy happiness? might use this for d7 micromap instead? then use scatterplot for something else

D4 injuries or fatalities displayed ethically
---------------------------------------------

**Context**

Type of injury or fatality: Oral cancer cases

People affected: Americans: hispanic, asian, black, white

Over what span of time: Lifetime

**Graph the data conventionally**

-   If you are redesigning someone else's graph, include an image of the original
-   If not, graph the data yourself using a graph type suited to the data

State the number of observations:

List the variables:

-   Race
    -   Nominal Categorical variable with 4 levels
-   Gender
    -   Nominal Categorical variable with 2 levels
-   Age
    -   Ordinal Categorical variable with 8 levels
-   Rate per 100,000
    -   Continuous quantitative varible

State the graph type: Dot plot

Explain why the graph type is suited to the data structure:

-   Comparing a single quantitative variable against multiple categories.
-   Male/female plotted on the same axes due to the overlap in other categories. Also allows easy comparison of the two.

Explain the visual-rhetoric features of the graph that make it unethical:

-   Now that I think about it, I'm not sure how much of the graphic is actually used to convey humanity. This instead comes off as a warning/no smoking advert. Which is still grim, but a slightly different goal than empathy.

Peer feedback:

Resources
---------

Robbins N (2013a) General principles for creating effective graphs. *Creating More Effective Graphs*. Chart House, Wayne, NJ, 154–225 <http://www.nbr-graphs.com/resources/recommended-books/>
