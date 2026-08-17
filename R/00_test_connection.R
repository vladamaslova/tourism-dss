library(DBI)
library(RMariaDB)

con <- dbConnect(
  RMariaDB::MariaDB(),
  host     = Sys.getenv("DSS_DB_HOST"),
  port     = as.integer(Sys.getenv("DSS_DB_PORT")),
  dbname   = Sys.getenv("DSS_DB_NAME"),
  user     = Sys.getenv("DSS_DB_USER_APP"),
  password = Sys.getenv("DSS_DB_PASS_APP")
)

print(dbGetQuery(con, "SELECT VERSION() AS mariadb_version, DATABASE() AS db;"))

dbDisconnect(con)