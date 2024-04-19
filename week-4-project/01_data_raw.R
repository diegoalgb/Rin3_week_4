
# Load packages -----------------------------------------------------------

library(tidyverse)


# Import data -------------------------------------------------------------

survey <- read_csv("https://raw.githubusercontent.com/rfortherestofus/rin3-datasets/main/getting-started-datasets/survey/survey.csv")

glimpse(survey)


# Data wrangling ----------------------------------------------------------

survey$country <- survey$country |> 
  str_trim() |> 
  str_squish() |> 
  str_to_title()

survey$country[str_detect(survey$country, "Us")] <- "United States"
survey$country[str_detect(survey$country, "U.s")] <- "United States"
survey$country[str_detect(survey$country, "United States Of America")] <- "United States"
survey$country[str_detect(survey$country, "America")] <- "United States"
survey$country[str_detect(survey$country, "Uxz")] <- "United States"
survey$country[str_detect(survey$country, "Uniter Statez")] <- "United States"
survey$country[str_detect(survey$country, "Unitef Stated")] <- "United States"
survey$country[str_detect(survey$country, "Uniteed States")] <- "United States"
survey$country[str_detect(survey$country, "Unitedstates")] <- "United States"
survey$country[str_detect(survey$country, "United Y")] <- "United States"
survey$country[str_detect(survey$country, "United Sttes")] <- "United States"
survey$country[str_detect(survey$country, "United Statws")] <- "United States"
survey$country[str_detect(survey$country, "United Status")] <- "United States"
survey$country[str_detect(survey$country, "United Statues")] <- "United States"
survey$country[str_detect(survey$country, "United Stattes")] <- "United States"
survey$country[str_detect(survey$country, "United Statss")] <- "United States"
survey$country[str_detect(survey$country, "United Statew")] <- "United States"

survey |> 
  filter(country == "United States" & annual_salary > 100000)



survey_by_state <- survey |> 
  filter(country == "United States") |> 
  group_by(state) |> 
  summarize(votes = n()) |> 
  ungroup() |> 
  arrange(desc(votes))
View(survey_by_state)


