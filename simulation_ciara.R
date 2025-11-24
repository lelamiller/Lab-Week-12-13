
library(tidyverse)
arrival_rates_result <- read.csv("~/Desktop/PHP1560/arrival_rates_result.csv")

# find lambda_,max, the maximum arrival rate hour for each pair of stations 

lambda_max <- arrival_rates_result %>%
  group_by(start_station, end_station) %>%
  # find the highest x_hat
  mutate(lambda_max = max(x_hat)) %>%
  # time btwn arrivals
  # arrival time
  current_time = 0 

  while (lambda_max$hour <= 24) {
    ei <- rexp(lambda_max$lambda_max)
    ti <- current_time + ei}  



simulated_day <- # a data frame with columns (1) departure station (2) arrival 
  # station (3) time (hour & minute)
return(simulated_day)