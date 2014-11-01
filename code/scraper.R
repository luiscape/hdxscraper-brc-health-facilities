## Scraper for the British Red Cross' datset on
## the location of health facilities on the Ebola
## crisis. 
library(RCurl)

# ScraperWiki deploy function
onSw <- function(a = F, b = 'tool/') {
  if (a == T) return(b)
  else return('')
}

# Loading helper functions
source(paste0(onSw(), 'code/download.R'))  # for downloading data
source(paste0(onSw(), 'code/parsecps.R'))  # for storing in the required format
source(paste0(onSw(), 'code/extractdate.R'))  # for extracting date
source(paste0(onSw(), 'code/sw_status.R'))  # for changing status in SW
source(paste0(onSw(), 'code/write_tables.R'))  # for writing db tables
source(paste0(onSw(), 'code/readtables.R'))  # for reading db tables

# Wrapper for scraper
runScraper <- function() {
  # download
  healthData <- downloadData()
  date <- extractDate()
  parseCPS(healthData, date)
  
  ## updating only the new entries
  # value
  value <- readTable('value', 'scraperwiki')
  value <- value[!duplicated(value$period),]
  writeTables(value, "value", "scraperwiki")
  write.table(value, paste0(onSw(), 'data/value.csv'), row.names = F, col.names = F, sep = ",")
  
  # indicator
  indicator <- readTable('indicator', 'scraperwiki')
  indicator <- indicator[!duplicated(indicator),]
  writeTables(indicator, "indicator", "scraperwiki")
  write.table(indicator, paste0(onSw(), 'data/indicator.csv'), row.names = F, col.names = F, sep = ",")
  
  # dataset
  dataset <- readTable('dataset', 'scraperwiki')
  dataset <- dataset[!duplicated(dataset),]
  writeTables(dataset, "dataset", "scraperwiki")
  write.table(dataset, paste0(onSw(), 'data/dataset.csv'), row.names = F, col.names = F, sep = ",")
}


# Changing the status of SW.
tryCatch(runScraper(),
         error = function(e) {
           cat('Error detected ... sending notification.')
           system('mail -s "BRC Health Facilities failed." luiscape@gmail.com, takavarasha@un.org')
           changeSwStatus(type = "error", message = "Scraper failed.")
{ stop("!!") }
         }
)
# If success:
changeSwStatus(type = 'ok')