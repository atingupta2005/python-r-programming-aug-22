#Dates and Times
#---------------
#Date and Time Classes
#~~~~~~~~~~~~~~~~~~~~~


#POSIX dates and times
#^^^^^^^^^^^^^^^^^^^^^


(now_ct <- Sys.time())


class(now_ct)


unclass(now_ct)


(now_lt <- as.POSIXlt(now_ct))
class(now_lt)
unclass(now_lt)


now_lt$sec

now_lt$min

#The Date Class
#^^^^^^^^^^^^^^


(now_date <- as.Date(now_ct))
class(now_date)
unclass(now_date)


#Other Date Classes
#^^^^^^^^^^^^^^^^^^


#Conversion To and From Strings
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#Parsing Dates
#^^^^^^^^^^^^^


moon_landings_str <- c(
  "20:17:40 20/07/1969",
  "06:54:35 19/11/1969",
  "09:18:11 05/02/1971",
  "22:16:29 30/07/1971",
  "02:23:35 21/04/1972",
  "19:54:57 11/12/1972"
)
(moon_landings_lt <- strptime(
  moon_landings_str,
  "%H:%M:%S %d/%m/%Y",
  tz = "UTC"
))


#Formatting Dates
#^^^^^^^^^^^^^^^^


strftime(now_ct, "It's %I:%M%p on %A %d %B, %Y.")


#Time Zones
#~~~~~~~~~~


strftime(now_ct, tz = "America/Los_Angeles")
strftime(now_ct, tz = "Africa/Brazzaville")
strftime(now_ct, tz = "Asia/Kolkata")
strftime(now_ct, tz = "Australia/Adelaide")


strftime(now_ct, tz = "EST")       #Canadian eastern standard time
strftime(now_ct, tz = "PST8PDT")   #Pacific standard time w/ daylight saving


strftime(now_ct, tz = "Asia/Tokyo")
strftime(now_lt, tz = "Asia/Tokyo")             #no zone change!
strftime(as.POSIXct(now_lt), tz = "Asia/Tokyo")


#Arithmetic With Dates and Times
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


now_ct + 86400 #Tomorrow.  I wonder what the world will be like!
now_lt + 86400 #Same behaviour for POSIXlt
now_date + 1   #Date arithmetic is in days.


the_start_of_time <-    #according to POSIX
  as.Date("1970-01-01")
the_end_of_time <-      #according to Mayan conspiracy theorists
  as.Date("2012-12-21")
(all_time <- the_end_of_time - the_start_of_time)


class(all_time)
unclass(all_time)


difftime(the_end_of_time, the_start_of_time, units = "secs")
difftime(the_end_of_time, the_start_of_time, units = "weeks")


seq(the_start_of_time, the_end_of_time, by = "1 year")
seq(the_start_of_time, the_end_of_time, by = "500 days") #of Summer


#Lubridate
#~~~~~~~~~


library(lubridate)
john_harrison_birth_date <- c(
  "1693-03 24",
  "1693/03\\24",
  "Tuesday+1693.03*24"
)
ymd(john_harrison_birth_date)  #All the same


(duration_one_to_ten_years <- dyears(1:10))

today() + duration_one_to_ten_years


a_year <- dyears(1)    #exactly 60*60*24*365 seconds

start_date <- ymd("2016-02-28")

with_tz(now_lt, tz = "America/Los_Angeles")
with_tz(now_lt, tz = "Africa/Brazzaville")
with_tz(now_lt, tz = "Asia/Kolkata")
with_tz(now_lt, tz = "Australia/Adelaide")


floor_date(today(), "year")
ceiling_date(today(), "year")

