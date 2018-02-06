# CDS-to-DB-test

Single test notebook script to move data between the City Datastore, R and Postgres database, including function files for:

- communicating with the api and obtaining relevant tokens for further comms
- uploading a file to the CDS via the api
- viewing a list of available files stored under your user on the CDS
- selecting from these and downloading (locally and also into the R global environment)

plus code to upload a processed df to a Postgres database table, and then SQL query to download same table from PostGres. 

Users will need to create their own csv's for user login details and database connection details to be sourced, as well as optional code/functions for any data processing required after downloading files from the CDS and uploading to PostGres.

See https://github.com/alewisGLA/CDS for source links
