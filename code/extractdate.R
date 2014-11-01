## Extract data from the spreadsheet
extractDate <- function() {
  s = paste(onSw(), 'data/source/brc-health-facilities-data.csv', sep='')
  data <- read.csv(s)
  
  # parsing
  date <- as.character(data[5,1])
  date <- sub('Last full update ', '', date)
  date <- as.Date(date, "%d/%m/%Y")
  
  return(date)
}