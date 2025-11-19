#' @description calculates the average rate of arrival for bikes
#' @param citibike dataframe with columns X, start_station, end_station, start_time, end_time 
#' @return data frame with the start station, end station, hour and average rate of arrival for each trip across all days. 
#
library(tidyverse)

arrival_rates <- function(citibike){
  citibike <- citibike %>%
    mutate(hour = hour(start_time)) %>%
    mutate(day = date(start_time)) %>%
    filter(customer_type != "None") %>%
    group_by(start_station, end_station, hour) %>%
    summarize(x_hat = n()/n_distinct(day)) 
  
  return(citibike)
}

citibike2 <- read.csv("/Users/lelamiller/Downloads/sample_bike.csv")
arrival_rates_result <- arrival_rates(citibike2)
write.csv(arrival_rates_result, "arrival_rates_result.csv", row.names=FALSE)

