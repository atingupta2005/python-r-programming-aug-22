#Getting Data
#------------
#Built-in Datasets
#~~~~~~~~~~~~~~~~~


data()


data(package = .packages(TRUE))

#Reading Text Files
#~~~~~~~~~~~~~~~~~~


#CSV and Tab Delimited Files
#~~~~~~~~~~~~~~~~~~~~~~~~~~~


library(learningr)
deer_file <- system.file("extdata", "RedDeerEndocranialVolume.dlm", package = "learningr")
deer_data <- read.table(deer_file, header = TRUE, fill = TRUE)
str(deer_data)
head(deer_data)


crab_file <- system.file(
  "extdata",
  "crabtag.csv",
  package = "learningr"
)
(crab_id_block <- read.csv(
  crab_file,
  header = FALSE,
  skip = 3,
  nrow = 2
))
(crab_tag_notebook <- read.csv(
  crab_file,
  header = FALSE,
  skip = 8,
  nrow = 5
))
(crab_lifetime_notebook <- read.csv(
  crab_file,
  header = FALSE,
  skip = 15,
  nrow = 3
))


write.csv(
  crab_lifetime_notebook,
  "crab lifetime data.csv",
  row.names    = FALSE,
  fileEncoding = "utf8"
)


#Reading Excel Files
#^^^^^^^^^^^^^^^^^^^


library(xlsx)

emp_data <- read.xlsx2(
  "empdata.xlsx",
  sheetIndex = 1,
)
head(emp_data)


#Web Data
#~~~~~~~~


#Scraping Web Pages
#~~~~~~~~~~~~~~~~~~


salary_url <- "https://raw.githubusercontent.com/atingupta2005/python-r-programming-aug-22/main/Hands-on/WorkingD/empdata.csv"
salary_data <- read.csv(salary_url)
str(salary_data)

#Accessing Databases
#~~~~~~~~~~~~~~~~~~~
library(DBI)
library(RSQLite)


driver <- dbDriver("SQLite")
db_file <- system.file(
  "extdata",
  "crabtag.sqlite",
  package = "learningr"
)
conn <- dbConnect(driver, db_file)


query <- "SELECT * FROM IdBlock"
(id_block <- dbGetQuery(conn, query))


dbDisconnect(conn)
dbUnloadDriver(driver)


query_crab_tag_db <- function(query)
{
  driver <- dbDriver("SQLite")
  db_file <- system.file(
    "extdata",
    "crabtag.sqlite",
    package = "learningr"
  )
  conn <- dbConnect(driver, db_file)
  on.exit(
    {
      #this code block runs at the end of the function,
      #even if an error is thrown
      dbDisconnect(conn)
      dbUnloadDriver(driver)
    }
  )
  dbGetQuery(conn, query)
}


query_crab_tag_db("SELECT * FROM IdBlock")


