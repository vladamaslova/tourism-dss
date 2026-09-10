Tourism Capacity Planning DSS

A web based decision support system for tourism capacity planning, built in R and Shiny on top of a MariaDB data mart. Developed as an MSc Computer Science dissertation project at Edinburgh Napier University.

The system takes raw hotel booking records, transforms them into a dimensional data mart, and presents aggregated capacity indicators through an interactive dashboard. The design goal was a complete path from data capture to automated analytics, with the analytical work pushed down into the database rather than handled in the application layer.

What it does

The dashboard reports guest nights, the core capacity measure for accommodation planning, with two filters:

Property — select which of the two properties to view
Arrival date range — restrict the reporting window

Aggregation is performed in SQL. The Shiny application issues parameterised queries and renders the returned result set, so response times stay flat as the fact table grows.

Data

The system is populated from the hotel booking demand dataset published by Antonio, Almeida and Nunes (2019), covering two properties over a multi year period.

Source rows	119,390
Rows loaded	119,206
Properties	2

The gap between source and loaded rows is accounted for by records rejected during transformation. Rejections are logged rather than silently dropped, and the counts are verified as part of the evaluation.

Architecture

The data mart follows a star schema:

fact_booking
  ├── dim_property
  └── dim_date

fact_booking holds the measures and foreign keys. dim_property and dim_date carry the descriptive attributes used for filtering and grouping.

The Shiny application connects through a dedicated database account holding SELECT privileges only. The application cannot insert, update, drop, or alter anything. This separates the presentation layer from the load layer and means a fault or injection attempt in the front end cannot damage the underlying data.

Tech stack
Layer	Technology
Front end	R Shiny
Analytics	SQL (aggregation in database)
Storage	MariaDB
ETL	R
Evaluation

The system was evaluated through methods:

Transform tests — verifying that transformation logic produces expected outputs against known inputs
Load verification — row count reconciliation between source, staging, and the loaded fact table
Privilege probes — attempting write operations through the application account to confirm the read only restriction holds
Heuristic review — assessing the interface against established visualisation and dashboard design literature
Scope and limitations.

Running it locally
Install R and the required packages: shiny, DBI, RMariaDB
Create the MariaDB database and run the schema scripts in /sql
Run the ETL scripts to populate the data mart
Create the SELECT only application user and grant it read access
Set your connection details in the config file
Launch with shiny::runApp()
Reference

Antonio, N., de Almeida, A., & Nunes, L. (2019). Hotel booking demand datasets. Data in Brief, 22, 41–49.

Built by Vlada Maslova. MSc Computer Science, Edinburgh Napier University, 2026.
