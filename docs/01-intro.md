# (PART\*) Starting up {-}

# What is R?

[R](https://www.r-project.org){target=_blank} is the 
most popular[^1] open source _statistical programming language_ in the world. It
allows you to 

1. read datasets written in a wide variety of formats, 
1. clean and process the data,
1. derive summaries, 
1. run analytics, 
1. visualize
1. create automated reports, presentations, websites, dashboards and interactive applications


[^1]: https://spectrum.ieee.org/static/interactive-the-top-programming-languages-2018

R is not just a language, but an ecosystem comprising over 15,000 user- and corporation-developed
_packages_ or modules, all written in the R language for a variety of purposes. It is a very flexible and customizable language, which is why it is used by an estimated 2 million users worldwide for data analytics.
The question R users often ask is not "Can it be done?" but rather "How can it be done?". R is used
in areas as varied as healthcare, economics, forestry, oceanography, pharmaceuticals, artificial
intelligence and natural language processing. 

Why is R so widely used? Some reasons are:

- R is open source, so it is accessible to anyone with a computer
- Since the code in R and all its packages are open, the community of users can help debug it
  and make it more reliable and robust
- The R ecosystem is very rich in tools for doing data analytics in particular, so there is almost
  certainly something available for almost any task
- The community of R users worldwide is a very strong, well-connected group who are welcoming,
  ready to help, cooperative and inclusive. Many users find this community to be one of the most
  attractive things about R
- R produces really nice customizable visualizations with relatively little effort, which was one of the 
  first reasons for popularity.

## A note on coding and programming {-}

R does not have a _point-and-click_ interface that you are probably more familiar with
from Excel, Word or other computer applications. It requires you to _code_, i.e. write
instructions for the computer to, in the case of R, read, analyze, graph and report on datasets. 

R is first and foremost a __language__. So, instead of thinking that this is some 
geeky thing that "programmers" and "IT people" do, think of it as learning a language. 
You will see that, like any language, it has nouns, verbs, adjectives and adverbs, 
and you can create "sentences" that start with data and end in something useful like a 
table, graph or document. With a traditional spoken and written language like French, Arabic, Farsi or Japanese, you learn it to 
be able to interact with people at different posts around the world. With a programming language
like R, you will be able to interact with __data__, to make sense of it, to describe it,
and to present it. 

### Coding {-}

Coding is writing explicit instructions to a very literal, and in some ways, stupid machine.
The machine takes our code literally, and will do __exactly__ what you tell it to do in the code. If
you are getting unexpected results, it's almost certainly your code that needs to be checked, not 
the machine. 

### R, the language {-}

As we will see, R has many elements of a language. 

- __Objects__: These are the _nouns_. We will act on objects to create new objects. Each object has a _name_ which we will treat as the nouns in our code.
- __Functions__: These are the _verbs_. Functions will act on objects to create new objects.
- __The ` %>% ` operator__: This acts like the conjunction "then" to create "sentences" called _pipes_ or _chains_.
- __Optional function arguments__: These are adverbs which modify the action of the function (verb).

While writing code in R, we should be aware that R is __case-sensitive__, so `mydata` is a different object
than `myData` which is also different from `Mydata` and `My_Data` and `MyData` and `my_data`, and `mean`, which is a function in R, is different from `Mean` which is not defined in R. 

>  You have to name all the objects you create in R if you want to see them again. Try and pick a 
naming system that is simple yet descriptive, rather than `data1`. Two typical conventions that are used
are CamelCase and pothole_case. So you could name a dataset of operational budgets for January, 2019 as
`operations_budget_2019_jan` or `OperationsBudget2019Jan` or really anything you want, as long as it's
clear to you and doesn't include some forbidden characters like `-`, `@`,`$` which are reserved for 
other purposes, or doesn't start with a number. 
>
> Some people have a system where data objects (which are called `data.frame` or `tibble` or `vector` or `matrix`) should be 
capitalized, while function names should not. Data objects should probably be nouns and functions verbs, since that reminds us of their functions. There are different opinions. Some influential ones are
[here](http://adv-r.had.co.nz/Style.html) and [here](https://google.github.io/styleguide/Rguide.xml). As they say, finding a good name is hard, but often worth the effort.





The ultimate goal for every script file is to create a "story" using the language of R, 
starting from data to create descriptions, understand patterns through visualization and modeling,
and analyzing the data in general. Scripts make this story reproducible, and also transferable to different data sets. 

Of course, as with any beginner writer, your coding will be sloppy at first, will suffer many 
stops and starts and strike-throughs and modifications and throwing things into the proverbial trash. With practice, this will become easier and smoother and more effective and more expressive. This workshop is designed to give you an initial push towards that goal. 

So, let's start this journey.

## A short introduction to R objects

### Objects

The broad categorization of R objects in my mind are functions (verbs) and data objects (nouns).
Data objects are in turn of different types:

- `data.frame` or `tibble`: These are rectangular data sets much like you would see in a spreadsheet
- `vector`: This is a 1-dimensional list of numbers or strings (words in the language sense), but all must be of the same kind (number or string)
- `matrix`: This is a 2-dimensional list of numbers or strings, once again all of the same type
- A single number or word
- `list`: This is a catch-all bucket. Each element of a list can be literally any valid R object. So they could be `tibble`'s, or functions, or matrices, and different elements can be of different types.

Most objects we'll use in this workshop are going to be `data.frame` or `tibble` objects. (In case you're wondering, they're basically the same thing, but `tibble`'s have some modest additional functionality). R comes with a bunch of built-in datasets stored as `data.frame`s. 


```r
mtcars
```

```
##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

A `data.frame` can be acted upon by different functions to help describe it and extract elements from it. For example, to see the size of the data, we use


```r
dim(mtcars)
```

```
## [1] 32 11
```

Data sets often have row names and column names. These can be extracted by the functions `rownames` and
`colnames` or `names`:


```r
rownames(mtcars)
```

```
##  [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
##  [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
##  [7] "Duster 360"          "Merc 240D"           "Merc 230"           
## [10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
## [13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
## [16] "Lincoln Continental" "Chrysler Imperial"   "Fiat 128"           
## [19] "Honda Civic"         "Toyota Corolla"      "Toyota Corona"      
## [22] "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
## [25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"      
## [28] "Lotus Europa"        "Ford Pantera L"      "Ferrari Dino"       
## [31] "Maserati Bora"       "Volvo 142E"
```

```r
names(mtcars)
```

```
##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
## [11] "carb"
```

Both of these are valid R objects that are vectors of strings. You could save them for future use by _assigning_ them a name using the assignment operator `<-`. So if you wanted to store the row names, which are the makes and models of the cars in this data set (this structure is not desirable, as we'll discuss later), you could run


```r
car_names <- rownames(mtcars)
```

You can see that this is stored in R for current use, either by typing `ls()` in the console (for "list") or by looking in the `Environment` pane in RStudio.

> The output of any function is a valid R object, and so you can always store the results of the 
function by assigning it a name, as above. 

### Extracting elements from objects

We can see the structure of any object by using the function `str`.


```r
str(mtcars)
```

```
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```

This tells us that `mtcars` is a `data.frame` with 32 observations (rows) and 11 variables (columns). 
Each variable has a name, and all the variables are numeric.

> `data.frame` objects are like lists, in that each column can be of a different type. This is a very
powerful structure, since we can keep all sorts of data together, and can load spreadsheets with 
diverse kinds of data easily into R

To extract the `mpg` variable from this data set, there are a few equivalent methods. My preferred method is `mtcars[,'mpg']`, i.e., extract the _column_ named "mpg" from this data set. Notice that we're using `[]` while functions use `()`. This format of extraction will work when you're extracting more than one variable, as we'll see below. Other ways include `mtcars[['mpg']]` and `mtcars$mpg`, which are
the `list` way and a `data.frame`-specific shortcut. 

> You can also extract elements by position, either using the `[,]` or `[[]]` forms. So, to extract an
element in the 2nd row and 4th column, you'd have to use the matrix notation as `mtcars[2,4]`. To
extract the 4th column, you could use either `mtcars[,4]` or `mtcars[[4]]`. To extract the 2nd row, 
you'd again use the matrix notation as `mtcars[2,]`. 

If we want to extract the mpg, cyl and disp variables at once to create a new `data.frame`, you can 
use either the matrix notation `mtcars[,c('mpg','cyl','disp')]` or the list notation `mtcars[[c('mpg','cyl','disp')]]`.  The `c()` function stands for _concatenate_ and is the function used to __create__ vectors. We'll actually see a much more user-friendly way of doing this in the data munging section\@ref(sec:data-munging). 

> __Advanced note:__ A `data.frame` object is really a `list` object where all the elements are vectors
of the same length, and which happen to have names assigned to them. The object also looks like a matrix
or 2-dimensional array visually. So both notations were allowed to be valid for `data.frame` objects. 


## R Packages

Packages are modules of R code that enhance the capabilities of R. Many packages are well established and curated, and have to go through a strict software compatibility review before allowed on [CRAN](https://cran.rstudio.com). 

### Installing packages {-}

Installing packages on your computer can be done from the RStudio menu (`Tools > Install Packages`), 
or by running the command `install.packages(<package name>, repos = "https://cran.rstudio.com")`. For example, to install the `readxl` package, which we will use shortly, we would run the code 

```r
install.packages("readxl", repos="https://cran.rstudio.com")
```

> You can set the default repository in RStudio, in `Tools > Global Options`.

> Be aware that everything here is case-sensitive

Another way to install packages is to go to the `Packages` pane in RStudio, use the search bar there to 
find the package you want to install, and then click the checkbox beside the name. This is convenient, 
but not very reproducible if you have to move to a different computer, so it's generally discouraged.

How do you find packages? Glad you asked. The easiest way to find packages on CRAN is actually through the RStudio `Packages` pane, where the entire set of available packages are listed with a brief, top-line description. You can click on the package name to see a much more detailed overview of the packages, and many packages do have vignettes which give more information. However, once you've found the package you want, you should really code it up with `install.packages`, so that you can save the script for later when you might need to remember it again.

### Loading packages in R

We will use several packages to enhance our experience and get going faster. However, to use a package, you must first load it into R. To load a package into R, you use the function `library` (ironically). 

The first package we will load is the `tidyverse` package. This is actually a meta-package, which in turn loads a bunch of other packages. These form a core group of useful packages that are widely used, including

- readr (reading data from text files)
- tidyr (Manipulation, pivoting)
- dplyr (summarize, aggregate, filter)
- ggplot2 (visualization)
- purrr (functions applied across data structures, meta-programming)
- stringr (string manipulation)
- forcats (categorical data)

In addition, we'll load the `readxl` package for reading Excel files. 

```r
library(tidyverse)
library(readxl)
```



## R Resources 

There are many high quality resources for learning R available online. This is a selection of
what I find most useful.

1. [CRAN Task Views](https://cran.rstudio.com/web/views){target=_blank}: These are curated lists of R packages for various purposes, ranging from econometrics to mathematics, finance, imaging, social sciences, time series, spatial analyses and more. 
1. [RStudio Cheatsheets](https://www.rstudio.com/resources/cheatsheets/): These are high-quality 
cheatsheets about different aspects of the R analytic pipeline. 
1. [StackOverflow #r](https://stackoverflow.com/questions/tagged/r): The `r` tag on StackOverflow is 
_the_ place to find answers about R
1. [Twitter #rstats](https://twitter.com/hashtag/rstats): The who's who of R hang out at the #rstats hashtag, and questions can get answered very quickly. Also a way to find out what new packages are coming up
1. [R-Bloggers](http://www.r-bloggers.com): A blog aggregator which collects a few hundred R-related blogs in one place (including mine, in the interests of disclosure)
1. [RSeek](http://r-seek.org): When one realizes that R is just a letter in the alphabet, Google searches can be a bit difficult. RSeek has created a custom search targeted at R-related topics, sites and packages on the web.
