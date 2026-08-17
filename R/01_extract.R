
library(readr)

read_bookings_raw <- function(path = "data-raw/hotel_bookings.csv") {
  read_csv(
    path,
    na = c("", "NA", "NULL"),
    col_types = cols(
      hotel                          = col_character(),
      is_canceled                    = col_integer(),
      lead_time                      = col_integer(),
      arrival_date_year              = col_integer(),
      arrival_date_month             = col_character(),
      arrival_date_week_number       = col_integer(),
      arrival_date_day_of_month      = col_integer(),
      stays_in_weekend_nights        = col_integer(),
      stays_in_week_nights           = col_integer(),
      adults                         = col_integer(),
      children                       = col_integer(),
      babies                         = col_integer(),
      meal                           = col_character(),
      country                        = col_character(),
      market_segment                 = col_character(),
      distribution_channel           = col_character(),
      is_repeated_guest              = col_integer(),
      previous_cancellations         = col_integer(),
      previous_bookings_not_canceled = col_integer(),
      reserved_room_type             = col_character(),
      assigned_room_type             = col_character(),
      booking_changes                = col_integer(),
      deposit_type                   = col_character(),
      agent                          = col_character(),
      company                        = col_character(),
      days_in_waiting_list           = col_integer(),
      customer_type                  = col_character(),
      adr                            = col_double(),
      required_car_parking_spaces    = col_integer(),
      total_of_special_requests      = col_integer(),
      reservation_status             = col_character(),
      reservation_status_date        = col_date(format = "%Y-%m-%d")
    )
  )
}

