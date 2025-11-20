#' @description simulates an example day
#' @param data data frame with the start station, end station, hour and average rate of arrival for each trip across all days. 
#' @return data frame of a simulated day: origin, destination, hour
#
library(tidyverse)
#read in the arrival rates data
arrival_rates_result <- read.csv("/Users/lelamiller/arrival_rates_result.csv")

simulate_one_day <- function(arrival_rates_result){

#identify the unique pairs of stations
  df_station_pair <- arrival_rates_results %>%
    group_by(start_station, end_station) %>%
    summarize()
  
  starts <- unique(arrival_rates_result$start_station)
  ends <- unique(arrival_rates_result$end_station)
  
  all_trips <- tibble()
#start a for loop for the unique pairs of stations
  for (s in starts) {
    for (e in ends) {
      
      df_station_pair <- arrival_rates_result %>%
        filter(start_station == s,
               end_station == e)
      
      lambda_max <- max(df_station_pair$x_hat)
      
      t <- 0
      out <- tibble()
      
      while(t<24){
        t <- t + rexp(1, rate= lambda_max)
        if (t >=24) break
        
        hour <- floor(t)
        lambda_t <- df_station_pair
      }
      
      
      trips <- simulate_od_pair(df_od)
      
      all_trips <- bind_rows(all_trips, trips)
    }
  }
}


#call that function for every pair of stations



#then 















#Find lambda max- the maximum arrival rate in an hour in a given day
lambda_max_df <- arrival_rates_result %>%
  group_by(start_station, end_station) %>%
  summarize(lambda_max = max(x_hat)) 

lambda_max_vector <- as.vector(lambda_max_df$lambda_max)

for(i in 1:2362){
timeofday = 0 
hour = 1
arrivals <- c()
arrivaln = 0
for(i in 1:2)
while(timeofday < 24){
  for(hour in 1:24){
    if(timeofday < hour){
      arrivaln <- arrivaln + 1
      arrivals[hour] <- arrivaln
      timeofday <- timeofday + rexp(1, lambda_max_vector[i])
    }  
    }
}
}

