library(mapview)
mapviewOptions(basemaps = c("Esri.WorldGrayCanvas","Stadia.AlidadeSmoothDark","OpenStreetMap", "Esri.WorldImagery", "OpenTopoMap"))

library(tidyverse)
library(sf)

# https://en.wikipedia.org/wiki/ISO_3166-2:US
admin_to_iso = c(
  "American Samoa"="US-AS",
  "Guam"="US-GU",
  "Northern Mariana Islands"="US-MP",
  "Puerto Rico"="US-PR",
  "United States Minor Outlying Islands"="US-UM",
  "United States Virgin Islands"="US-VI"
)

add_colonies <- function(states_sf) {
  col_sf <- ne_countries(scale = 10, type = "map_units") |>
    filter(
      sovereignt == "United States of America",
      admin != "United States of America"
    ) |>
    mutate(
      admin = replace_values(
        admin,
        "United States Minor Outlying Islands" ~ "USMOI",
        "United States Virgin Islands" ~ "US Virgin Islands",
        "Northern Mariana Islands" ~ "Northern Marianas"
      ),
      iso_3166_2 = replace_values(
        admin,
        "American Samoa" ~ "US-AS",
        "Guam" ~ "US-GU",
        "Northern Marianas" ~ "US-MP",
        "Puerto Rico" ~ "US-PR",
        "USMOI" ~ "US-UM",
        "US Virgin Islands" ~ "US-VI"
      )
    ) |>
    group_by(iso_3166_2) |>
    summarize(
      name = first(admin),
      geometry = st_union(geometry)
    )
  return(bind_rows(states_sf, col_sf))
}