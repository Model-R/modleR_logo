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

red_pal <- c('#ffbaba', '#ff7b7b', '#ff5252', '#ff0000', '#a70000')

ursal <- raster('model/ursal/present/partitions/rf_cont_ursal_1_1.tif')
df <- read.csv('data/ursal.csv')

ursal_df <- as(ursal, "SpatialPixelsDataFrame") %>%
  as.data.frame()
colnames(ursal_df) = c("value", "x", "y")

head(df)

star <- -as.hexmode('2605')

ggplot() +  
  geom_tile(data=ursal_df, aes(x=x, y=y, fill=value), alpha=0.8) + 
  geom_point(data=df, aes(x=decimalLongitude, y=decimalLatitude), 
                fill=NA, color=cores[5], size=3, alpha=0.5, pch=star) +
  scale_fill_gradientn(colours=red_pal) +
  coord_equal() +
  theme_void() 
  #theme(legend.position="bottom")
  # theme(legend.key.width=unit(2, "cm"))


mapa_ursal <- mapa + scale_y_reverse() + scale_x_reverse()

# creating sticker

font_add_google("Roboto Mono", "roboto")

sticker(mapa_ursal, 
        package="modleR", 
        p_size=20, 
        s_x=1, s_y=.75, 
        s_width=1.4, s_height=1.1, 
        p_family="roboto",
        p_color=cores[4],
        h_fill='white',
        h_color=cores[4],
        filename="figs/modleR.png")

