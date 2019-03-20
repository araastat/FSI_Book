--- 
title: "Course notes for PS312"
subtitle: "Programming with R"
author: "Abhijit Dasgupta, PhD"
date: "2019-03-20"
knit: bookdown::render_book
site: bookdown::bookdown_site
documentclass: book
#bibliography: 
#biblio-style: apalike
#link-citations: yes
monofont: "Source Code Pro"
monofontoptions: "Scale=0.7"
github-repo: araastat/FSI_Book
description: "These are course notes for the FSI course 'Programming with R' (PS 312) taught over 3 days"
url: 'https\://www.araastat.com/FSI_Book'
twitterhandle: webbedfeet

---

# Welcome {-}

This course is an introduction to the statistical programming language 
[R](http://www.r-project.org) and various applications. We will cover the entire data analytics pipeline from data ingestion to data wrangling, summarizing, modeling, visualizing and reporting, all using tools found within the R ecosystem

The version of these notes you are reading now was built on 
2019-03-20. To raise an issue about the note's content (e.g., code not running) or to make a feature request, check out the 
[issue tracker](https://github.com/araastat/FSI_Book/issues).

## Reproducibility {-}

These notes are written with [`bookdown`](http://www.bookdown.org), a R package for writing books using [`rmarkdown`](http://rmarkdown.rstudio.com).
All code in these notes were developed on R version 3.5.0 (2018-04-23), using
the same packages pre-installed in your virtual machines. When you're on your
own, you will need to install a recent version of R, and also install the
corresponding packages, on your computer, for all the code to work. A listing of
all the packages used in this course will be available as an appendix.

To build these notes locally, clone or [download](https://github.com/araastat/FSI_Book/archive/master.zip) the 
[Github repo](https://github.com/araastat/FSI_Book) hosting these notes, unzip it if necessary, and double-click on `FSI_Book.Rproj`. Assuming you have RStudio installed, this will open this project (more on _RStudio Projects_ later). You can then go to the console and enter the following code:


```r
bookdown::render_book("index.Rmd") # to build these notes
browseURL("_book/index.html") # to view it
```

## License {-}

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">PS 312 Course Notes</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/araastat/FSI_Book" property="cc:attributionName" rel="cc:attributionURL">Abhijit Dasgupta</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.