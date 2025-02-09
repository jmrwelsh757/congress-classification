# Classifying U.S. Congress with AI
Joseph Welsh

``` r
library(tidyverse)
```

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
    ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
    ✔ purrr     1.0.2     
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
#devtools::install_github("albertrapp/tidychatmodels")
library(tidychatmodels)

source("chrg_pull.R")

dotenv::load_dot_env()
```

    Warning in readLines(file): incomplete final line found on '.env'
    Warning in readLines(file): incomplete final line found on '.env'

``` r
gov_packages =
  pull_chrg(key = Sys.getenv("GOV_APIKEY"),
            pageSize = 3,
            congress= 118)
gov_zips = 
  gov_packages %>% 
  mutate(zips = paste0(str_replace(packageLink, "summary", "zip"),
                       "?api_key=", Sys.getenv("GOV_APIKEY"))) %>% 
  mutate(destfiles = paste0("zips/",packageId,".zip")) %>% 
  select(zips, destfiles, packageId)

#options(timeout=1500)
map2(gov_zips$zips,gov_zips$destfiles,
     function(x,y){download.file(x, y, mode = "wb")})
```

    [[1]]
    [1] 0

    [[2]]
    [1] 0

    [[3]]
    [1] 0

``` r
pdf_df = 
  gov_zips %>%
  mutate(fname = paste0("zips/", gov_zips$packageId,
                        "/pdf/", 
                        gov_zips$packageId, ".pdf")) %>% 
  rowwise() %>% 
  mutate(
    text = list(unzip(destfiles,list = T)$Name)
      ) %>% 
  unnest_longer(col = text) %>% 
  filter(str_detect(text,".pdf")) %>% 
  rowwise() %>% 
  mutate(
    text = list(unzip(destfiles,files = text)),
    pdfText = list(pdftools::pdf_text(text))
      ) %>% 
  unnest_longer(col = pdfText) %>% 
  mutate(pdfText = gsub("\\s+", " ", str_trim(pdfText))) %>% 
  select(packageId, pdfText) %>% 
  aggregate(pdfText ~ packageId, FUN = paste, collapse = "")
```

``` r
create_chat(
  vendor = "openai",
  api_key = Sys.getenv("GPT_APIKEY")
) %>% 
  add_model("gpt-4o-mini")
```

    Chat Engine: openai

    Messages: 0

    Model: gpt-4o-mini
