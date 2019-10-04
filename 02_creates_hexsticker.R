library(hexSticker)
library(showtext)
library(raster)
library(ggplot2)
library(viridis)  # better colors for everyone
library(ggthemes) # theme_map()

cores <- c(rgb(0,0,0, maxColorValue = 255), 
           rgb(28,28,25, maxColorValue = 255),
           rgb(252,234,151, maxColorValue = 255),
           rgb(166,2,2, maxColorValue = 255),
           rgb(255,192,3, maxColorValue = 255)
           
)

# '#ffbaba', ,

red_pal <- c('#ff7b7b', '#ff5252', '#ff0000', '#a70000', "#A60202")

#red_pal <- c('#D5212E', '#C62121', '#8D0101', '#680101')

ursal <- raster('data/modleR.tif')

df <- read.csv('data/ursal.csv')

ursal_df <- as(ursal, "SpatialPixelsDataFrame") %>%
  as.data.frame()
colnames(ursal_df) = c("value", "x", "y")

head(df)

star <- -as.hexmode('2605')

mapa <- ggplot() +  
  geom_tile(data=ursal_df, aes(x=x, y=y, fill=value), alpha=0.8) + 
  geom_point(data=df[1:70], aes(x=decimalLongitude, y=decimalLatitude), 
             fill=NA, color=cores[5], size=3, alpha=0.5, pch=star) +
  scale_fill_gradientn(colours=red_pal) +
  coord_equal() +
  theme_void() +
  theme(legend.position="none")
# theme(legend.key.width=unit(2, "cm"))

mapa_ursal <- mapa + scale_y_reverse() + scale_x_reverse()

mapa_ursal

# creating sticker
#font_add_google("Ubuntu Condensed", "fonte")
best_font <- 

font_test <- c("Miriam Libre", "Cabin Condensed", "Ubuntu Condensed")

i=1
#for(i in 1:length(font_test)){
  font_add_google(font_test[i], "fonte")
  sticker(mapa_ursal, 
          package="modleR", 
          s_x=1.1, s_y=1, 
          s_width=2.1, s_height=2.1, 
          p_size=30,
          p_y = 1,
          p_family='fonte',
          p_color=cores[4],
          h_fill='white' ,#cores[2], # 
          h_color=cores[4],
          filename=paste0("figs/modleR_", font_test[i], ".png"))
#}
