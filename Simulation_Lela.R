#' @description simulates an example day
#' @param data data frame with the start station, end station, hour and average rate of arrival for each trip across all days. 
#' @return data frame of a simulated day: origin, destination, hour
#
library(tidyverse)
arrival_rates_result <- read.csv("/Users/lelamiller/arrival_rates_result.csv")
#function to simulate a day, return a data frame

#Find lambda max- the maximum arrival rate in an hour in a given day
lambda_max <- arrival_rates_result %>%
  group_by(start_station, end_station) %>%
  mutate(lambda_max = max(x_hat)) %>%
  mutate(ei = dexp(rate = lambda_max)) %>%
  mutate(ti = sum(ei))

