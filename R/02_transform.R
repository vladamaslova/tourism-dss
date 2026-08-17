# R/02_transform.R
# Cleaning rules and dimensional model construction.

library(dplyr)
library(lubridate)
library(tibble)

transform_bookings <- function(raw) {
  raw |>
    filter(!is.na(children)) |>
    mutate(
      arrival_month_num = match(arrival_date_month, month.name),
      arrival_date = make_date(
        year  = arrival_date_year,
        month = arrival_month_num,
        day   = arrival_date_day_of_month
      ),
      total_nights  = stays_in_weekend_nights + stays_in_week_nights,
      total_guests  = adults + children + babies,
      property_name = hotel
    ) |>
    filter(total_guests > 0) |>
    select(
      property_name, arrival_date, is_canceled,
      total_nights, total_guests,
      lead_time, adr,
      reserved_room_type, assigned_room_type,
      market_segment, distribution_channel, customer_type, country
    )
}

build_dim_property <- function(bookings) {
  tibble(property_name = sort(unique(bookings$property_name))) |>
    mutate(property_id = row_number()) |>
    select(property_id, property_name)
}

build_dim_date <- function(bookings) {
  tibble(
    date_key = seq(min(bookings$arrival_date), max(bookings$arrival_date), by = "day")
  ) |>
    mutate(
      year         = year(date_key),
      quarter      = quarter(date_key),
      month_num    = month(date_key),
      month_name   = as.character(month(date_key, label = TRUE, abbr = FALSE)),
      month_start  = floor_date(date_key, "month"),
      day_of_month = mday(date_key),
      iso_week     = isoweek(date_key),
      day_of_week  = wday(date_key, week_start = 1),
      is_weekend   = as.integer(wday(date_key, week_start = 1) >= 6)
    )
}

build_fact_booking <- function(bookings, dim_property) {
  bookings |>
    left_join(dim_property, by = "property_name") |>
    select(property_id, arrival_date, is_canceled,
           total_nights, total_guests,
           lead_time, adr,
           reserved_room_type, assigned_room_type,
           market_segment, distribution_channel, customer_type, country)
}