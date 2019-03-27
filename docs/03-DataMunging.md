# Data Munging {#sec:data-munging} 





Data munging refers to the work of transforming data to make it usable for a computer. 
Data unfortunately comes in all shapes and sizes, with all sorts of issues, so this 
process can take a while. Often a rule of thumb is that making a data set ready for
analysis takes about 80% of the time of a project. 

## Tidy data

There is a principle of making data "tidy", promoted by Dr. Hadley Wickham. This
tidying of data makes computer programs happy, since these data can be most
easily digested. A dataset can be messy or tidy depending on how the rows, columns and tables you're
using align with observations, variables and types. 

The properties of a tidy dataset are:

1. Each variable forms a column
1. Each observation forms a row
1. Each type of observational unit forms a table. 

This forms a standardized way to structure a dataset, and so makes it easy for the 
analyst to develop standard pipelines. 

A dataset can be messy in many many ways. Many of the more common issues are listed below:

- Column names contain values, not just variable names
- Multiple variables are stored in one column
- Variables are stored in both rows and columns
- Multiple types of observational types are stored in the same table
- A single observational unit is stored in multiple tables

Sometimes the messier format is better for data entry, but bad for data analyses. 

We'll show a few examples here, but a more detailed discussion is available [online](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html). 

The workhorse for this tidying activity is the `tidyr` package, part of the `tidyverse`
meta-package. We'll tend to start every analysis by loading the `tidyverse` package, 
so we are covered. 

### Variable in column names


```r
library(tidyverse)
pew <- import('data/pew.csv')
head(pew)
```

```
##             religion <$10k $10-20k $20-30k $30-40k $40-50k $50-75k
## 1           Agnostic    27      34      60      81      76     137
## 2            Atheist    12      27      37      52      35      70
## 3           Buddhist    27      21      30      34      33      58
## 4           Catholic   418     617     732     670     638    1116
## 5 Don’t know/refused    15      14      15      11      10      35
## 6   Evangelical Prot   575     869    1064     982     881    1486
##   $75-100k $100-150k >150k Don't know/refused
## 1      122       109    84                 96
## 2       73        59    74                 76
## 3       62        39    53                 54
## 4      949       792   633               1489
## 5       21        17    18                116
## 6      949       723   414               1529
```

This dataset has actual data in the column headers, rather than variable names. This
information needs to be captured into a column. We should ideally have 3 columns in this
dataset: religion, income and frequency. We can achieve this using a function called `gather` which
takes a wide dataset and makes it tall. We will do this by forming a pipeline (think of this as a sentence),
starting with the dataset.


```r
pew %>% 
  gather(income, frequency, -religion)
```

```
##                    religion             income frequency
## 1                  Agnostic              <$10k        27
## 2                   Atheist              <$10k        12
## 3                  Buddhist              <$10k        27
## 4                  Catholic              <$10k       418
## 5        Don’t know/refused              <$10k        15
## 6          Evangelical Prot              <$10k       575
## 7                     Hindu              <$10k         1
## 8   Historically Black Prot              <$10k       228
## 9         Jehovah's Witness              <$10k        20
## 10                   Jewish              <$10k        19
## 11            Mainline Prot              <$10k       289
## 12                   Mormon              <$10k        29
## 13                   Muslim              <$10k         6
## 14                 Orthodox              <$10k        13
## 15          Other Christian              <$10k         9
## 16             Other Faiths              <$10k        20
## 17    Other World Religions              <$10k         5
## 18             Unaffiliated              <$10k       217
## 19                 Agnostic            $10-20k        34
## 20                  Atheist            $10-20k        27
## 21                 Buddhist            $10-20k        21
## 22                 Catholic            $10-20k       617
## 23       Don’t know/refused            $10-20k        14
## 24         Evangelical Prot            $10-20k       869
## 25                    Hindu            $10-20k         9
## 26  Historically Black Prot            $10-20k       244
## 27        Jehovah's Witness            $10-20k        27
## 28                   Jewish            $10-20k        19
## 29            Mainline Prot            $10-20k       495
## 30                   Mormon            $10-20k        40
## 31                   Muslim            $10-20k         7
## 32                 Orthodox            $10-20k        17
## 33          Other Christian            $10-20k         7
## 34             Other Faiths            $10-20k        33
## 35    Other World Religions            $10-20k         2
## 36             Unaffiliated            $10-20k       299
## 37                 Agnostic            $20-30k        60
## 38                  Atheist            $20-30k        37
## 39                 Buddhist            $20-30k        30
## 40                 Catholic            $20-30k       732
## 41       Don’t know/refused            $20-30k        15
## 42         Evangelical Prot            $20-30k      1064
## 43                    Hindu            $20-30k         7
## 44  Historically Black Prot            $20-30k       236
## 45        Jehovah's Witness            $20-30k        24
## 46                   Jewish            $20-30k        25
## 47            Mainline Prot            $20-30k       619
## 48                   Mormon            $20-30k        48
## 49                   Muslim            $20-30k         9
## 50                 Orthodox            $20-30k        23
## 51          Other Christian            $20-30k        11
## 52             Other Faiths            $20-30k        40
## 53    Other World Religions            $20-30k         3
## 54             Unaffiliated            $20-30k       374
## 55                 Agnostic            $30-40k        81
## 56                  Atheist            $30-40k        52
## 57                 Buddhist            $30-40k        34
## 58                 Catholic            $30-40k       670
## 59       Don’t know/refused            $30-40k        11
## 60         Evangelical Prot            $30-40k       982
## 61                    Hindu            $30-40k         9
## 62  Historically Black Prot            $30-40k       238
## 63        Jehovah's Witness            $30-40k        24
## 64                   Jewish            $30-40k        25
## 65            Mainline Prot            $30-40k       655
## 66                   Mormon            $30-40k        51
## 67                   Muslim            $30-40k        10
## 68                 Orthodox            $30-40k        32
## 69          Other Christian            $30-40k        13
## 70             Other Faiths            $30-40k        46
## 71    Other World Religions            $30-40k         4
## 72             Unaffiliated            $30-40k       365
## 73                 Agnostic            $40-50k        76
## 74                  Atheist            $40-50k        35
## 75                 Buddhist            $40-50k        33
## 76                 Catholic            $40-50k       638
## 77       Don’t know/refused            $40-50k        10
## 78         Evangelical Prot            $40-50k       881
## 79                    Hindu            $40-50k        11
## 80  Historically Black Prot            $40-50k       197
## 81        Jehovah's Witness            $40-50k        21
## 82                   Jewish            $40-50k        30
## 83            Mainline Prot            $40-50k       651
## 84                   Mormon            $40-50k        56
## 85                   Muslim            $40-50k         9
## 86                 Orthodox            $40-50k        32
## 87          Other Christian            $40-50k        13
## 88             Other Faiths            $40-50k        49
## 89    Other World Religions            $40-50k         2
## 90             Unaffiliated            $40-50k       341
## 91                 Agnostic            $50-75k       137
## 92                  Atheist            $50-75k        70
## 93                 Buddhist            $50-75k        58
## 94                 Catholic            $50-75k      1116
## 95       Don’t know/refused            $50-75k        35
## 96         Evangelical Prot            $50-75k      1486
## 97                    Hindu            $50-75k        34
## 98  Historically Black Prot            $50-75k       223
## 99        Jehovah's Witness            $50-75k        30
## 100                  Jewish            $50-75k        95
## 101           Mainline Prot            $50-75k      1107
## 102                  Mormon            $50-75k       112
## 103                  Muslim            $50-75k        23
## 104                Orthodox            $50-75k        47
## 105         Other Christian            $50-75k        14
## 106            Other Faiths            $50-75k        63
## 107   Other World Religions            $50-75k         7
## 108            Unaffiliated            $50-75k       528
## 109                Agnostic           $75-100k       122
## 110                 Atheist           $75-100k        73
## 111                Buddhist           $75-100k        62
## 112                Catholic           $75-100k       949
## 113      Don’t know/refused           $75-100k        21
## 114        Evangelical Prot           $75-100k       949
## 115                   Hindu           $75-100k        47
## 116 Historically Black Prot           $75-100k       131
## 117       Jehovah's Witness           $75-100k        15
## 118                  Jewish           $75-100k        69
## 119           Mainline Prot           $75-100k       939
## 120                  Mormon           $75-100k        85
## 121                  Muslim           $75-100k        16
## 122                Orthodox           $75-100k        38
## 123         Other Christian           $75-100k        18
## 124            Other Faiths           $75-100k        46
## 125   Other World Religions           $75-100k         3
## 126            Unaffiliated           $75-100k       407
## 127                Agnostic          $100-150k       109
## 128                 Atheist          $100-150k        59
## 129                Buddhist          $100-150k        39
## 130                Catholic          $100-150k       792
## 131      Don’t know/refused          $100-150k        17
## 132        Evangelical Prot          $100-150k       723
## 133                   Hindu          $100-150k        48
## 134 Historically Black Prot          $100-150k        81
## 135       Jehovah's Witness          $100-150k        11
## 136                  Jewish          $100-150k        87
## 137           Mainline Prot          $100-150k       753
## 138                  Mormon          $100-150k        49
## 139                  Muslim          $100-150k         8
## 140                Orthodox          $100-150k        42
## 141         Other Christian          $100-150k        14
## 142            Other Faiths          $100-150k        40
## 143   Other World Religions          $100-150k         4
## 144            Unaffiliated          $100-150k       321
## 145                Agnostic              >150k        84
## 146                 Atheist              >150k        74
## 147                Buddhist              >150k        53
## 148                Catholic              >150k       633
## 149      Don’t know/refused              >150k        18
## 150        Evangelical Prot              >150k       414
## 151                   Hindu              >150k        54
## 152 Historically Black Prot              >150k        78
## 153       Jehovah's Witness              >150k         6
## 154                  Jewish              >150k       151
## 155           Mainline Prot              >150k       634
## 156                  Mormon              >150k        42
## 157                  Muslim              >150k         6
## 158                Orthodox              >150k        46
## 159         Other Christian              >150k        12
## 160            Other Faiths              >150k        41
## 161   Other World Religions              >150k         4
## 162            Unaffiliated              >150k       258
## 163                Agnostic Don't know/refused        96
## 164                 Atheist Don't know/refused        76
## 165                Buddhist Don't know/refused        54
## 166                Catholic Don't know/refused      1489
## 167      Don’t know/refused Don't know/refused       116
## 168        Evangelical Prot Don't know/refused      1529
## 169                   Hindu Don't know/refused        37
## 170 Historically Black Prot Don't know/refused       339
## 171       Jehovah's Witness Don't know/refused        37
## 172                  Jewish Don't know/refused       162
## 173           Mainline Prot Don't know/refused      1328
## 174                  Mormon Don't know/refused        69
## 175                  Muslim Don't know/refused        22
## 176                Orthodox Don't know/refused        73
## 177         Other Christian Don't know/refused        18
## 178            Other Faiths Don't know/refused        71
## 179   Other World Religions Don't know/refused         8
## 180            Unaffiliated Don't know/refused       597
```

Let's parse this out. First we see this new operator ` %>% `, which you can think of as the word "then". 
So we start with the dataset `pew`, "then" we gather its columns into two columns, `income` and `frequency`. 
We don't want the `religion` column to be part of this operation, so we "minus" it out, which says, don't do this
`gather` operation on the `religion` column, but use everything else. The `religion` column gets repeated as needed. 

> The ` %>% ` operator can be easily typed in RStudio using the shortcut Ctrl-Shift-M (Cmd-Shift-M on a Mac)

This is now a tidy dataset, since each column is a single variable, each row is a single observation

### Multiple variables in column names


```r
tb <- import('data/tb.csv') %>% as_tibble()
head(tb)
```

```
## # A tibble: 6 x 22
##   iso2   year   m04  m514  m014 m1524 m2534 m3544 m4554 m5564   m65    mu
##   <chr> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
## 1 AD     1989    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
## 2 AD     1990    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
## 3 AD     1991    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
## 4 AD     1992    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
## 5 AD     1993    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
## 6 AD     1994    NA    NA    NA    NA    NA    NA    NA    NA    NA    NA
## # … with 10 more variables: f04 <int>, f514 <int>, f014 <int>,
## #   f1524 <int>, f2534 <int>, f3544 <int>, f4554 <int>, f5564 <int>,
## #   f65 <int>, fu <int>
```

Notice that the column names contain both sex and age group data. First we'll `gather`
the sex/age columns, as before. Note that there are many missing values in this dataset. These
are denoted in R by `NA`.


```r
tb %>% 
  gather(sex_age, n, -iso2, -year, -fu)
```

```
## # A tibble: 109,611 x 5
##    iso2   year    fu sex_age     n
##    <chr> <int> <int> <chr>   <int>
##  1 AD     1989    NA m04        NA
##  2 AD     1990    NA m04        NA
##  3 AD     1991    NA m04        NA
##  4 AD     1992    NA m04        NA
##  5 AD     1993    NA m04        NA
##  6 AD     1994    NA m04        NA
##  7 AD     1996    NA m04        NA
##  8 AD     1997    NA m04        NA
##  9 AD     1998    NA m04        NA
## 10 AD     1999    NA m04        NA
## # … with 109,601 more rows
```

Since there are a lot of missing values here, we can drop them in the above step by adding an option.


```r
tb %>% gather(sex_age, n, -iso2, -year, -fu, na.rm=T)
```

```
## # A tibble: 35,478 x 5
##    iso2   year    fu sex_age     n
##    <chr> <int> <int> <chr>   <int>
##  1 AD     2005     0 m04         0
##  2 AD     2006     0 m04         0
##  3 AD     2008     0 m04         0
##  4 AE     2006    NA m04         0
##  5 AE     2007    NA m04         0
##  6 AE     2008     0 m04         0
##  7 AG     2007    NA m04         0
##  8 AL     2005     0 m04         0
##  9 AL     2006     0 m04         1
## 10 AL     2007     0 m04         0
## # … with 35,468 more rows
```

We can now use the function `separate` to separate the data in the `sex_age` column into sex and age. In this
case we have have the data in a fixed width format (the 1st element is the sex data), so we can use that:


```r
tb %>% 
  gather(sex_age, n, -iso2, -year, -fu, na.rm=T) %>% 
  separate(sex_age, c("sex","age"), sep=1)
```

```
## # A tibble: 35,478 x 6
##    iso2   year    fu sex   age       n
##    <chr> <int> <int> <chr> <chr> <int>
##  1 AD     2005     0 m     04        0
##  2 AD     2006     0 m     04        0
##  3 AD     2008     0 m     04        0
##  4 AE     2006    NA m     04        0
##  5 AE     2007    NA m     04        0
##  6 AE     2008     0 m     04        0
##  7 AG     2007    NA m     04        0
##  8 AL     2005     0 m     04        0
##  9 AL     2006     0 m     04        1
## 10 AL     2007     0 m     04        0
## # … with 35,468 more rows
```

If the data was separated by a symbol, like `_`, we would use `sep = "_"` instead.

### Variables stored in rows and columns


```r
weather <- import('data/weather.csv') %>% as_tibble()
weather
```

```
## # A tibble: 22 x 35
##    id     year month element    d1    d2    d3    d4    d5    d6    d7
##    <chr> <int> <int> <chr>   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
##  1 MX17…  2010     1 tmax       NA  NA    NA      NA  NA      NA    NA
##  2 MX17…  2010     1 tmin       NA  NA    NA      NA  NA      NA    NA
##  3 MX17…  2010     2 tmax       NA  27.3  24.1    NA  NA      NA    NA
##  4 MX17…  2010     2 tmin       NA  14.4  14.4    NA  NA      NA    NA
##  5 MX17…  2010     3 tmax       NA  NA    NA      NA  32.1    NA    NA
##  6 MX17…  2010     3 tmin       NA  NA    NA      NA  14.2    NA    NA
##  7 MX17…  2010     4 tmax       NA  NA    NA      NA  NA      NA    NA
##  8 MX17…  2010     4 tmin       NA  NA    NA      NA  NA      NA    NA
##  9 MX17…  2010     5 tmax       NA  NA    NA      NA  NA      NA    NA
## 10 MX17…  2010     5 tmin       NA  NA    NA      NA  NA      NA    NA
## # … with 12 more rows, and 24 more variables: d8 <dbl>, d9 <lgl>,
## #   d10 <dbl>, d11 <dbl>, d12 <lgl>, d13 <dbl>, d14 <dbl>, d15 <dbl>,
## #   d16 <dbl>, d17 <dbl>, d18 <lgl>, d19 <lgl>, d20 <lgl>, d21 <lgl>,
## #   d22 <lgl>, d23 <dbl>, d24 <lgl>, d25 <dbl>, d26 <dbl>, d27 <dbl>,
## #   d28 <dbl>, d29 <dbl>, d30 <dbl>, d31 <dbl>
```

Here, for each year and month, the data for each day of the month is stored in columns. For each
day, two values are noted -- the max (`tmax`) and min (`tmin`) temperature that day, stored as rows. 

We start by gathering the extra columns as before:


```r
weather %>% 
  gather(day, temp, d1:d31)
```

```
## # A tibble: 682 x 6
##    id       year month element day    temp
##    <chr>   <int> <int> <chr>   <chr> <dbl>
##  1 MX17004  2010     1 tmax    d1       NA
##  2 MX17004  2010     1 tmin    d1       NA
##  3 MX17004  2010     2 tmax    d1       NA
##  4 MX17004  2010     2 tmin    d1       NA
##  5 MX17004  2010     3 tmax    d1       NA
##  6 MX17004  2010     3 tmin    d1       NA
##  7 MX17004  2010     4 tmax    d1       NA
##  8 MX17004  2010     4 tmin    d1       NA
##  9 MX17004  2010     5 tmax    d1       NA
## 10 MX17004  2010     5 tmin    d1       NA
## # … with 672 more rows
```

> Here's a new notation -- `d1:d31`. This means all columns starting at `d1` and ending at `d31`. This notation
is originally from creating sequences of numbers. See what happens if you type `1:30` in the console.

Now, for each date, we have two _rows_ of data. These need to be two _columns_ of data. So we need to do the
reverse operation from `gather`. This is called `spread`. 


```r
weather %>% 
  gather(date, temp, d1:d31) %>% 
  spread(element, temp)
```

```
## # A tibble: 341 x 6
##    id       year month date   tmax  tmin
##    <chr>   <int> <int> <chr> <dbl> <dbl>
##  1 MX17004  2010     1 d1       NA    NA
##  2 MX17004  2010     1 d10      NA    NA
##  3 MX17004  2010     1 d11      NA    NA
##  4 MX17004  2010     1 d12      NA    NA
##  5 MX17004  2010     1 d13      NA    NA
##  6 MX17004  2010     1 d14      NA    NA
##  7 MX17004  2010     1 d15      NA    NA
##  8 MX17004  2010     1 d16      NA    NA
##  9 MX17004  2010     1 d17      NA    NA
## 10 MX17004  2010     1 d18      NA    NA
## # … with 331 more rows
```

We tell `spread` which column should form column names and which should provide the data for the columns. 

## Data cleaning

The weather data set shows that we still need to do a bit more cleaning to this data to make it workable. 
Mainly, we need to fix the `dat` column to make it numeric. Note the odd ordering, where `d1` is followed by `d10`. This 
is an _alphabetical_ ordering rather  than a _numeric_ ordering. We'll now add to our pipeline (sentence) to make this 
happen:


```r
weather %>% 
  gather(date, temp, d1:d31) %>% 
  spread(element, temp) %>% 
  mutate(date = parse_number(date))
```

```
## # A tibble: 341 x 6
##    id       year month  date  tmax  tmin
##    <chr>   <int> <int> <dbl> <dbl> <dbl>
##  1 MX17004  2010     1     1    NA    NA
##  2 MX17004  2010     1    10    NA    NA
##  3 MX17004  2010     1    11    NA    NA
##  4 MX17004  2010     1    12    NA    NA
##  5 MX17004  2010     1    13    NA    NA
##  6 MX17004  2010     1    14    NA    NA
##  7 MX17004  2010     1    15    NA    NA
##  8 MX17004  2010     1    16    NA    NA
##  9 MX17004  2010     1    17    NA    NA
## 10 MX17004  2010     1    18    NA    NA
## # … with 331 more rows
```

Here we introduce another "verb", `mutate`. This function changes a column, either in-place as we did here, 
or by creating a new variable. 

The data is still not quite in the right format, since the date column is in a weird order. We can add
another verb to this pipe to fix that: `arrange`.


```r
weather %>% 
  gather(date, temp, d1:d31) %>% 
  spread(element, temp) %>% 
  mutate(date = parse_number(date)) %>% 
  arrange(date)
```

```
## # A tibble: 341 x 6
##    id       year month  date  tmax  tmin
##    <chr>   <int> <int> <dbl> <dbl> <dbl>
##  1 MX17004  2010     1     1    NA    NA
##  2 MX17004  2010     2     1    NA    NA
##  3 MX17004  2010     3     1    NA    NA
##  4 MX17004  2010     4     1    NA    NA
##  5 MX17004  2010     5     1    NA    NA
##  6 MX17004  2010     6     1    NA    NA
##  7 MX17004  2010     7     1    NA    NA
##  8 MX17004  2010     8     1    NA    NA
##  9 MX17004  2010    10     1    NA    NA
## 10 MX17004  2010    11     1    NA    NA
## # … with 331 more rows
```

Not quite, right? We're not used to seeing all the 1st of the months together, and so forth. We want all the daes for month 1, then all the dates for month two, and so on. This can be done by modifying the `arrange` command, by sorting first by month and then by date (essentially within month).


```r
weather %>% 
  gather(date, temp, d1:d31) %>% 
  spread(element, temp) %>% 
  mutate(date = parse_number(date)) %>% 
  arrange(month, date)
```

```
## # A tibble: 341 x 6
##    id       year month  date  tmax  tmin
##    <chr>   <int> <int> <dbl> <dbl> <dbl>
##  1 MX17004  2010     1     1    NA    NA
##  2 MX17004  2010     1     2    NA    NA
##  3 MX17004  2010     1     3    NA    NA
##  4 MX17004  2010     1     4    NA    NA
##  5 MX17004  2010     1     5    NA    NA
##  6 MX17004  2010     1     6    NA    NA
##  7 MX17004  2010     1     7    NA    NA
##  8 MX17004  2010     1     8    NA    NA
##  9 MX17004  2010     1     9    NA    NA
## 10 MX17004  2010     1    10    NA    NA
## # … with 331 more rows
```

Finally, if we want to save this, we need to assign this final product a name.


```r
weather2 <- weather %>% 
  gather(date, temp, d1:d31) %>% 
  spread(element, temp) %>% 
  mutate(date = parse_number(date)) %>% 
  arrange(month, date)
```

### Exercise {-}

The file `data/mbta.xlsx` contains monthly data on number of commuter trips by different modalities on the MBTA system n Boston. It
is in a messy format. It also has an additional quirk in that it has a title on the first line that 
isn't even data. You can avoid loading that in by using the option `skip=1` (i.e. skip the first line) when you
import. Work through this process to clean this dataset into tidy form. I'll also note that you can "minus" columns by 
position as well as name, so `gather(date, avg_trips, -1, -mode)` is valid to not involve the first column and the `mode` column. 

## Cleaning up data types and values

After you have tidied your data, lets call that tidy dataset `mbta2`. 




```r
mbta2
```

```
## # A tibble: 638 x 5
##      ..1 mode              year  month avg_trips
##    <dbl> <chr>             <chr> <chr> <chr>    
##  1     1 All Modes by Qtr  2007  01    NA       
##  2     2 Boat              2007  01    4        
##  3     3 Bus               2007  01    335.819  
##  4     4 Commuter Rail     2007  01    142.2    
##  5     5 Heavy Rail        2007  01    435.294  
##  6     6 Light Rail        2007  01    227.231  
##  7     7 Pct Chg / Yr      2007  01    0.02     
##  8     8 Private Bus       2007  01    4.772    
##  9     9 RIDE              2007  01    4.9      
## 10    10 Trackless Trolley 2007  01    12.757   
## # … with 628 more rows
```

We see that there's still some issues. If you look at the top of the dataset, you'll see
that year, month and avg_trips are all _character_ variables and not _numeric_ variables. (You can see
this if you converted to a tibble using `as_tibble`. Otherwise, type `str(mbta2)` at the console). Also, there
is this odd column with the name `..1` that is just an index of rows. Lastly, the row marked `TOTAL` is 
not necessary since it's a derived row, and the `All Modes by Qtr` row is missing in many times, and appears inconsistent
with `TOTAL`. 

First, let's deal with the type issue.


> A more advanced version of this operation would be 
```
mbta2 %>% 
  mutate_at(vars(year, month, avg_trips), parse_number)
```

Next we want to get rid of that first column. The verb we'll use here is `select`. 


```r
mbta2 %>% 
  mutate(
    year = parse_number(year),
    month = parse_number(month),
    avg_trips = parse_number(avg_trips)
  ) %>% 
  select(-1) # Get rid of 1st column
```

```
## # A tibble: 638 x 4
##    mode               year month avg_trips
##    <chr>             <dbl> <dbl>     <dbl>
##  1 All Modes by Qtr   2007     1     NA   
##  2 Boat               2007     1      4   
##  3 Bus                2007     1    336.  
##  4 Commuter Rail      2007     1    142.  
##  5 Heavy Rail         2007     1    435.  
##  6 Light Rail         2007     1    227.  
##  7 Pct Chg / Yr       2007     1      0.02
##  8 Private Bus        2007     1      4.77
##  9 RIDE               2007     1      4.9 
## 10 Trackless Trolley  2007     1     12.8 
## # … with 628 more rows
```

Lastly, we want to get rid of rows where mode equals TOTAL or "All Modes by Qtr". Our verb here is `filter`.


```r
mbta3 <- mbta2 %>% 
  mutate(
    year = parse_number(year),
    month = parse_number(month),
    avg_trips = parse_number(avg_trips)
  ) %>% 
  select(-1) %>% 
  filter(mode != 'TOTAL', mode != "All Modes by Qtr")
```

Note that the strings in quotes have to be exact matches to what you want to look for. The `!=` means "not equals". 

We're assigning this to a new variable, mbta3, which is our clean dataset.

> In R, filtering refers to keeping or removing _rows_ that meet some criterion; selecting refers to 
keeping or removing _columns_. The corresponding "verbs" to put into your pipeline are `filter` and `select`.

## Other types of cleaning

There are different functions that you can apply to a dataset for different cleaning purposes. A selection
are given below:

1. `distinct()` keeps the unique (non-duplicate) rows of a dataset. Usage: `dataset %>% distinct()`
1. If you want to keep only rows with complete data, you can invoke `drop_na`. Usage: `dataset %>% drop_na()`. You 
can modify `drop_na` by specifying variables from which you want to drop the missing values. 
1. If you want to convert a value to missing (commonly 99 is used for missing data), then you can use `replace_na` within `mutate` to change to missing values on a column-by-column basis. Usage: `dataset %>% mutate(var1 = na_if(var1, 99))`


