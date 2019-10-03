library(dplyr)
library(modleR)

# download data of Tremarctos ornatus
data <- rgbif::occ_search(scientificName = "Tremarctos ornatus")
df <- data$data %>%
  filter(., !is.na(decimalLatitude) & !is.na(decimalLongitude)) %>%
  .[.$decimalLatitude!=max(.$decimalLatitude),] %>%
  as.data.frame(.[,c(3,4)])

#write.table(df, "data/ursal.csv", col.names = TRUE, row.names = FALSE)

dim(df)
head(df)

# latin america countries
# la <- c("Brazil", "Mexico", "Colombia", "Argentina", "Peru", 
#         "Venezuela", 'Chile', 'Guatemala', 'Ecuador', 'Cuba', 
#         'Bolivia', 'Haiti', 'Dominican Republic', 'Honduras',
#         'Paraguay', 'El Salvador', 'Nicaragua', 'Costa Rica',
#         'Panama', 'Puerto Rico', 'Uruguay', 'Guadeloupe', 'Martinique', 
#         'French Guiana', 'Saint Martin', 'Saint Barthelemy')

cores <- c(rgb(0,0,0, maxColorValue = 255), 
           rgb(28,28,25, maxColorValue = 255),
           rgb(252,234,151, maxColorValue = 255),
           rgb(166,2,2, maxColorValue = 255),
           rgb(255,192,3, maxColorValue = 255)
           
)

red <- rgb(166,2,2, maxColorValue = 255, alpha=50)

plot(example_vars[[1]], legend=FALSE, las=1, col=cores[5])
points(decimalLatitude ~ decimalLongitude, df, col=red, pch=19, cex=1.5)

# run model for ursal

ursal_setup <- setup_sdmdata(species_name = "ursal", 
                             occurrences = df,
                             predictors = example_vars,
                             models_dir = "model", 
                             lon = 'decimalLongitude',
                             lat = 'decimalLatitude', 
                             boot_n = 1,
                             boot_proportion = 0.7, 
                             buffer_type = "mean", 
                             clean_dupl = TRUE,
                             clean_nas = TRUE,
                             clean_uni = TRUE
                              )

ursal_rf <- do_any(species_name= 'ursal', 
                    predictors = example_vars, 
                    sdmdata = ursal_setup, 
                    models_dir = "model", 
                    algo = "rf", 
                    write_png = TRUE)





