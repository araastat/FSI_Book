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
than `myData` which is also different from `Mydata` and `My_Data` and `MyData` and `my_data`.

The ultimate goal for every script file is to create a "story" using the language of R, 
starting from data to create descriptions, understand patterns through visualization and modeling,
and analyzing the data in general. Scripts make this story reproducible, and also transferable to different data sets. 

Of course, as with any beginner writer, your coding will be sloppy at first, will suffer many 
stops and starts and strike-throughs and modifications and throwing things into the proverbial trash. With practice, this will become easier and smoother and more effective and more expressive. This workshop is designed to give you an initial push towards that goal. 

So, let's start this journey.

## R Packages {-}

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

### Loading packages in R {-}

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



## R Resources {-}

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