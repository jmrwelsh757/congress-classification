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
devtools::install_github("albertrapp/tidychatmodels")
```

    WARNING: Rtools is required to build R packages, but no version of Rtools compatible with R 4.4.1 was found. (Only the following incompatible version(s) of Rtools were found: 4.0)

    Please download and install Rtools 4.4 from https://cran.r-project.org/bin/windows/Rtools/.

    Using GitHub PAT from the git credential store.

    Skipping install of 'tidychatmodels' from a github remote, the SHA1 (72fb616c) has not changed since last install.
      Use `force = TRUE` to force installation

``` r
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
