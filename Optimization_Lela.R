#' @description optimizes bike placement for most riders to have a bike for their desired rides
#' @param arrival_rates_result data frame with the start station, end station, hour and average rate of arrival for each trip across all days. 
#' @param nbikes number of bikes to begin with
#' @param seed for reproducibility
#' @return data frame of a simulated day: origin, destination, hour
library(tidyverse)

arrival_rates_result <- read.csv("/Users/lelamiller/arrival_rates_result.csv")
#arrival_rates_result <- read.csv("~/Desktop/PHP1560/arrival_rates_result.csv")

optimize_bike_placement <- function(arrival_rates_result,
                                    fleet_size,
                                    n_days = 10,
                                    seed = 123) {
  
  set.seed(123)
  
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
     
    # arrange by time so that our bikes move correctly
      sim <- sim %>% arrange(time)
      
    #initialize the bike inventory
      bikes <- allocation
      names(bikes) <- stations 
      
    #create a loop that goes through all trips in the simulated data
    for (i in 1:nrow(sim)) {
      origin <- as.character(sim$start_station[1])
      dest   <- as.character(sim$end_station[1])
      
      #if we have a bike at the origin station, our rider is happy, and therefore the bike moves from a to b
      if(bikes[origin] > 0) {
        bikes[origin] <- bikes[origin] - 1
        bikes[dest] <- bikes[dest] + 1
      } else {
        #if there is no bike available, we have an unhappy rider at the origin, add it to the total unhappy count
        total_unhappy[origin] <- total_unhappy[origin] + 1
      }
    }
 
    }
    return(total_unhappy)
    }
   
  
#now we do a loop to place 5 bikes at a time 
#initialize the bikes remaining to be the total amount of bikes
bikes_remaining <- fleet_size 

  while (bikes_remaining > 0) {
    # who is unhappy with the current allocation
    unhappy <- compute_unhappy(allocation)
    
    # pick station with the maximum unhappy customers
    chosen_station <- names(which.max(unhappy))
    
    # place up to 5 bikes or whatever is left
    add <- min(5, bikes_remaining)
    allocation[chosen_station] <- allocation[chosen_station] + add
    bikes_remaining <- bikes_remaining - add
    allocation[chosen_station] <- allocation[chosen_station] + 5
  }
  

  return(data.frame(
    station = stations,
    recommended_bikes = as.numeric(allocation)
  ))
}

optimize_bike_placement(arrival_rates_result,
                        40,
                        n_days = 4,
                        seed = 1)
