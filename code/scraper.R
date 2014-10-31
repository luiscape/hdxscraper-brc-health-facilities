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
source(paste(onSw(), 'code/download.R', sep=""))  # for downloading data
source(paste0(onSw(), 'code/parsecps.R'))  # for storing in the required format
source(paste0(onSw(), 'code/extractdate.R'))  # for extracting date
source(paste0(onSw(), 'code/sw_status.R'))  # for changing status in SW
source(paste0(onSw(), 'code/write_tables.R'))  # for writing db tables

# Wrapper for scraper
runScraper <- function() {
  # download
  healthData <- downloadData()
  date <- extractDate()
  parsecps(healthData, date)
}

# Changing the status of SW.
tryCatch(runScraper(F),
         error = function(e) {
           cat('Error detected ... sending notification.')
           system('mail -s "BRC Health Facilities failed." luiscape@gmail.com, takavarasha@un.org')
           changeSwStatus(type = "error", message = "Scraper failed.")
{ stop("!!") }
         }
)
# If success:
changeSwStatus(type = 'ok')