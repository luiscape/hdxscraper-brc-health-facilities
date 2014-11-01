## Function to download data from BRC's dataset
downloadData <- function() {
  cat('Downloading file: ')
  # Downloading and processing file
  url = ('http://docs.google.com/spreadsheets/d/1iR-JFC3CUykIHfw88Plvfoukvww6AZaf-EYYrOn_KYw/export?format=csv')
  s = paste0(onSw(), 'data/source/brc-health-facilities-data.csv')
  download.file(url, s, method = 'curl', extra = '-L', quiet = T)
  
  # Reading file
  data <- read.csv(s, skip = 11)
  data <- data[2:nrow(data),]
  
  # Return
  cat(' done.\n')
  return(data)
}