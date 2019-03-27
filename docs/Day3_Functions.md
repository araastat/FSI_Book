# Functions




```r
myDumbFunction <- function() 42
myDumbFunction()
```

```
[1] 42
```

```r
doubleIt <- function(x) {
  myResult <- x * 2
  myResult # or, explicitly, return(myResult)
}
doubleIt(5)
```

```
[1] 10
```

```r
exists("myResult")
```

```
[1] FALSE
```

```r
myResult <- 1000
doubleItOutput <- doubleIt(2)
myResult
```

```
[1] 1000
```

```r
my_sum <- function(x){
  s <- sum(x)
  n <- length(x)
  result <- s / n
  return(result)
}
```

```r
my_sum(1:10)
```

```
[1] 5.5
```

```r
answer <- my_sum(1:10)
answer
```

```
[1] 5.5
```

```r
my_sum <- function(x){
  s <- sum(x)
  n <- length(x)
  results<- list(sum = s, length = n, answer = s / n)
  return(results)
}
```

```r
my_sum(1:10) 
```

```
$sum
[1] 55

$length
[1] 10

$answer
[1] 5.5
```

```r
my_sum <- function(x){
  s <- sum(x)
  n <- length(x)
  results<- list(sum = s, length = n, answer = s / n)
  return(results)
}
```

```r
answer <- my_sum(1:10)
answer$answer
```

```
[1] 5.5
```

```r
answer[['answer']]
```

```
[1] 5.5
```

```r
names(answer)
```

```
[1] "sum"    "length" "answer"
```

```r
x <- 1:10
x[3] <- NA
my_sum(x)
```

```
$sum
[1] NA

$length
[1] 10

$answer
[1] NA
```

```r
my_sum <- function(x){
  s <- sum(x, na.rm=T)
  n <- length(!is.na(x))
  results <- list("sum" = s, "length" = n, "answer" = s/n)
}
my_sum(x)
```

```r
my_sum <- function(x){
  s <- sum(x, na.rm = T)
  n <- length(!is.na(x))
  results <- list("sum" = s, "length" = n, "answer" = s/n)
  return(results) #<<
}
my_sum(x)
```

```
$sum
[1] 52

$length
[1] 10

$answer
[1] 5.2
```

```r
my_sum <- function(x){
  s <- sum(x, na.rm = T)
  n <- length(!is.na(x)) 
  results <- list("sum" = s, "length" = n, "answer" = s/n)
  return(results) 
}
```

```r
my_sum <- function(x){
  s <- sum(x, na.rm = T)
{{  n <- sum(!is.na(x)) }}
  results <- list("sum" = s, "length" = n, "answer" = s/n)
  return(results) 
}
my_sum(x)
```

```
$sum
[1] 52

$length
[1] 9

$answer
[1] 5.777778
```

```r
my_sum <- function(x){
  s <- sum(x, na.rm = T)
  n <- sum(!is.na(x)) 
  results <- list("sum" = s, "length" = n, "answer" = s/n)
  return(results) 
}
```

```r
my_sum <- function(x, remove_missing = TRUE){ #<<
  s <- sum(x, na.rm = T)
  n <- sum(!is.na(x)) 
  results <- list("sum" = s, "length" = n, "answer" = s/n)
  return(results) 
}
```

```r
my_sum <- function(x, remove_missing = TRUE){ 
  {{if(remove_missing){
    x <- x[!is.na(x)]
  }
  s <- sum(x)
  n <- length(x)}}
  results <- list("sum" = s, "length" = n, "answer" = s/n)
  return(results) 
}
my_sum(x)
```

```
$sum
[1] 52

$length
[1] 9

$answer
[1] 5.777778
```

```r
my_sum <- function(x, remove_missing = TRUE){ 
  if(remove_missing){
    x <- x[!is.na(x)]
  }
  s <- sum(x)
  n <- length(x)
  results <- list("sum" = s, "length" = n, "answer" = s/n, "nmiss" = sum(is.na(x)))
  return(results) 
}
my_sum(x)
```

```
$sum
[1] 52

$length
[1] 9

$answer
[1] 5.777778

$nmiss
[1] 0
```

```r
my_sum <- function(x, remove_missing = TRUE){ 
  nmiss <- sum(is.na(x)) #<<
  if(remove_missing){
    x <- x[!is.na(x)]
  }
  s <- sum(x)
  n <- length(x)
  results <- list("sum" = s, "length" = n, "answer" = s/n, "nmiss" = sum(is.na(x)))
  return(results) 
}
my_sum(x)
```

```
$sum
[1] 52

$length
[1] 9

$answer
[1] 5.777778

$nmiss
[1] 0
```

```r
my_sum <- function(x, remove_missing = TRUE){ 
  nmiss <- sum(is.na(x)) 
  if(remove_missing){
    x <- x[!is.na(x)]
  }
  s <- sum(x)
  n <- length(x)
  results <- list("sum" = s, "length" = n, "answer" = s/n, "nmiss" = nmiss) #<<
  return(results) 
}
my_sum(x)
```

```
$sum
[1] 52

$length
[1] 9

$answer
[1] 5.777778

$nmiss
[1] 1
```

```r
my_sum(x, remove_missing = F)
```

```
$sum
[1] NA

$length
[1] 10

$answer
[1] NA

$nmiss
[1] 1
```

```r
my_summary <- function(d){

}
```

```r
my_summary <- function(d){
  require(tidyverse) #<
}
```

```r
my_summary <- function(d){
  require(tidyverse)
  summary_cts <- d %>% 
    summarize_if(is.numeric, list("mean" = ~mean(x, na.rm=T),
                                  "median" = ~median(x, na.rm=T),
                                  'sd' = ~sd(x, na.rm=T),
                                  'nmiss' = ~sum(is.na(x))))
  return(list("cts" = summary_cts))
}
my_summary(iris)
```

```
Loading required package: tidyverse
```

```
── Attaching packages ───────────────────────────── tidyverse 1.2.1 ──
```

```
✔ ggplot2 3.1.0          ✔ purrr   0.3.2     
✔ tibble  2.0.1          ✔ dplyr   0.8.0.9009
✔ tidyr   0.8.3          ✔ stringr 1.4.0     
✔ readr   1.3.1          ✔ forcats 0.4.0     
```

```
Warning: package 'tibble' was built under R version 3.5.2
```

```
Warning: package 'tidyr' was built under R version 3.5.2
```

```
Warning: package 'stringr' was built under R version 3.5.2
```

```
── Conflicts ──────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
```

```
$cts
  Sepal.Length_mean Sepal.Width_mean Petal.Length_mean Petal.Width_mean
1          5.777778         5.777778          5.777778         5.777778
  Sepal.Length_median Sepal.Width_median Petal.Length_median
1                   6                  6                   6
  Petal.Width_median Sepal.Length_sd Sepal.Width_sd Petal.Length_sd
1                  6        3.073181       3.073181        3.073181
  Petal.Width_sd Sepal.Length_nmiss Sepal.Width_nmiss Petal.Length_nmiss
1       3.073181                  1                 1                  1
  Petal.Width_nmiss
1                 1
```

```r
my_summary <- function(d){
  require(tidyverse)
  summary_cts <- d %>% 
    summarize_if(is.numeric, list("mean" = ~mean(x, na.rm=T),
                                  "median" = ~median(x, na.rm=T),
                                  'sd' = ~sd(x, na.rm=T),
                                  'nmiss' = ~sum(is.na(x)))) %>% 
    gather(variable, value) %>% 
    separate(variable, c("variable","stat"), sep='_') %>% 
    spread(stat, value)
  return(list("cts" = summary_cts))
}
my_summary(iris)
```

```
$cts
      variable     mean median nmiss       sd
1 Petal.Length 5.777778      6     1 3.073181
2  Petal.Width 5.777778      6     1 3.073181
3 Sepal.Length 5.777778      6     1 3.073181
4  Sepal.Width 5.777778      6     1 3.073181
```

```r
my_summary <- function(d){
  require(tidyverse)
  summary_cts <- d %>% 
    summarize_if(is.numeric, list("mean" = ~mean(x, na.rm=T), #<<
                                  "median" = ~median(x, na.rm=T),#<<
                                  'sd' = ~sd(x, na.rm=T),#<<
                                  'nmiss' = ~sum(is.na(x)))) %>% #<<
    gather(variable, value) %>% 
    separate(variable, c("variable","stat"), sep='_') %>% 
    spread(stat, value)
  return(list("cts" = summary_cts))
}
my_summary(iris)
```

```
$cts
      variable     mean median nmiss       sd
1 Petal.Length 5.777778      6     1 3.073181
2  Petal.Width 5.777778      6     1 3.073181
3 Sepal.Length 5.777778      6     1 3.073181
4  Sepal.Width 5.777778      6     1 3.073181
```

```r
my_summary <- function(d){
  require(tidyverse)
  summary_cts <- d %>% 
    summarize_if(is.numeric, list("mean" = ~mean(., na.rm=T),#<<
                                  "median" = ~median(., na.rm=T),#<<
                                  'sd' = ~sd(., na.rm=T),#<<
                                  'nmiss' = ~sum(is.na(.)))) %>% #<<
    gather(variable, value) %>% 
    separate(variable, c("variable","stat"), sep='_') %>% 
    spread(stat, value)
  return(list("cts" = summary_cts))
}
my_summary(iris)
```

```
$cts
      variable     mean median nmiss        sd
1 Petal.Length 3.758000   4.35     0 1.7652982
2  Petal.Width 1.199333   1.30     0 0.7622377
3 Sepal.Length 5.843333   5.80     0 0.8280661
4  Sepal.Width 3.057333   3.00     0 0.4358663
```

```r
my_summary <- function(d){
  require(tidyverse)
  summary_cts <- d %>% 
    summarize_if(is.numeric, list("mean" = ~mean(., na.rm=T),
                                  "median" = ~median(., na.rm=T),
                                  'sd' = ~sd(., na.rm=T),
                                  'nmiss' = ~sum(is.na(.)))) %>% 
    gather(variable, value) %>% 
    separate(variable, c("variable","stat"), sep='_') %>% 
    spread(stat, value) %>% 
    select(variable, nmiss, everything()) #<<
  return(list("cts" = summary_cts))
}
my_summary(iris)
```

```
$cts
      variable nmiss     mean median        sd
1 Petal.Length     0 3.758000   4.35 1.7652982
2  Petal.Width     0 1.199333   1.30 0.7622377
3 Sepal.Length     0 5.843333   5.80 0.8280661
4  Sepal.Width     0 3.057333   3.00 0.4358663
```

```r
my_summary <- function(d){
  require(tidyverse)
  summary_cts <- d %>% 
    summarize_if(is.numeric, list("mean" = ~mean(., na.rm=T),
                                  "median" = ~median(., na.rm=T),
                                  'sd' = ~sd(., na.rm=T),
                                  'nmiss' = ~sum(is.na(.)))) %>% 
    gather(variable, value) %>% 
    separate(variable, c("variable","stat"), sep='_') %>% 
    spread(stat, value) %>% 
    select(variable, nmiss, everything())
  summary_cat <- d %>% #<<
    summarise_if(is.factor, list('nmiss' = ~sum(is.na(.)),#<<
                                 'ncat' = ~length(unique(.)),#<<
                                 'categories' = ~paste(sort(unique(levels(.))), collapse=', ')) #<<
                 )#<<
  return(list("cts" = summary_cts,
              "cat" = summary_cat))
}
my_summary(iris)
```

```
$cts
      variable nmiss     mean median        sd
1 Petal.Length     0 3.758000   4.35 1.7652982
2  Petal.Width     0 1.199333   1.30 0.7622377
3 Sepal.Length     0 5.843333   5.80 0.8280661
4  Sepal.Width     0 3.057333   3.00 0.4358663

$cat
  nmiss ncat                    categories
1     0    3 setosa, versicolor, virginica
```

```r
 my_summary <- function(d){
   require(tidyverse)
   if(!is.data.frame(d)){#<<
     stop("Input must be a data.frame")#<<
   }#<<
   summary_cts <- d %>%
     summarize_if(is.numeric, list("mean" = ~mean(., na.rm=T),
                                   "median" = ~median(., na.rm=T),
                                   'sd' = ~sd(., na.rm=T),
                                   'nmiss' = ~sum(is.na(.)))) %>%
     gather(variable, value) %>%
     separate(variable, c("variable","stat"), sep='_') %>%
     spread(stat, value) %>%
     select(variable, nmiss, everything())
   summary_cat <- d %>%
     summarise_if(is.factor, list('nmiss' = ~sum(is.na(.)),
                                  'ncat' = ~length(unique(.)),
                                  'categories' = ~paste(sort(unique(levels(.))), collapse=', '))
                  )
   return(list("cts" = summary_cts,
               "cat" = summary_cat))
 }
 my_summary(x)
```

```r
datas <- list('cars' = mtcars, 'iris' = iris, 'diamonds'= diamonds)
map(datas, my_summary)
```

```
$cars
$cars$cts
   variable nmiss       mean  median          sd
1        am     0   0.406250   0.000   0.4989909
2      carb     0   2.812500   2.000   1.6152000
3       cyl     0   6.187500   6.000   1.7859216
4      disp     0 230.721875 196.300 123.9386938
5      drat     0   3.596563   3.695   0.5346787
6      gear     0   3.687500   4.000   0.7378041
7        hp     0 146.687500 123.000  68.5628685
8       mpg     0  20.090625  19.200   6.0269481
9      qsec     0  17.848750  17.710   1.7869432
10       vs     0   0.437500   0.000   0.5040161
11       wt     0   3.217250   3.325   0.9784574

$cars$cat
data frame with 0 columns and 1 row


$iris
$iris$cts
      variable nmiss     mean median        sd
1 Petal.Length     0 3.758000   4.35 1.7652982
2  Petal.Width     0 1.199333   1.30 0.7622377
3 Sepal.Length     0 5.843333   5.80 0.8280661
4  Sepal.Width     0 3.057333   3.00 0.4358663

$iris$cat
  nmiss ncat                    categories
1     0    3 setosa, versicolor, virginica


$diamonds
$diamonds$cts
# A tibble: 7 x 5
  variable nmiss     mean  median       sd
  <chr>    <dbl>    <dbl>   <dbl>    <dbl>
1 carat        0    0.798    0.7     0.474
2 depth        0   61.7     61.8     1.43 
3 price        0 3933.    2401    3989.   
4 table        0   57.5     57       2.23 
5 x            0    5.73     5.7     1.12 
6 y            0    5.73     5.71    1.14 
7 z            0    3.54     3.53    0.706

$diamonds$cat
# A tibble: 1 x 9
  cut_nmiss color_nmiss clarity_nmiss cut_ncat color_ncat clarity_ncat
      <int>       <int>         <int>    <int>      <int>        <int>
1         0           0             0        5          7            8
# … with 3 more variables: cut_categories <chr>, color_categories <chr>,
#   clarity_categories <chr>
```

