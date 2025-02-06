# Classifying U.S. Congress with AI
Joseph Welsh

## Quarto

Quarto enables you to weave together content and executable code into a
finished document. To learn more about Quarto see <https://quarto.org>.

## Running Code

When you click the **Render** button a document will be generated that
includes both content and the output of embedded code. You can embed
code like this:

``` r
dotenv::load_dot_env(file = ".env")
```

    Warning in readLines(file): incomplete final line found on '.env'
    Warning in readLines(file): incomplete final line found on '.env'

``` r
#devtools::install_github("albertrapp/tidychatmodels")
library(tidychatmodels)

create_chat(
  vendor = "openai",
  api_key = Sys.getenv("GPT_APIKEY")
)
```

    Chat Engine: openai

    Messages: 0

You can add options to executable code like this

    [1] 4

The `echo: false` option disables the printing of code (only output is
displayed).
