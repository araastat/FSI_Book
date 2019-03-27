## The `select` function




The `select` function selects variables (columns) from your dataset. We will look 
at some nice selection methods using a dataset of all foreign aid disbursements from 
Department of State between 2004 and 2017. 


```r
library(rio)
dos <- import('data/Department of State.csv') %>% as_tibble()
 names(dos)
```

```
 [1] "Award_Identifier"                                
 [2] "Extending_Organization"                          
 [3] "Extending_Organization_Office"                   
 [4] "Accountable_Organization"                        
 [5] "Accountable_Organization_Office"                 
 [6] "Implementing_Organization"                       
 [7] "Implementing_Organization_Type"                  
 [8] "Implementing_Organization_Country"               
 [9] "Implementing_Organization_DUNS_Number"           
[10] "Award_Title"                                     
[11] "Award_Description"                               
[12] "Award_Status"                                    
[13] "Award_Collaboration_Type"                        
[14] "Award_Total_Estimated_Value"                     
[15] "Award_Interagency_Transfer_Status"               
[16] "Award_Start_Date"                                
[17] "Award_End_Date"                                  
[18] "Recipient_Location"                              
[19] "Award_Transaction_Description"                   
[20] "Award_Transaction_Value"                         
[21] "Award_Transaction_Type"                          
[22] "Award_Transaction_Date"                          
[23] "Award_Transaction_Fiscal_Year"                   
[24] "Award_Transaction_Fiscal_Quarter"                
[25] "Award_Transaction_Aid_Type"                      
[26] "Award_Transaction_Tied_Status"                   
[27] "Award_Transaction_Flow_Type"                     
[28] "Award_Transaction_Finance_Type"                  
[29] "Award_Transaction_DAC_Purpose_Code"              
[30] "Award_Transaction_DAC_Purpose_Code_Name"         
[31] "Award_Transaction_US_Foreign_Assistance_Code"    
[32] "Award_Transaction_US_Foreign_Assistance_Category"
[33] "Award_Transaction_US_Foreign_Assistance_Sector"  
[34] "Treasury_Account_Codes"                          
[35] "Treasury_Account_Title"                          
[36] "Treasury_Account_Start_Fiscal_Year"              
[37] "Treasury_Account_End_Fiscal_Year"                
[38] "Data_Submission_Date"                            
```

There are several groups of variables by name, and `dplyr` provides nice functions
to extract them.


```
# A tibble: 558,878 x 24
   Award_Identifier Award_Title Award_Descripti… Award_Status
   <chr>            <chr>       <chr>            <chr>       
 1 1040240201       ""          Ambassadors-At-… Implementat…
 2 1040240201       ""          Ambassadors-At-… Implementat…
 3 1040240201       ""          Ambassadors-At-… Implementat…
 4 1040240220       ""          Ambassadors-At-… Implementat…
 5 1040240202       ""          Ambassadors-At-… Implementat…
 6 1040240202       ""          Ambassadors-At-… Implementat…
 7 1040240204       ""          Ambassadors-At-… Implementat…
 8 1040240204       ""          Ambassadors-At-… Implementat…
 9 1040240225       ""          Ambassadors-At-… Implementat…
10 1040240225       ""          Ambassadors-At-… Implementat…
# … with 558,868 more rows, and 20 more variables:
#   Award_Collaboration_Type <chr>, Award_Total_Estimated_Value <dbl>,
#   Award_Interagency_Transfer_Status <chr>, Award_Start_Date <chr>,
#   Award_End_Date <chr>, Award_Transaction_Description <chr>,
#   Award_Transaction_Value <dbl>, Award_Transaction_Type <chr>,
#   Award_Transaction_Date <chr>, Award_Transaction_Fiscal_Year <int>,
#   Award_Transaction_Fiscal_Quarter <int>,
#   Award_Transaction_Aid_Type <chr>, Award_Transaction_Tied_Status <chr>,
#   Award_Transaction_Flow_Type <chr>,
#   Award_Transaction_Finance_Type <chr>,
#   Award_Transaction_DAC_Purpose_Code <int>,
#   Award_Transaction_DAC_Purpose_Code_Name <chr>,
#   Award_Transaction_US_Foreign_Assistance_Code <int>,
#   Award_Transaction_US_Foreign_Assistance_Category <chr>,
#   Award_Transaction_US_Foreign_Assistance_Sector <chr>
```

```r
dos %>% select(ends_with("Value"))
```

```
# A tibble: 558,878 x 2
   Award_Total_Estimated_Value Award_Transaction_Value
                         <dbl>                   <dbl>
 1                           0                    194.
 2                           0                    301.
 3                           0                    287.
 4                           0                   2470.
 5                           0                   1031.
 6                           0                   2853.
 7                           0                   3431.
 8                           0                    912.
 9                           0                    525.
10                           0                   1436.
# … with 558,868 more rows
```

```r
dos %>% select(contains("Transaction"))
```

```
# A tibble: 558,878 x 15
   Award_Transacti… Award_Transacti… Award_Transacti… Award_Transacti…
   <chr>                       <dbl> <chr>            <chr>           
 1 ""                           194. Disbursement     2011-11-30 00:0…
 2 ""                           301. Commitment       2011-10-31 00:0…
 3 ""                           287. Disbursement     2011-10-31 00:0…
 4 ""                          2470. Commitment       2011-10-31 00:0…
 5 ""                          1031. Commitment       2011-11-30 00:0…
 6 ""                          2853. Disbursement     2011-11-30 00:0…
 7 ""                          3431. Disbursement     2011-12-31 00:0…
 8 ""                           912. Disbursement     2011-11-30 00:0…
 9 ""                           525. Commitment       2011-12-31 00:0…
10 ""                          1436. Disbursement     2011-12-31 00:0…
# … with 558,868 more rows, and 11 more variables:
#   Award_Transaction_Fiscal_Year <int>,
#   Award_Transaction_Fiscal_Quarter <int>,
#   Award_Transaction_Aid_Type <chr>, Award_Transaction_Tied_Status <chr>,
#   Award_Transaction_Flow_Type <chr>,
#   Award_Transaction_Finance_Type <chr>,
#   Award_Transaction_DAC_Purpose_Code <int>,
#   Award_Transaction_DAC_Purpose_Code_Name <chr>,
#   Award_Transaction_US_Foreign_Assistance_Code <int>,
#   Award_Transaction_US_Foreign_Assistance_Category <chr>,
#   Award_Transaction_US_Foreign_Assistance_Sector <chr>
```

There are several other helper functions that can grab variables based on 
properities of their names. 

- starts_with(): Starts with a prefix.
- ends_with(): Ends with a suffix.
- contains(): Contains a literal string.
- matches(): Matches a regular expression.
- num_range(): Matches a numerical range like x01, x02, x03.
- one_of(): Matches variable names in a character vector.
- everything(): Matches all variables.
- last_col(): Select last variable, possibly with an offset.

We can pipe these too. In the next bit, we are trying to get the variables that 
representing start dates. We are using the `pull` function to grab the data out of the dataset
in the form of an array, just so it's easier to manipulate. 


```r
start_dates <-  dos %>% 
  select(ends_with("Date")) %>% 
  select(contains("Start")) %>% 
  pull(1)
  
head(start_dates)
```

```
[1] "2011-10-05 00:00:00" "2011-10-05 00:00:00" "2011-10-05 00:00:00"
[4] "2011-10-21 00:00:00" "2011-10-03 00:00:00" "2011-10-03 00:00:00"
```


## Dates

__Resource__: [RStudio cheatsheet](https://rawgit.com/rstudio/cheatsheets/master/lubridate.pdf)


Dates are a first-class data type in R, though they are natively somewhat difficult to 
manage. The package `lubridate` added several convenience functions to make this work
much easier.


```r
library(lubridate)
```

```

Attaching package: 'lubridate'
```

```
The following object is masked from 'package:base':

    date
```

```r
start_dates <- as_date(start_dates) %>% head()
start_dates
```

```
[1] "2011-10-05" "2011-10-05" "2011-10-05" "2011-10-21" "2011-10-03"
[6] "2011-10-03"
```

```r
year(start_dates)
```

```
[1] 2011 2011 2011 2011 2011 2011
```

```r
month(start_dates)
```

```
[1] 10 10 10 10 10 10
```

```r
day(start_dates)
```

```
[1]  5  5  5 21  3  3
```

```r
sort(start_dates)
```

```
[1] "2011-10-03" "2011-10-03" "2011-10-05" "2011-10-05" "2011-10-05"
[6] "2011-10-21"
```

```r
quarter(start_dates)
```

```
[1] 4 4 4 4 4 4
```

```r
days(start_dates) - days(as_date('2011-10-01')) # Days from start of fiscal year
```

```
[1] "4d 0H 0M 0S"  "4d 0H 0M 0S"  "4d 0H 0M 0S"  "20d 0H 0M 0S"
[5] "2d 0H 0M 0S"  "2d 0H 0M 0S" 
```
So we see that we can do math with dates to identify intervals of time, in
appropriate units. 

# Joins

We are often in the situation that pieces of data are resident in different tables, 
and we need to put them together for analyses. Usually each table will have some type 
of identifier variable that identifies the unit with which each observation is 
associated. Joins use these identifiers to put datasets together while maintaining
correspondence of the data with the actual units. 

There are 4 primary kinds of joins:

![](img/joins.png)

Let's summarize what can happen with joins:


Type    Rows                    Columns  
------  ----------------------  ---------
inner   same or decrease        increase 
left    same as left dataset    increase 
right   same as right dataset   increase 
full    increase                increase 

We'll play with two simulated datasets looking at staffing and real estate allocation at 
DOS. The question we're asking is, what is the area avaiable per capita in each Bureau. 

```r
staffing_data <- import('data/Staffing_by_Bureau.csv')
real_estate <- import('data/DoS_Real_Estate_Allocation.csv')
```

```r
staffing_data %>% as_tibble()
```

```
# A tibble: 10,000 x 6
   Bureau                      Gender Grade Title    Name      YearsService
   <chr>                       <chr>  <chr> <chr>    <chr>            <int>
 1 Protocol (S/CPR)            female FS1   Manager  Cathy Ca…           13
 2 Administration (A)          male   GS-9  Team Me… Jeffery …           13
 3 Intelligence and Research … male   FS-6  Analyst  Max Green           11
 4 Mission to the United Nati… male   FS-3  Manager  Donald A…            7
 5 Foreign Missions (OFM)      male   FS-6  Team Me… Thomas L…           22
 6 International Narcotics an… male   GS-8  Team Me… Joseph A…           12
 7 Administration (A)          male   GS-12 Analyst  Michael …            6
 8 Intelligence and Research … male   FS-5  Team Me… Jesus Sh…            2
 9 Science & Technology Advis… male   N/A   Manager  Lawrence…           19
10 Administration (A)          female FS-8  Team Me… Jennie C…           17
# … with 9,990 more rows
```

```r
real_estate %>% as_tibble()
```

```
# A tibble: 666 x 4
   Building Bureau               Location  Size
   <chr>    <chr>                   <int> <int>
 1 HST      Administration (A)       4779   640
 2 SA2      Administration (A)       4801  1090
 3 HST      Administration (A)       5109  1040
 4 HST      Administration (A)       3717  1620
 5 SA4      Administration (A)       3940  1390
 6 HST      Administration (A)       3661  1480
 7 HST      Administration (A)       3374  1770
 8 HST      Administration (A)       3387  1940
 9 SA10     African Affairs (AF)     2605   640
10 HST      African Affairs (AF)     3573   720
# … with 656 more rows
```
First we summarize the data by Bureau

```r
staff_summary <- staffing_data %>% 
  group_by(Bureau) %>% 
  tally(name = 'Pop')
realestate_summary <- real_estate %>% 
 group_by(Bureau) %>% summarize(Size = sum(Size))
```

```r
staff_summary %>% head(4)
```

```
# A tibble: 4 x 2
  Bureau                                            Pop
  <chr>                                           <int>
1 Administration (A)                                454
2 African Affairs (AF)                               42
3 Allowances (A/OPR/ALS)                             90
4 Arms Control, Verification and Compliance (AVC)    98
```

```r
realestate_summary %>% head(4)
```

```
# A tibble: 4 x 2
  Bureau                                           Size
  <chr>                                           <int>
1 Administration (A)                              10970
2 African Affairs (AF)                            26750
3 Allowances (A/OPR/ALS)                           3010
4 Arms Control, Verification and Compliance (AVC)  8410
```
Then we join the two datasets together. They will join based on the Bureau variable, 
which is common to both datasets. 


```r
staff_summary %>% 
  inner_join(realestate_summary, by = c("Bureau" = "Bureau"))
```

```
# A tibble: 54 x 3
   Bureau                                             Pop  Size
   <chr>                                            <int> <int>
 1 Administration (A)                                 454 10970
 2 African Affairs (AF)                                42 26750
 3 Allowances (A/OPR/ALS)                              90  3010
 4 Arms Control, Verification and Compliance (AVC)     98  8410
 5 Budget and Planning (BP)                           168  7500
 6 Chief Information Officer (CIO)                    222 11390
 7 Comptroller and Global Financial Services (CGFS)   169 15700
 8 Conflict and Stabilization Operations (CSO)        392 14970
 9 Consular Affairs (CA)                              141 36610
10 Counterterrorism (CT)                              324  9980
# … with 44 more rows
```

Once we have joined the datasets, we can now create a variable that computes the area per capita, and then we sort the rows of the data in order of descending area per capita. 

```r
staff_summary %>% 
  inner_join(realestate_summary, by = c("Bureau" = "Bureau")) %>% 
  mutate(unit_area = Size/Pop) %>% 
  arrange(unit_area)
```

```
# A tibble: 54 x 4
   Bureau                                               Pop  Size unit_area
   <chr>                                              <int> <int>     <dbl>
 1 Global Youth Issues (GYI)                            345  2090      6.06
 2 Policy Planning Staff (S/P)                          240  2420     10.1 
 3 Science & Technology Adviser (STAS)                  305  4240     13.9 
 4 Foreign Missions (OFM)                               311  4420     14.2 
 5 Trafficking in Persons (TIP)                         247  5150     20.9 
 6 Medical Services (MED)                               308  6760     21.9 
 7 Protocol (S/CPR)                                     327  7730     23.6 
 8 Administration (A)                                   454 10970     24.2 
 9 Oceans and International Environmental and Scient…   330  8420     25.5 
10 Energy Resources (ENR)                               369 10890     29.5 
# … with 44 more rows
```

# Data summaries

The `dplyr` package gives us 5 verbs to operate on a single data frame:

- `filter`: filter a dataset by rows
- `select`: select columns of a dataset
- `arrange`: arrange rows of a dataset by values of some variables
- `group_by`: split a dataset by values of some variables, so that we can apply verbs to each split
- `summarize`: compute various summaries from the data

It also gives us verbs for joining 2 data frames:

- `left_join`
- `right_join`
- `inner_join`
- `outer_join`
- `semi_join` : Keep rows of left dataset which correspond to rows in right dataset
- `anti_join` : Keep rows of left dataset which __do not__ correspond to rows in right dataset
- `bind_rows` : Stack two datasets on top of each other, provided they have the same number of columns
- `bind_cols` : Put two datasets side by side, provided they have the same number or rows. 
]



```r
library(tidyverse)
mtcars1 <- mtcars %>% rownames_to_column('cars') %>% as_tibble()
mtcars1
```

```
# A tibble: 32 x 12
   cars     mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
   <chr>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
 1 Mazda…  21       6  160    110  3.9   2.62  16.5     0     1     4     4
 2 Mazda…  21       6  160    110  3.9   2.88  17.0     0     1     4     4
 3 Datsu…  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
 4 Horne…  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
 5 Horne…  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
 6 Valia…  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
 7 Duste…  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
 8 Merc …  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
 9 Merc …  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
10 Merc …  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
# … with 22 more rows
```

We can compute different summaries over the variables in a dataset. 

```r
mtcars1 %>% summarize(mpg = mean(mpg, na.rm=T), disp = mean(disp, na.rm=T), hp = mean(hp, na.rm=T))
```

```
# A tibble: 1 x 3
    mpg  disp    hp
  <dbl> <dbl> <dbl>
1  20.1  231.  147.
```

## Scoped verbs

All the `dplyr` verbs have scoped versions `*_all`, `*_at` and `*_if`.

1. `*_all` : Act on all columns
1.  `*_at`  : Act on specified columns
1.  `*_if`  : Act on columns with specific property

## Factors (categorical variables)

`factor` types of variables are discrete or categorical variables, that only take
a small set of values. Think number of cylinders in a car, race, sex. 
We can covert a variable to a factor using `as.factor`. (There are also 
`as.numeric` and `as.character`). 


```r
dos %>% mutate_at(vars(ends_with("Date")), as_date) %>% 
  summarise_if(is.Date, max)
```

```
# A tibble: 1 x 4
  Award_Start_Date Award_End_Date Award_Transaction_Da… Data_Submission_Da…
  <date>           <date>         <date>                <date>             
1 NA               NA             2017-10-03            2018-02-15         
```

Here, we notice that a couple of the values are `NA`. We would like to add the 
`na.rm=T` option into the mean function. We can do that, as long as we put a `~` before
it. The `.` is a place holder for each variable that will be interrogated here. 


```r
dos %>% mutate_at(vars(ends_with("Date")), as_date) %>% 
  summarize_at(vars(ends_with("Date")), ~max(., na.rm=T))
```

```
# A tibble: 1 x 4
  Award_Start_Date Award_End_Date Award_Transaction_Da… Data_Submission_Da…
  <date>           <date>         <date>                <date>             
1 2018-09-30       2026-08-31     2017-10-03            2018-02-15         
```

```r
mtcars1 <- mtcars1 %>% 
  mutate_at(vars(cyl, vs, am, gear, carb), as.factor)
str(mtcars1)
```

```
Classes 'tbl_df', 'tbl' and 'data.frame':	32 obs. of  12 variables:
 $ cars: chr  "Mazda RX4" "Mazda RX4 Wag" "Datsun 710" "Hornet 4 Drive" ...
 $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
 $ cyl : Factor w/ 3 levels "4","6","8": 2 2 1 2 3 2 3 1 1 2 ...
 $ disp: num  160 160 108 258 360 ...
 $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
 $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
 $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
 $ qsec: num  16.5 17 18.6 19.4 17 ...
 $ vs  : Factor w/ 2 levels "0","1": 1 1 2 2 1 2 1 2 2 2 ...
 $ am  : Factor w/ 2 levels "0","1": 2 2 2 1 1 1 1 1 1 1 ...
 $ gear: Factor w/ 3 levels "3","4","5": 2 2 2 1 1 1 1 2 2 2 ...
 $ carb: Factor w/ 6 levels "1","2","3","4",..: 4 4 1 1 2 1 4 2 2 4 ...
```

```r
mtcars1 %>% summarize_if(is.numeric, mean)
```

```
# A tibble: 1 x 6
    mpg  disp    hp  drat    wt  qsec
  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
1  20.1  231.  147.  3.60  3.22  17.8
```

# Split-apply-combine

![](img/split-apply-combine.png)

Here, we compute summaries (means) by levels of cylinders. 

```r
mtcars1 %>% 
  group_by(cyl) %>% 
  summarize(mpg_mean = mean(mpg))
```

```
# A tibble: 3 x 2
  cyl   mpg_mean
  <fct>    <dbl>
1 4         26.7
2 6         19.7
3 8         15.1
```
We can still use scoped verbs if we want.

```r
mtcars1 %>% 
  group_by(cyl) %>% 
  summarize_if(is.numeric, mean)
```

```
# A tibble: 3 x 7
  cyl     mpg  disp    hp  drat    wt  qsec
  <fct> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
1 4      26.7  105.  82.6  4.07  2.29  19.1
2 6      19.7  183. 122.   3.59  3.12  18.0
3 8      15.1  353. 209.   3.23  4.00  16.8
```
We can also do several summaries in one go. 

```r
mtcars1 %>% 
  group_by(cyl) %>% 
  summarize_if(is.numeric, list('mean' = mean, 'median' = median))
```

```
# A tibble: 3 x 13
  cyl   mpg_mean disp_mean hp_mean drat_mean wt_mean qsec_mean mpg_median
  <fct>    <dbl>     <dbl>   <dbl>     <dbl>   <dbl>     <dbl>      <dbl>
1 4         26.7      105.    82.6      4.07    2.29      19.1       26  
2 6         19.7      183.   122.       3.59    3.12      18.0       19.7
3 8         15.1      353.   209.       3.23    4.00      16.8       15.2
# … with 5 more variables: disp_median <dbl>, hp_median <dbl>,
#   drat_median <dbl>, wt_median <dbl>, qsec_median <dbl>
```

Let's go back to the DOS dataset. We're going to see how much money was given to 
each implementatoin organization over the years. 

```r
dos %>% 
  group_by(Implementing_Organization) %>% 
  summarize(amt = sum(Award_Transaction_Value)) %>% 
  arrange(desc(amt))
```

```
# A tibble: 9,236 x 2
   Implementing_Organization                        amt
   <chr>                                          <dbl>
 1 United Nations High Commission           9548068186 
 2 ""                                       3374123507.
 3 Information Redacted                     3046872292.
 4 Un Relief & Works Agency                 2975220114 
 5 Intl Committee - The Red Cross           2796820000 
 6 S/S-Ex Miscellanous Vendor               2433986355.
 7 International Organization For Migration 1886668868.
 8 P A E                                     961874214.
 9 Pm Miscellaneous  Vendor                  925306561.
10 Un Childrens Fund                         775056737.
# … with 9,226 more rows
```

We can also split by organization type

```r
dos %>% 
  group_by(Implementing_Organization_Type) %>% 
  summarize(amt = sum(Award_Transaction_Value)) %>% 
  arrange(desc(amt))
```

```
# A tibble: 4 x 2
  Implementing_Organization_Type          amt
  <chr>                                 <dbl>
1 ""                             36464252937.
2 Other Public Sector             4522645303.
3 Government                       730826152.
4 Private Sector                   714436474.
```
If we want to look at time trends, we will also need to split by year, in addition to 
the organization. We're using some `lubridate` code to make the years accessible to 
the computer. 


```r
dos_by_year <- dos %>% 
  group_by(Implementing_Organization, year = year(as_date(Award_Start_Date))) %>% 
  summarize(amt = sum(Award_Transaction_Value)) %>% 
  filter(Implementing_Organization != '', !is.na(year)) 
```
We can also look at the overall trends by year. 

```r
dos_by_year %>% 
  group_by(year) %>% 
  summarize(amt = sum(amt))
```

```
# A tibble: 17 x 2
    year           amt
   <dbl>         <dbl>
 1  2002        24162 
 2  2003         4350 
 3  2004      -211515.
 4  2005     24294032.
 5  2006        65101.
 6  2007     30762236.
 7  2008     28449918.
 8  2009    142067481.
 9  2010     11081559.
10  2011   1482727259.
11  2012   7703229189.
12  2013  10598445712.
13  2014   9672512696.
14  2015   6228419232.
15  2016    915449161.
16  2017    860274841.
17  2018      2327908 
```

