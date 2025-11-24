#' @description optimizes bike placement for most riders to have a bike for their desired rides
#' @param arrival_rates_result data frame with the start station, end station, hour and average rate of arrival for each trip across all days. 
#' @param nbikes number of bikes to begin with
#' @param seed for reproducibility
#' @return data frame of a simulated day: origin, destination, hour
library(tidyverse)

arrival_rates_result <- read.csv("/Users/lelamiller/arrival_rates_result.csv")

optimize_bike_placement <- function(arrival_rates_result,
                                    fleet_size,
                                    n_days = 10,
                                    seed = 123) {
  
  set.seed(seed)
  
  # Get all stations appearing anywhere in dataset
  stations <- sort(unique(c(arrival_rates_result$start_station)))
  
  # Start with 0 bikes everywhere
  allocation <- setNames(rep(0, length(stations)), stations)
  
  # COMPUTE WHETHER A STATION UNHAPPY
  compute_unhappy <- function(allocation) {
    total_unhappy <- setNames(rep(0, length(stations)), stations)
    
    # simulate several days
    for (d in 1:n_days) {
      sim <- simulate_one_day(arrival_rates_result) 
      
      # count arrivals per station
      arrivals <- sim %>%
        group_by(start_station) %>%
        summarize(n_arrivals = n(), .groups = "drop")
      
      # join with stations (to fill in zeros)
      arrivals <- full_join(
        arrivals,
        data.frame(start_station = stations),
        by = "start_station"
      ) %>%
        mutate(n_arrivals = ifelse(is.na(n_arrivals), 0, n_arrivals))
      
      # unhappy = arrivals > bikes currently assigned
      for (s in stations) {
        a <- arrivals$n_arrivals[arrivals$start_station == s]
        b <- allocation[s]
        total_unhappy[s] <- total_unhappy[s] + max(a - b, 0)
      }
    }
    
    return(total_unhappy)
  }
  

  for (i in 1:fleet_size) {
    
    # compute who is most unhappy right now
    unhappy <- compute_unhappy(allocation)
    
    # pick station with the maximum unhappy customers
    chosen_station <- names(which.max(unhappy))
    
    # place ONE bike there
    allocation[chosen_station] <- allocation[chosen_station] + 1
  }
  

  return(data.frame(
    station = stations,
    recommended_bikes = as.numeric(allocation)
  ))
}

optimize_bike_placement(arrival_rates_result,
                        100,
                        n_days = 10,
                        seed = 1)
