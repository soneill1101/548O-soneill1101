library(tidyverse)

#> ── Attaching packages ──────────────────────────────────────── tidyverse 1.2.1 ──
#> ✔ ggplot2 3.0.0     ✔ purrr   0.2.5
#> ✔ tibble  1.4.2     ✔ dplyr   0.7.6
#> ✔ tidyr   0.8.1     ✔ stringr 1.3.1
#> ✔ readr   1.1.1     ✔ forcats 0.3.0
#> ── Conflicts ─────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
fship <- read_csv(file.path("data", "The_Fellowship_Of_The_Ring.csv"))
#> Parsed with column specification:
#> cols(
#>   Film = col_character(),
#>   Race = col_character(),
#>   Female = col_integer(),
#>   Male = col_integer()
#> )
ttow <- read_csv(file.path("data", "The_Two_Towers.csv"))
#> Parsed with column specification:
#> cols(
#>   Film = col_character(),
#>   Race = col_character(),
#>   Female = col_integer(),
#>   Male = col_integer()
#> )
rking <- read_csv(file.path("data", "The_Return_Of_The_King.csv")) 
#> Parsed with column specification:
#> cols(
#>   Film = col_character(),
#>   Race = col_character(),
#>   Female = col_integer(),
#>   Male = col_integer()
#> )
rking
#> # A tibble: 3 x 4
#>   Film                   Race   Female  Male
#>   <chr>                  <chr>   <int> <int>
#> 1 The Return Of The King Elf       183   510
#> 2 The Return Of The King Hobbit      2  2673
#> 3 The Return Of The King Man       268  2459

lotr_untidy <- bind_rows(fship, ttow, rking)
str(lotr_untidy)
#> Classes 'tbl_df', 'tbl' and 'data.frame':    9 obs. of  4 variables:
#>  $ Film  : chr  "The Fellowship Of The Ring" "The Fellowship Of The Ring" "The Fellowship Of The Ring" "The Two Towers" ...
#>  $ Race  : chr  "Elf" "Hobbit" "Man" "Elf" ...
#>  $ Female: int  1229 14 0 331 0 401 183 2 268
#>  $ Male  : int  971 3644 1995 513 2463 3589 510 2673 2459
lotr_untidy
#> # A tibble: 9 x 4
#>   Film                       Race   Female  Male
#>   <chr>                      <chr>   <int> <int>
#> 1 The Fellowship Of The Ring Elf      1229   971
#> 2 The Fellowship Of The Ring Hobbit     14  3644
#> 3 The Fellowship Of The Ring Man         0  1995
#> 4 The Two Towers             Elf       331   513
#> 5 The Two Towers             Hobbit      0  2463
#> 6 The Two Towers             Man       401  3589
#> 7 The Return Of The King     Elf       183   510
#> 8 The Return Of The King     Hobbit      2  2673
#> 9 The Return Of The King     Man       268  2459
lotr_tidy <-
  gather(lotr_untidy, key = 'Gender', value = 'Words', Female, Male)
lotr_tidy
#> # A tibble: 18 x 4
#>    Film                       Race   Gender Words
#>    <chr>                      <chr>  <chr>  <int>
#>  1 The Fellowship Of The Ring Elf    Female  1229
#>  2 The Fellowship Of The Ring Hobbit Female    14
#>  3 The Fellowship Of The Ring Man    Female     0
#>  4 The Two Towers             Elf    Female   331
#>  5 The Two Towers             Hobbit Female     0
#>  6 The Two Towers             Man    Female   401
#>  7 The Return Of The King     Elf    Female   183
#>  8 The Return Of The King     Hobbit Female     2
#>  9 The Return Of The King     Man    Female   268
#> 10 The Fellowship Of The Ring Elf    Male     971
#> 11 The Fellowship Of The Ring Hobbit Male    3644
#> 12 The Fellowship Of The Ring Man    Male    1995
#> 13 The Two Towers             Elf    Male     513
#> 14 The Two Towers             Hobbit Male    2463
#> 15 The Two Towers             Man    Male    3589
#> 16 The Return Of The King     Elf    Male     510
#> 17 The Return Of The King     Hobbit Male    2673
#> 18 The Return Of The King     Man    Male    2459
#> lotr_tidy <-
pivot_longer(lotr_untidy, cols=c(Female, Male), names_to = 'Gender', values_to = 'Words')
lotr_tidy <- arrange(lotr_tidy, Gender)
# A tibble: 18 x 4
#>   Film                       Race   Gender Words
#>   <chr>                      <chr>  <chr>  <dbl>
#> 1 The Fellowship Of The Ring Elf    Female  1229
#> 2 The Fellowship Of The Ring Hobbit Female    14
#> 3 The Fellowship Of The Ring Man    Female     0
#> 4 The Two Towers             Elf    Female   331
#> 5 The Two Towers             Hobbit Female     0
#> 6 The Two Towers             Man    Female   401
#> 7 The Return Of The King     Elf    Female   183
#> 8 The Return Of The King     Hobbit Female     2
#> 9 The Return Of The King     Man    Female   268
#> 10 The Fellowship Of The Ring Elf    Male     971
#> 11 The Fellowship Of The Ring Hobbit Male    3644
#> 12 The Fellowship Of The Ring Man    Male    1995
#> 13 The Two Towers             Elf    Male     513
#> 14 The Two Towers             Hobbit Male    2463
#> 15 The Two Towers             Man    Male    3589
#> 16 The Return Of The King     Elf    Male     510
#> 17 The Return Of The King     Hobbit Male    2673
#> 18 The Return Of The King     Man    Male    2459
#> 
lotr_tidy <- arrange(lotr_tidy , Gender)

write_csv(lotr_tidy, file = file.path("data", "lotr_tidy.csv"))
#original code uses 'path' instead of 'file' command--> R told me
#to use 'file instead
## Cmd+Opt+P to run all chunks up til here
lotr_tidy %>% 
  count(Gender, Race, wt = Words)
#> # A tibble: 6 x 3
#>   Gender Race       n
#>   <chr>  <chr>  <int>
#> 1 Female Elf     1743
#> 2 Female Hobbit    16
#> 3 Female Man      669
#> 4 Male   Elf     1994
#> 5 Male   Hobbit  8780
#> 6 Male   Man     8043
## outside the tidyverse:
#aggregate(Words ~ Gender, data = lotr_tidy, FUN = sum)

#combine into all races across each film:
(by_race_film <- lotr_tidy %>% 
    group_by(Film, Race) %>% 
    summarize(Words = sum(Words)))
#BTW: %>% is a "forward pipe operator" that forwards the results of an
#expression into the next function call/expression
#> # A tibble: 9 x 3
#> # Groups:   Film [?]
#>   Film                       Race   Words
#>   <fct>                      <chr>  <int>
#> 1 The Fellowship Of The Ring Elf     2200
#> 2 The Fellowship Of The Ring Hobbit  3658
#> 3 The Fellowship Of The Ring Man     1995
#> 4 The Two Towers             Elf      844
#> 5 The Two Towers             Hobbit  2463
#> 6 The Two Towers             Man     3990
#> 7 The Return Of The King     Elf      693
#> 8 The Return Of The King     Hobbit  2675
#> 9 The Return Of The King     Man     2727
## outside the tidyverse:
#(by_race_film <- aggregate(Words ~ Race * Film, data = lotr_tidy, FUN = sum))

#To put the above data into a bar chart:
p <- ggplot(by_race_film, aes(x = Film, y = Words, fill = Race))
p + geom_bar(stat = "identity", position = "dodge") +
  coord_flip() + guides(fill = guide_legend(reverse = TRUE))

