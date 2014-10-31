## Read tables from a db in sw. ##
library(sqldf)

readTable <- function(table_name = NULL, 
                      db = NULL) {
  # sanity check
  if(is.null(table_name) == TRUE) stop("Don't forget to provide a table name.")
  if(is.null(db) == TRUE) stop("Don't forget to provide a data base name.")
  
  # creating db
  db_name <- paste0(db, ".sqlite")
  db <- dbConnect(SQLite(), dbname = db_name)
  
  ## There is a chance of improving the 
  ## writeTables function here.
  ## To implement this method inside the
  ## writeTables function.
  table <- dbReadTable(db, table_name)

  dbDisconnect(db)
  return(table)
}