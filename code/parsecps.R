## Script to parse data into a CPS-friendly format

parseCPS <- function(df = NULL, d = NULL) {
  ## Extracting CHD.FUN.139 // Non-CAP Funding
  value <- data.frame(
    dsID = 'brc-health-facilities',
    region = 'WLD',
    indID = 'CHD.HTH.144',
    period = d,
    value = nrow(df),
    is_number = 1,
    source = 'https://docs.google.com/spreadsheets/d/1iR-JFC3CUykIHfw88Plvfoukvww6AZaf-EYYrOn_KYw/edit#gid=1474657653'
  )

  ## Indicator schema:
  # indID
  # name
  # units
  indicator <- data.frame(
    indID = 'CHD.HTH.144',
    name ='Total Number of Ebola Health Facilities',
    units = 'Count'
  )

  ## Dataset schema:
  # dsID
  # last_updated
  # last_scraped
  # name
  dataset <- data.frame(
    dsID = 'brc-health-facilities',
    last_updated = d,
    last_scraped = as.character(Sys.Date()),
    name = 'British Red Cross Health Facilities'
  )

  # Storing output.
  writeTables(indicator, "indicator", "scraperwiki")
  writeTables(dataset, "dataset", "scraperwiki")
  writeTables(value, "value", "scraperwiki")
}