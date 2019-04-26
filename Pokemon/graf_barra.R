install.packages("pacman")

pacman::p_load("ggplot2", "gridExtra")

load("poketable.RData")

glimpse(poketable)

por_tipo <- ggplot(poketable, aes())+
  geom_bar(aes(x = poketable$type),
           fill = "gold2",
           color = "black",
           width = 0.75)+
  coord_flip()+
  theme_bw()+
  labs(title = "Frequência de Pokémons",
       subtitle = "Pelo primeiro tipo",
       x = "Tipo do Pokémon",
       y = "",
       caption = "Fonte: Bulbapedia")+
  scale_y_continuous(breaks = c(0, 25, 50, 75, 100, 125))

por_tipo
  
por_tipo2 <- ggplot(poketable, aes())+
  geom_bar(aes(x = poketable$type_2),
           fill = "deepskyblue1",
           color = "black",
           width = 0.75)+
  coord_flip()+
  theme_bw()+
  labs(title = "Frequência de Pokémons",
       subtitle = "Pelo segundo tipo",
       x = "Tipo do Pokémon",
       y = "",
       caption = "Fonte: Bulbapedia")+
  scale_y_continuous(breaks = c(0, 25, 50, 75, 100, 125))

por_tipo2

freq_tipo <- grid.arrange(por_tipo, por_tipo2, ncol = 2)

ggsave("g_barra_pokemon_tipo.png", freq_tipo)

