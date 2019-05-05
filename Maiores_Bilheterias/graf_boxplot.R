# =======================================================================================
# miR - Gráfico boxplot no R com o banco de filmes
# Autor: Mateus Pestana 
# Data: 05/05/2019
# =======================================================================================


# 1º passo: Instalar o Pacman! ==========================================================
install.packages("pacman")


# 2º passo: carregar os pacotes que serão utilizados ====================================
pacman::p_load("tidyverse")

# 3º passo: carregar o banco ============================================================
load("datafilmes.RData")

# Checando o banco e as variáveis =======================================================
glimpse(datafilmes)

# Verificando os valores únicos dentro da variável "distribuidor"========================
unique(datafilmes$distribuidor)

# Renomenado "Universal Studios" para "Universal Pictures" ==============================
datafilmes$distribuidor <- str_replace(datafilmes$distribuidor, # A variável
                                       "Universal Studios", # O padrão encontrado
                                       "Universal Pictures") # O que eu quero mudar 


# Criando o primeiro boxplot
ggplot(data = datafilmes)+
  geom_boxplot(aes(x = distribuidor, y = bilheteria_us))

# Fazendo o sumário dos dados (valores mínimos, máximos, quartis, média, mediana)
summary(datafilmes$bilheteria_us)

# Removendo a notação científica ========================================================
options(scipen = 999)

# Criando um novo banco "distrib_famosos"
distrib_famosos <- datafilmes %>% 
  filter(distribuidor == "Universal Pictures" |
           distribuidor == "Walt Disney Studios Motion Pictures" |
           distribuidor == "Warner Bros. Pictures")

# Fazendo sumário do novo banco 
summary(distrib_famosos)

# Alterando a variável bilheteria_us, dividindo por 1 bilhão, para facilitar a visualização
distrib_famosos <- distrib_famosos %>% 
  mutate(bilheteria_us = bilheteria_us/1000000000)

# Criando o novo boxplot ================================================================
g_boxplot_filmes <- ggplot(data = distrib_famosos)+
  geom_boxplot(aes(x = distribuidor,
                   y = bilheteria_us,
                   fill = distribuidor),
               show.legend = F, # Remove a legenda
               varwidth = T)+ # Torna a largura das caixas proporcional ao número de obs
  labs(title = "Boxplot das maiores bilheterias, por distribuidor",
       subtitle = "Em bilhões dólares",
       x = "",
       y = "Bilheteria alcançada",
       caption = "Fonte: Wikipedia")+
  scale_y_continuous(breaks = c(0.75, 1.0, 1.25, 1.5, 1.75, 2.0))+
  theme_bw()+
  scale_fill_brewer(palette = "Set1") # Utiliza a paleta "Set1" para preencher as caixas


# Salvando o gráfico! ===================================================================
ggsave("g_boxplot_filmes.png", plot = g_boxplot_filmes)
