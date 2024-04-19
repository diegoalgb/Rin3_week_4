
# Load packages -----------------------------------------------------------

library(tidyverse)
library(ggthemes)


# Import data -------------------------------------------------------------

artist <- read_csv("https://raw.githubusercontent.com/rfortherestofus/rin3-datasets/main/getting-started-datasets/artists/artists.csv")

glimpse(artist)

View(artist)



# Data wrangling ----------------------------------------------------------


# Find out which nationalities are the most prevalent
artist |>
  count(artist_nationality) |>
  arrange(desc(n))

# Using the top 4 nationalities, get a count of nationalities by gender
artist_count <- artist |>
  select(artist_nationality, artist_gender) |>
  filter(artist_nationality %in% c("American","French","British","German")) |>
  mutate(artist_gender = fct(artist_gender, levels = c("Male", "Female", "N/A"))) |>
  count(artist_nationality, artist_gender, .drop = FALSE)


# Data visualization ------------------------------------------------------

ggplot(data = artist_count,
       mapping = aes(x = fct_infreq(artist_nationality),
                     y = n,
                     fill = artist_gender,
                     label = n)) +
  geom_bar(stat ="identity", position = position_dodge(width = 1)) +
  geom_text(position = position_dodge(width = 1),
            hjust = 0.5,
            vjust = -0.25) +
  labs(title = str_wrap("Most frequent artist nationalities by gender through editions of Janson’s History of Art and Gardner’s Art Through the Ages", 60),
       subtitle = "The most frequent nationalities are American and French",
       caption = "Data from Rin3-practice datasest",
       x = NULL,
       y = "Nationality count",
       fill = NULL) +
  scale_y_continuous(limits = c(0, 1000)) +
  theme_economist_white()


