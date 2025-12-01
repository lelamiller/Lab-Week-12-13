fleet_size_200 <- optimize_bike_placement(arrival_rates_result,
                        200,
                        n_days = 4,
                        seed = 123)

write.csv(fleet_size_200, "fleet_size_200.csv", row.names = FALSE)

fleet_size_100 <- optimize_bike_placement(arrival_rates_result,
                        100,
                        n_days = 7,
                        seed = 123)

write.csv(fleet_size_100, "fleet_size_100.csv", row.names = FALSE)

fleet_size_50 <- optimize_bike_placement(arrival_rates_result,
                                          50,
                                          n_days = 5,
                                          seed = 123)

write.csv(fleet_size_50, "fleet_size_50.csv", row.names = FALSE)

library(tidyverse)
library(ggplot2)

one <- ggplot(fleet_size_200, aes(x = factor(station), y = recommended_bikes, 
                           fill = recommended_bikes)) +
  geom_col() +
  theme_minimal() +
  labs(title = "Optimized CitiBike Placement for a Fleet of 200 Bikes",
       x = "Station Number",
       y = "Recommended Number of Bikes", 
       fill = "Recommended Number of Bikes") 

two <- ggplot(fleet_size_100, aes(x = factor(station), y = recommended_bikes, 
                           fill = recommended_bikes)) +
  geom_col() +
  theme_minimal() +
  labs(title = "Optimized CitiBike Placement for a Fleet of 100 Bikes",
       x = "Station Number",
       y = "Recommended Number of Bikes", 
       fill = "Recommended Number of Bikes") 

three <- ggplot(fleet_size_50, aes(x = factor(station), y = recommended_bikes, 
                           fill = recommended_bikes)) +
  geom_col() +
  theme_minimal() +
  labs(title = "Optimized CitiBike Placement for a Fleet of 50 Bikes",
       x = "Station Number",
       y = "Recommended Number of Bikes", 
       fill = "Recommended Number of Bikes") 

ggsave("fleet_size_200.png", plot = one, width = 6, height = 4, dpi = 300)
ggsave("fleet_size_100.png", plot = two, width = 6, height = 4, dpi = 300)
ggsave("fleet_size_50.png", plot = three, width = 6, height = 4, dpi = 300)  