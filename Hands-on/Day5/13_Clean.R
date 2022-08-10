#Cleaning And Transforming
#-------------------------
#Cleaning Strings
#~~~~~~~~~~~~~~~~


yn_to_logical <- function(x)
{
  y <- rep.int(NA, length(x))
  y[x == "Y"] <- TRUE
  y[x == "N"] <- FALSE
  y
}

alpe_d_huez

alpe_d_huez$DrugUse

alpe_d_huez$DrugUse <- yn_to_logical(alpe_d_huez$DrugUse)

alpe_d_huez$DrugUse

data(english_monarchs, package = "learningr")

head(english_monarchs)


library(stringr)
multiple_kingdoms <- str_detect(english_monarchs$domain, fixed(","))

multiple_kingdoms

english_monarchs[multiple_kingdoms, c("name", "domain")]


multiple_rulers <- str_detect(english_monarchs$name, ",|and")
english_monarchs$name[multiple_rulers & !is.na(multiple_rulers)]


individual_rulers <- str_split(english_monarchs$name, ", | and ")

head(individual_rulers[sapply(individual_rulers, length) > 1])


th <- c("th", "ð", "þ")

gender <- c(
  "MALE", "Male", "male", "M", "FEMALE",
  "Female", "female", "f", NA
)

(clean_gender <- str_replace(
  gender,
  "male",
  "Male"
)
)

(clean_gender <- str_replace(
  clean_gender,
  "female",
  "Female"
))


#Manipulating Data Frames
#~~~~~~~~~~~~~~~~~~~~~~~~


#Adding and Replacing Columns
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^


(english_monarchs$length.of.reign.years <-
  english_monarchs$end.of.reign - english_monarchs$start.of.reign)


english_monarchs$length.of.reign.years <- with(
  english_monarchs,
  end.of.reign - start.of.reign
)

english_monarchs <- within(
  english_monarchs,
  {
    length.of.reign.years <- end.of.reign - start.of.reign
  }
)

english_monarchs$length.of.reign.years

english_monarchs <- within(
  english_monarchs,
  {
    length.of.reign.years <- end.of.reign - start.of.reign
    reign.was.more.than.30.years <- length.of.reign.years > 30
  }
)

english_monarchs$reign.was.more.than.30.years

#Using SQL
#^^^^^^^^^


install.packages("sqldf")


library(sqldf)
subset(
  deer_endocranial_volume,
  VolCT > 400 | VolCT2 > 400,
  c(VolCT, VolCT2)
)
query <-
  "SELECT
      VolCT,
      VolCT2
    FROM
      deer_endocranial_volume
    WHERE
      VolCT > 400 OR
      VolCT2 > 400"
sqldf(query)


#Sorting
#~~~~~~~


x <- c(2, 32, 4, 16, 8)
sort(x)
sort(x, decreasing = TRUE)


sort(c("I", "shot", "the", "city", "sheriff"))


order(x)
x[order(x)]
identical(sort(x), x[order(x)])


#Functional Programming
#~~~~~~~~~~~~~~~~~~~~~~


ct2 <- deer_endocranial_volume$VolCT2  #for convenience of typing

ct2

isnt.na <- Negate(is.na)
isnt.na(ct2)

Filter(isnt.na, ct2)


Position(isnt.na, ct2)


Find(isnt.na, ct2)


get_volume <- function(ct, bead, lwh, finarelli, ct2, bead2, lwh2)
{
  #If there is a second measurement, take the average
  if(!is.na(ct2))
  {
    ct <- (ct + ct2) / 2
    bead <- (bead + bead2) / 2
    lwh <- (lwh + lwh2) / 2
  }
  #Divide lwh by 4 to bring it in line with other measurements
  c(ct = ct, bead = bead, lwh.4 = lwh / 4, finarelli = finarelli)
}


measurements_by_deer <- with(
  deer_endocranial_volume,
  Map(
    get_volume,
    VolCT,
    VolBead,
    VolLWH,
    VolFinarelli,
    VolCT2,
    VolBead2,
    VolLWH2
  )
)
head(measurements_by_deer)

