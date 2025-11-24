#' @description simulates an example day of arrivals throughout the day
#' @param arrival_rates_result data frame with the start station, end station, hour and average rate of arrival for each trip across all days. 
#' @return data frame of a simulated day: origin, destination, hour

library(tidyverse)

#read in the arrival rates data
# arrival_rates_result <- read.csv("/Users/lelamiller/arrival_rates_result.csv")
arrival_rates_result <- read.csv("~/Desktop/PHP1560/arrival_rates_result.csv")

#START THE FUNCTION!!!
simulate_one_day <- function(arrival_rates_result){
  
  arrival_rates_result <- arrival_rates_result %>%
    mutate(hour = factor(hour, levels = c(0:23))) %>%
    group_by(start_station, end_station) %>%
    complete(hour, fill = list(x_hat = 0)) 
  
  #identify the unique pairs of stations
  df_station_pair <- arrival_rates_result %>%
    group_by(start_station, end_station) %>%
    summarize()
  
  full_arrivals <- data.frame( hour = vector("numeric"), 
                               time = vector("numeric"), 
                               start_station = vector("character"),
                               end_station = vector("character")
  )
  
  #vectors of the stations that we will loop through 
  #start a for loop for the unique pairs of stations
  for (i in 1:nrow(df_station_pair)) {
    
    #find lambda max for the unique station pair   
    start <- df_station_pair$start_station[i]
    end <- df_station_pair$end_station[i]
    
    lambdas <- arrival_rates_result %>%
      arrange(hour) %>%
      filter(start_station == start,
             end_station == end) %>%
      pull(x_hat) 
    
    lambda_max <- max(lambdas)
    
    
  
    #initialize the time  
    t <- 0
    arrivals <- c()
    hourvector <- c()
    
    #start a while loop for t, our total time, making sure it is always less than 24
    while(t<24){
      t <- t + rexp(1, rate = lambda_max)
      if (t >=24) break
      
      hourvector <- c(hourvector, floor(t))
      
      #ADD IN THINNING?
      
      if(rbinom(1, 1, lambdas[floor(t) + 1]/lambda_max) ==1){
        #storing the arrivals for each hour in a vector of hourly arrivals
        arrivals <- c(arrivals, t)
      }
    }
    
    if (!is.null(arrivals)){
      arrival_df <- data.frame(
        hour = floor(arrivals),
        time = arrivals,
        start_station = start,
        end_station = end)
      
      full_arrivals <- rbind(full_arrivals, arrival_df)

      full_arrivals <- full_arrivals %>%
        arrange(time)
    }
    
  }
  return(full_arrivals)
  
}


#test_data <- data.frame(hour = c(1, 2, 3, 0, 1, 2, 3), 
#                       x_hat = c(1, 2, 0, 2, 3, 1, 2),
#                      start_station = c("A", "A","A", "B", "B", "B", "B"),
#                     end_station = c("B", "B", "B", "A", "A", "A","A")) %>%
# mutate(hour = factor(hour, levels = c(0:3))) %>%
#group_by(start_station, end_station) %>%
#complete(hour, fill = list(x_hat = 0))


#simulate_one_day(arrival_rates_result)