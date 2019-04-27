# =======================================================================================
# miR - Criando um gráfico de dispersão com o ggplot2
# Autor: Mateus Pestana 
# Data: 27/04/2019
# =======================================================================================


# 1º passo: Instalar o Pacman (caso não esteja instalado) ===============================
install.packages("pacman")


# 2º passo: carregar os pacotes que serão utilizados ====================================
pacman::p_load("tidyverse")


# 3º passo: carregar a base salva! ======================================================
load("poketable.RData")


# Olhar as variáveis ====================================================================
glimpse(poketable)

# Gráficos de dispersão mostram a correlação entre duas variáveis contínuas =============
# Escolhi HP (vida) e Attack (Ataque), e vou colorir cada observação por Type (Tipo)
graf_dispersao <- ggplot(data = poketable)+ # Definindo a base e criando um objeto
  geom_point(aes(x = hp,                    # Escolhendo a variável hp como x
                 y = attack,                # Escolhendo a variável attack como y
                 color = type),             # Pintando cada caso pelo respectivo tipo
             show.legend = F)+              # Deletando a legenda
  facet_wrap(~poketable$type, ncol = 3)+    # Criando vários gráficos separados por tipo
  scale_color_manual(values = color18)+     # Definindo uma escala manual de cores a partir do vetor color18
  theme_bw()+                               # Mudando para o tema em preto e branco
  labs(title = "Diagramas de Dispersão",    # Definindo Título, subtítulo, etc
       subtitle = "Correlação entre HP x Attack, por Tipo",
       x = "Ataque",
       y = "Pontos de Vida",
       caption = "Fonte: Bulbapedia")

color18 <- c("#f50026", # Criando o vetor "color18", com informações em hexadecimal das 
             "#00aafb", # cores. Paletas podem ser criadas em: 
             "#dc7600", # http://tools.medialab.sciences-po.fr/iwanthue/
             "#0055db", # Foram escolhidas 18 cores pois são 18 categorias dentro da 
             "#4c7f00", # variável "type". Logo, para que não hajam cores repetidas, 
             "#ff27d8", # é necessário que o número de cores seja igual ao número de 
             "#005623", # categorias.
             "#fd7ce1",
             "#7cba74",
             "#bf007d",
             "#006f5a",
             "#d88ff1",
             "#a98300",
             "#0069b0",
             "#ff8057",
             "#820046",
             "#9b7a4d",
             "#ff848f")

# Filtrando o tipo "Rock" para fazer correlação e direcionando ao objeto "corrock" ======
corrock <- poketable %>% 
  filter(type == "Rock")

cordragon <- poketable %>% # Filtrando o tipo "Dragon" e direcionando ao objeto "cordragon" =
  filter(type == "Dragon")

# Fazendo as correlações! Atenção para a digitação, colocando os bancos certos
cor(corrock$hp, corrock$attack) # Resultado: 0.45
cor(cordragon$hp, cordragon$attack) # Resultado: 0.53

# Salvando o gráfico ====================================================================
ggsave("graf_dispersao.png", graf_dispersao)

