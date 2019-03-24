# (PART\*) Using R to access data {-}

# Loading data into R

R can access data files from a wide variety of sources. These include

1. Text files (csv, tsv, fixed-width)
1. Microsoft Excel files
1. Microsoft Access databases
1. SQL-based databases (MySql, Postgresql, SQLite, Amazon Redshift)
1. Enterprise databases (SAP, Oracle)

The R package `rio` can help read and write to many file types that are single files, 
and the package `rodbc` can do the same for the databases. 


<details>
<summary> __Exercise:__ Install the R package `rio` into your R installation</summary>

```r
install.packages("rio", repos = "https://cran.rstudio.com") # Note the quotes
```

```
## 
## The downloaded binary packages are in
## 	/var/folders/5j/5lprmgt930xdpdn014f8st280000gn/T//RtmpoACuN0/downloaded_packages
```
</details>


