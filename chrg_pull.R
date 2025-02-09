pull_chrg = 
  function(key=NULL, pageSize=10, congress=118){
    url =
      paste0("https://api.govinfo.gov/collections/",
           "CHRG/",
           "2018-01-01T20%3A18%3A10Z?",
           "pageSize=",
           pageSize,
           "&",
           "congress=",
           congress,
           "&",
           "offsetMark=%2A&",
           "api_key=",
           key)
    jsonlite::fromJSON(url)$packages %>% 
      select(packageId, title, 
             packageLink, congress, 
             dateIssued)
  }