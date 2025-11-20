#' @description simulates an example day of arrivals throughout the day
#' @param arrival_rates_result data frame with the start station, end station, hour and average rate of arrival for each trip across all days. 
#' @return data frame of a simulated day: origin, destination, hour

library(tidyverse)

#read in the arrival rates data
arrival_rates_result <- read.csv("/Users/lelamiller/arrival_rates_result.csv")


#START THE FUNCTION!!!
simulate_one_day <- function(arrival_rates_result){

#identify the unique pairs of stations
  df_station_pair <- arrival_rates_result %>%
    group_by(start_station, end_station) %>%
    summarize()

#vectors of the stations that we will loop through 
  starts <- df_station_pair$start_station
  ends <- df_station_pair$end_station
  
  all_trips <- tibble()
  
#start a for loop for the unique pairs of stations
  for (s in starts) {
    for (e in ends) {

#find lambda max for the unique station pair   
      station_pair <- arrival_rates_result %>%
        filter(start_station == s,
               end_station == e)
      
      lambda_max <- max(station_pair$x_hat)

#initialize the time  
      t <- 0
      arrivals <- 0
      simulation_data <- tibble()

#start a while loop for t, our total time, making sure it is always less than 24
      while(t<24){
        t <- t + rexp(1, rate = lambda_max)
        if (t >=24) break
      
        hour <- floor(t)
        arrivals <- arrivals + 1
        
        simulation_data <- (c(hour, arrivals))

      }
      
     
    }
  }
}


