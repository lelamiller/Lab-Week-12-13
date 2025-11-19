#' @description calculates the average rate of arrival for bikes
#' @param citibike dataframe with columns X, start_station, end_station, start_time, end_time 
#' @return data frame with the start station, end station, hour and average rate of arrival for each trip across all days. 
#
library(tidyverse)
citibike <- read.csv("/Users/lelamiller/Downloads/sample_bike.csv")

arrival_rates <- function(citibike){
  
  num_days <- length(unique(day(citibike$start_time)))
  
  citibike <- citibike %>%
    mutate(hour = hour(start_time)) %>%
    mutate(day = date(start_time)) %>%
    filter(customer_type != "None") %>%
    group_by(start_station, end_station, hour) %>%
    summarize(n = n()) 
  
  citibike <- citibike %>%
    mutate(x_hat = n / num_days) %>%
    select(start_station, end_station, hour, x_hat)
  
  return(citibike)
}

arrival_rates(citibike)
