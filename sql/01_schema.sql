DROP TABLE IF EXISTS fact_booking;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_property;

CREATE TABLE dim_property (
  property_id   INT          NOT NULL,
  property_name VARCHAR(50)  NOT NULL,
  PRIMARY KEY (property_id),
  UNIQUE KEY (property_name)
);

CREATE TABLE dim_date (
  date_key     DATE        NOT NULL,
  year         SMALLINT    NOT NULL,
  quarter      TINYINT     NOT NULL,
  month_num    TINYINT     NOT NULL,
  month_name   VARCHAR(12) NOT NULL,
  month_start  DATE        NOT NULL,
  day_of_month TINYINT     NOT NULL,
  iso_week     TINYINT     NOT NULL,
  day_of_week  TINYINT     NOT NULL,
  is_weekend   TINYINT     NOT NULL,
  PRIMARY KEY (date_key),
  KEY (month_start)
);

CREATE TABLE fact_booking (
  booking_sk           BIGINT       NOT NULL AUTO_INCREMENT,
  property_id          INT          NOT NULL,
  arrival_date         DATE         NOT NULL,
  is_canceled          TINYINT      NOT NULL,
  total_nights         SMALLINT     NOT NULL,
  total_guests         SMALLINT     NOT NULL,
  lead_time            SMALLINT     NOT NULL,
  adr                  DECIMAL(10,2) NOT NULL,
  reserved_room_type   VARCHAR(4)   NOT NULL,
  assigned_room_type   VARCHAR(4)   NOT NULL,
  market_segment       VARCHAR(30)  NOT NULL,
  distribution_channel VARCHAR(30)  NOT NULL,
  customer_type        VARCHAR(20)  NOT NULL,
  country              VARCHAR(4)   NULL,
  PRIMARY KEY (booking_sk),
  KEY (property_id),
  KEY (arrival_date),
  CONSTRAINT fk_fact_property FOREIGN KEY (property_id) REFERENCES dim_property (property_id),
  CONSTRAINT fk_fact_date     FOREIGN KEY (arrival_date) REFERENCES dim_date (date_key)
);