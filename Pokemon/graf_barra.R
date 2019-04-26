# =======================================================================================
# miR - Criando um gráfico de barras com o ggplot2
# Autor: Mateus Pestana 
# Data: 25/04/2019
# =======================================================================================


# 1º passo: Instalar o Pacman! ==========================================================
install.packages("pacman")


# 2º passo: carregar os pacotes que serão utilizados ====================================
pacman::p_load("ggplot2", "gridExtra")


# 3º passo: carregar a base salva! ======================================================
load("poketable.RData")


# Olhar as variáveis ====================================================================
glimpse(poketable)


# É preciso utilizar uma variável discreta para um gráfico de barras. Temos "type"=======
por_tipo <- ggplot(poketable, aes())+	# Direciona para um objeto e define o banco usado
  geom_bar(aes(x = poketable$type),	# Cria o geom_bar, gráfico de barras e define "x"
           fill = "gold2",		# Preenche as barras na cor "gold2"
           color = "black",		# Pinta o contorno das barras de "black"
           width = 0.75)+		# Define a largura da barra para 75%
  coord_flip()+				# Inverte as coordenadas X e Y
  theme_bw()+				# Coloca o fundo em preto e branco
  labs(title = "Frequência de Pokémons", # Define título, subtítulo, etc
       subtitle = "Pelo primeiro tipo",
       x = "Tipo do Pokémon", 		# Define nome do eixo X
       y = "",				# Apaga o nome do eixo Y (count)
       caption = "Fonte: Bulbapedia")+
  scale_y_continuous(breaks = c(0, 25, 50, 75, 100, 125)) # Coloca os delimitadores no Y


# Executando o gráfico criado! =========================================================
por_tipo
  

# Criando outro gráfico, a partir da variável "type_2" =================================
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


# Executando o último gráfico =========================================================
por_tipo2


# Colocando ambos os gráficos na mesma visualização ===================================
freq_tipo <- grid.arrange(por_tipo, por_tipo2, ncol = 2)

# Salvando os gráficos em um arquivo na pasta de trabalho =============================
ggsave("g_barra_pokemon_tipo.png", freq_tipo)

