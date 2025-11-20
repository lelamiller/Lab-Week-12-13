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

all_sim_data <- tibble()
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
      hourly_arrivals <- rep(0,24)

#start a while loop for t, our total time, making sure it is always less than 24
      while(t<24){
        t <- t + rexp(1, rate = lambda_max)
        if (t >=24) break
        
        hour <- floor(t)

      #ADD IN THINNING?

      #storing the arrivals for each hour in a vector of hourly arrivals
       hourly_arrivals[hour+1] <- hourly_arrivals[hour + 1] + 1
      }
      pair_data <- tibble(
        hour = which(hourly_arrivals > 0) - 1,
        arrivals = hourly_arrivals[hourly_arrivals > 0],
        start_station = s,
        end_station = e)

      all_sim_data <- bind_rows(all_sim_data, pair_data)
    }
  }

return(all_sim_data)

}

simulate_one_day(arrival_rates_result)

