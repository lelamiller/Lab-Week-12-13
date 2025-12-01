test_dataframe_1 <- data.frame(hour = c(1, 2, 3, 0, 1, 2, 3), 
                               x_hat = c(1, 2, 0, 2, 3, 1, 2),
                               start_station = c("A", "A","A", "B", "B", 
                                                 "B", "B"),
                               end_station = c("B", "B", "B", "A", "A", 
                                               "A","A"))
simulate_one_day(test_dataframe_1)

optimize_bike_placement(test_dataframe_1, 40,
                        n_days = 4,
                        seed = 1)

test_dataframe_2 <- data.frame(hour = c(1, 2, 3, 0, 1, 2, 3), 
                               x_hat = c(1, 2, 0, 2, 3, 1, 2),
                               start_station = c("A", "B","C", "B", "A", 
                                                 "B", "C"),
                               end_station = c("C", "A", "B", "A", "A", 
                                               "C","B"))

simulate_one_day(test_dataframe_2)

optimize_bike_placement(test_dataframe_2, 100,
                        n_days = 3,
                        seed = 1)