# Describing data {#sec:description}




Data cleaning and munging is important, yet tedious work. Now that we're done
with that, we can get to the fun part of exploring the data. 

Our workhorse for this will be the `dplyr` package, part of the `tidyverse`. This
package provides 5 basic verbs:

- `filter`: filter a dataset by rows
- `select`: select columns of a dataset
- `arrange`: arrange rows of a dataset by values of some variables
- `group_by`: split a dataset by values of some variables, so that we can apply verbs to each split
- `summarize`: compute various summaries from the data

`dplyr` also has verbs to let stitch datasets together, which are `left_join`, 
`right_join`, `inner_join`, `outer_join`, `semi_join`, `anti_join`, `bind_rows` and
`bind_cols`.

I'll be using the latest `dplyr`, version 0.8.0.9009. If you have 
an older version, most but not all things will work. 

We'll start with the in-build `mtcars` dataset. 


```r
library(tidyverse)
mtcars1 <- mtcars %>% rownames_to_column('cars') %>% as_tibble()
mtcars1
```

```
## # A tibble: 32 x 12
##    cars     mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
##    <chr>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
##  1 Mazda…  21       6  160    110  3.9   2.62  16.5     0     1     4     4
##  2 Mazda…  21       6  160    110  3.9   2.88  17.0     0     1     4     4
##  3 Datsu…  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
##  4 Horne…  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
##  5 Horne…  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
##  6 Valia…  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
##  7 Duste…  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
##  8 Merc …  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
##  9 Merc …  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
## 10 Merc …  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
## # … with 22 more rows
```

Let's get some summary statistics from this dataset. First, let's compute the average 
mpg, displacement, and horsepower of these cars.


```r
mtcars1 %>% summarize(mpg = mean(mpg, na.rm=T), disp = mean(disp, na.rm=T), hp = mean(hp, na.rm=T))
```

```
## # A tibble: 1 x 3
##     mpg  disp    hp
##   <dbl> <dbl> <dbl>
## 1  20.1  231.  147.
```

> I'm adding the option `na.rm=T` to remove any missing values; if there is even a single missing value, the mean will be computed as `NA`

Most `dplyr` verbs also have scoped versions `*_all`, `*_at`, `*_if`, which can be useful. The `*_any` versions act
upon all the columns, the `*_at` versions on specified columns (same way columns are specified in `select`) and the 
`*_if` versions on columns with particular properties. So the above  code could be written as


```r
mtcars1 %>% summarize_at(vars(mpg, disp, hp), mean, na.rm = T)
```

```
## # A tibble: 1 x 3
##     mpg  disp    hp
##   <dbl> <dbl> <dbl>
## 1  20.1  231.  147.
```

### Factors or categorical variables {-}

R has a data type called a `factor`, which is meant for categorical or discrete variables; things like sex, race, and, 
in this data, `cyl`. We need to transform the column to this data type first. 


```r
mtcars1 <- mtcars1 %>% 
  mutate(cyl = as.factor(cyl))
```

There are a few others that might need this treatment.


```r
mtcars1 <- mtcars1 %>% 
  mutate_at(vars(cyl, vs, am, gear, carb), as.factor)
```

Let's see what we've done.


```r
str(mtcars1)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	32 obs. of  12 variables:
##  $ cars: chr  "Mazda RX4" "Mazda RX4 Wag" "Datsun 710" "Hornet 4 Drive" ...
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : Factor w/ 3 levels "4","6","8": 2 2 1 2 3 2 3 1 1 2 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : Factor w/ 2 levels "0","1": 1 1 2 2 1 2 1 2 2 2 ...
##  $ am  : Factor w/ 2 levels "0","1": 2 2 2 1 1 1 1 1 1 1 ...
##  $ gear: Factor w/ 3 levels "3","4","5": 2 2 2 1 1 1 1 2 2 2 ...
##  $ carb: Factor w/ 6 levels "1","2","3","4",..: 4 4 1 1 2 1 4 2 2 4 ...
```

Now, let's compute averages of all the non-factor, or numeric, variables.


```r
mtcars1 %>% summarize_if(is.numeric, mean)
```

```
## # A tibble: 1 x 6
##     mpg  disp    hp  drat    wt  qsec
##   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1  20.1  231.  147.  3.60  3.22  17.8
```

We can get a summary of all the variables using the function `summary`.


```r
summary(mtcars1)
```

```
##      cars                mpg        cyl         disp             hp       
##  Length:32          Min.   :10.40   4:11   Min.   : 71.1   Min.   : 52.0  
##  Class :character   1st Qu.:15.43   6: 7   1st Qu.:120.8   1st Qu.: 96.5  
##  Mode  :character   Median :19.20   8:14   Median :196.3   Median :123.0  
##                     Mean   :20.09          Mean   :230.7   Mean   :146.7  
##                     3rd Qu.:22.80          3rd Qu.:326.0   3rd Qu.:180.0  
##                     Max.   :33.90          Max.   :472.0   Max.   :335.0  
##       drat             wt             qsec       vs     am     gear  
##  Min.   :2.760   Min.   :1.513   Min.   :14.50   0:18   0:19   3:15  
##  1st Qu.:3.080   1st Qu.:2.581   1st Qu.:16.89   1:14   1:13   4:12  
##  Median :3.695   Median :3.325   Median :17.71                 5: 5  
##  Mean   :3.597   Mean   :3.217   Mean   :17.85                       
##  3rd Qu.:3.920   3rd Qu.:3.610   3rd Qu.:18.90                       
##  Max.   :4.930   Max.   :5.424   Max.   :22.90                       
##  carb  
##  1: 7  
##  2:10  
##  3: 3  
##  4:10  
##  6: 1  
##  8: 1
```

However, this does not give us a tidy dataset. Some alternatives are the `skimr` package and 
the `ezsummary` package. 


```r
# install.packages('skimr')
library(skimr)
```

```
## Warning: package 'skimr' was built under R version 3.5.2
```

```
## 
## Attaching package: 'skimr'
```

```
## The following object is masked from 'package:stats':
## 
##     filter
```

```r
skim(mtcars1)
```

```
## Skim summary statistics
##  n obs: 32 
##  n variables: 12 
## 
## ── Variable type:character ───────────────────────────────────────────
##  variable missing complete  n min max empty n_unique
##      cars       0       32 32   7  19     0       32
## 
## ── Variable type:factor ──────────────────────────────────────────────
##  variable missing complete  n n_unique                top_counts ordered
##        am       0       32 32        2       0: 19, 1: 13, NA: 0   FALSE
##      carb       0       32 32        6  2: 10, 4: 10, 1: 7, 3: 3   FALSE
##       cyl       0       32 32        3 8: 14, 4: 11, 6: 7, NA: 0   FALSE
##      gear       0       32 32        3 3: 15, 4: 12, 5: 5, NA: 0   FALSE
##        vs       0       32 32        2       0: 18, 1: 14, NA: 0   FALSE
## 
## ── Variable type:numeric ─────────────────────────────────────────────
##  variable missing complete  n   mean     sd    p0    p25    p50    p75
##      disp       0       32 32 230.72 123.94 71.1  120.83 196.3  326   
##      drat       0       32 32   3.6    0.53  2.76   3.08   3.7    3.92
##        hp       0       32 32 146.69  68.56 52     96.5  123    180   
##       mpg       0       32 32  20.09   6.03 10.4   15.43  19.2   22.8 
##      qsec       0       32 32  17.85   1.79 14.5   16.89  17.71  18.9 
##        wt       0       32 32   3.22   0.98  1.51   2.58   3.33   3.61
##    p100     hist
##  472    ▇▆▁▂▅▃▁▂
##    4.93 ▃▇▁▅▇▂▁▁
##  335    ▃▇▃▅▂▃▁▁
##   33.9  ▃▇▇▇▃▂▂▂
##   22.9  ▃▂▇▆▃▃▁▁
##    5.42 ▃▃▃▇▆▁▁▂
```

## Split-apply-combine, a.k.a. MapReduce

The split-apply-combine is a powerful paradigm for understanding subgroups within a dataset. The basic 
idea is that you split the data into pieces based on values of some variables, do something (the same thing) to 
each piece, and then stitch the results back together. 

![](img/split-apply-combine.png)

For example, in the mtcars data, we might want to know what the average mpg is by the number of cylinders. The
way to do this is:


```r
mtcars1 %>% 
  group_by(cyl) %>% 
  summarize(mpg_mean = mean(mpg))
```

```
## # A tibble: 3 x 2
##   cyl   mpg_mean
##   <fct>    <dbl>
## 1 4         26.7
## 2 6         19.7
## 3 8         15.1
```

Once again, the scoped versions of `summarize` will also work in this pipe


```r
mtcars1 %>% 
  group_by(cyl) %>% 
  summarize_if(is.numeric, mean)
```

```
## # A tibble: 3 x 7
##   cyl     mpg  disp    hp  drat    wt  qsec
##   <fct> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 4      26.7  105.  82.6  4.07  2.29  19.1
## 2 6      19.7  183. 122.   3.59  3.12  18.0
## 3 8      15.1  353. 209.   3.23  4.00  16.8
```

Let's go a bit further and compute the medians as well.


```r
mtcars1 %>% 
  group_by(cyl) %>% 
  summarize_if(is.numeric, list('mean'= mean, 'median' = median))
```

```
## # A tibble: 3 x 13
##   cyl   mpg_mean disp_mean hp_mean drat_mean wt_mean qsec_mean mpg_median
##   <fct>    <dbl>     <dbl>   <dbl>     <dbl>   <dbl>     <dbl>      <dbl>
## 1 4         26.7      105.    82.6      4.07    2.29      19.1       26  
## 2 6         19.7      183.   122.       3.59    3.12      18.0       19.7
## 3 8         15.1      353.   209.       3.23    4.00      16.8       15.2
## # … with 5 more variables: disp_median <dbl>, hp_median <dbl>,
## #   drat_median <dbl>, wt_median <dbl>, qsec_median <dbl>
```

We can look at a second dataset showing individual violent incidents in Western Afrika
between 2000 and 2017. We can get the number of incidents per country and year very easily using this paradigm.


```r
west_africa <- import('data/2000-01-01-2019-01-01-Western_Africa.csv')
west_africa %>% group_by(country, year) %>% tally()
```

```
## # A tibble: 290 x 3
## # Groups:   country [15]
##    country  year     n
##    <chr>   <int> <int>
##  1 Benin    2000     1
##  2 Benin    2001     3
##  3 Benin    2002     1
##  4 Benin    2003     2
##  5 Benin    2004     2
##  6 Benin    2005     2
##  7 Benin    2006     1
##  8 Benin    2007     3
##  9 Benin    2008     1
## 10 Benin    2009     2
## # … with 280 more rows
```

For display, we can make this a wide dataset


```r
west_africa %>% group_by(country, year) %>% tally() %>% 
  spread(year, n)
```

```
## # A tibble: 15 x 21
## # Groups:   country [15]
##    country `2000` `2001` `2002` `2003` `2004` `2005` `2006` `2007` `2008`
##    <chr>    <int>  <int>  <int>  <int>  <int>  <int>  <int>  <int>  <int>
##  1 Benin        1      3      1      2      2      2      1      3      1
##  2 Burkin…     22      6      6      1      4      6      8      1     12
##  3 Gambia       8     14     13     11      5      4      6      2      4
##  4 Ghana       10      8      7     17      7      3      3      5     11
##  5 Guinea     180     70     14     10     11     15      7     46     15
##  6 Guinea…      9      2      3      5      4     13     21      2      2
##  7 Ivory …    133     34    135    177    101     45     30      6     24
##  8 Liberia     87    171    148    242     22     26     22      9     17
##  9 Mali         4      5      2      3      3      2     10     11     21
## 10 Maurit…      4      1      3     13      2      9      3      5     16
## 11 Niger       11      9     42      6     17      9      8     31     28
## 12 Nigeria    168    118    160    207    277    198    120    200    208
## 13 Senegal     86     61     40     18     11     11     29     24     20
## 14 Sierra…    495    224      5     18     14      5      1      6     15
## 15 Togo         4      4      3      4      3     25      1      1      1
## # … with 11 more variables: `2009` <int>, `2010` <int>, `2011` <int>,
## #   `2012` <int>, `2013` <int>, `2014` <int>, `2015` <int>, `2016` <int>,
## #   `2017` <int>, `2018` <int>, `2019` <int>
```

We'll save this dataset for visualization later.


```r
west_africa %>% group_by(country, year) %>% tally() %>% 
  spread(year, n) %>% 
  saveRDS('data/west_africa.rds')
```


## Joins

We mentioned earlier that there are several kinds of ways we can join data. The 
different kinds of joins are described below.

![](img/joins.png)

Let's look at these joins with an example. We have two simulated datasets looking at 
DOS real estate allocation and staffing. We will look at how much area on average each
bureau has given the number of employees


```r
staffing_data <- import('data/Staffing_by_Bureau.csv') %>% as_tibble()
real_estate <- import('data/DoS_Real_Estate_Allocation.csv') %>% as_tibble()
real_estate
```

```
## # A tibble: 666 x 4
##    Building Bureau               Location  Size
##    <chr>    <chr>                   <int> <int>
##  1 HST      Administration (A)       4779   640
##  2 SA2      Administration (A)       4801  1090
##  3 HST      Administration (A)       5109  1040
##  4 HST      Administration (A)       3717  1620
##  5 SA4      Administration (A)       3940  1390
##  6 HST      Administration (A)       3661  1480
##  7 HST      Administration (A)       3374  1770
##  8 HST      Administration (A)       3387  1940
##  9 SA10     African Affairs (AF)     2605   640
## 10 HST      African Affairs (AF)     3573   720
## # … with 656 more rows
```

```r
staffing_data
```

```
## # A tibble: 10,000 x 6
##    Bureau                      Gender Grade Title    Name      YearsService
##    <chr>                       <chr>  <chr> <chr>    <chr>            <int>
##  1 Protocol (S/CPR)            female FS1   Manager  Cathy Ca…           13
##  2 Administration (A)          male   GS-9  Team Me… Jeffery …           13
##  3 Intelligence and Research … male   FS-6  Analyst  Max Green           11
##  4 Mission to the United Nati… male   FS-3  Manager  Donald A…            7
##  5 Foreign Missions (OFM)      male   FS-6  Team Me… Thomas L…           22
##  6 International Narcotics an… male   GS-8  Team Me… Joseph A…           12
##  7 Administration (A)          male   GS-12 Analyst  Michael …            6
##  8 Intelligence and Research … male   FS-5  Team Me… Jesus Sh…            2
##  9 Science & Technology Advis… male   N/A   Manager  Lawrence…           19
## 10 Administration (A)          female FS-8  Team Me… Jennie C…           17
## # … with 9,990 more rows
```
The strategy is going to be to do a grouped summary of the staffing data to see how 
many people are in each Bureau, and then join that with the real estate data to 
compute the average area per employee by Bureau.


```r
staff_summary <- staffing_data %>% 
  group_by(Bureau) %>% 
  tally(name = 'Pop')
realestate_summary <- real_estate %>% 
  group_by(Bureau) %>% summarize(Size = sum(Size))
realestate_summary %>% left_join(staff_summary) %>% 
  mutate(unit_area = Size/Pop) %>% 
  arrange(unit_area)
```

```
## Joining, by = "Bureau"
```

```
## # A tibble: 54 x 4
##    Bureau                                              Size   Pop unit_area
##    <chr>                                              <int> <int>     <dbl>
##  1 Global Youth Issues (GYI)                           2090   345      6.06
##  2 Policy Planning Staff (S/P)                         2420   240     10.1 
##  3 Science & Technology Adviser (STAS)                 4240   305     13.9 
##  4 Foreign Missions (OFM)                              4420   311     14.2 
##  5 Trafficking in Persons (TIP)                        5150   247     20.9 
##  6 Medical Services (MED)                              6760   308     21.9 
##  7 Protocol (S/CPR)                                    7730   327     23.6 
##  8 Administration (A)                                 10970   454     24.2 
##  9 Oceans and International Environmental and Scient…  8420   330     25.5 
## 10 Energy Resources (ENR)                             10890   369     29.5 
## # … with 44 more rows
```


