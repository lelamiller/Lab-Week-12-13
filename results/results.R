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