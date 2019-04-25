# =======================================================================================
# miR - Raspagem de dados da Web com rvest e XML
# Autor: Mateus Pestana 
# Data: 25/04/2019
# =======================================================================================


# 1º passo: Instalar o Pacman! ==========================================================
install.packages("pacman")


# 2º passo: carregar os pacotes que serão utilizados ====================================
pacman::p_load("tidyverse", "rvest", "janitor", "XML")


# URLs ==================================================================================
url_stats <- "https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_stats_(Generation_VII-present)"
url_type <- "https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number"
url_catchrate <- "https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_catch_rate"


# Base by Stats =========================================================================
pagina_stats <- read_html(url_stats) # Baixa a página
tabela_stats <- html_table(pagina_stats, fill = T) # Converte as tabelas da página em objeto
poketable_stats <- tabela_stats[[2]] # Extrai a tabela número 2 e transforma em um objeto

glimpse(poketable_stats) # Vendo as variáveis, seus respectivos tipos, nomes e primeiros valores

poketable_stats <- poketable_stats  %>% 
  select(-c(2)) %>%  # Removendo a segunda variável
  rename("id" = "#") %>%  # Renomeando # para "id"
  clean_names() # Ajustando os nomes para um mesmo padrão


# Base by Type ==========================================================================
pagina_type <- read_html(url_type) # Baixa a página
tabela_type <- html_table(pagina_type, fill = T) # Converte as tabelas da página em objeto

# Cria novos objetos, com cada tabela, separado por geração, e ajusta os nomes das variáveis
gen1 <- tabela_type[[2]] %>% 
  clean_names()
gen2 <- tabela_type[[3]] %>% 
  clean_names()
gen3 <- tabela_type[[4]] %>% 
  clean_names()
gen4 <- tabela_type[[5]] %>% 
  clean_names()
gen5 <-  tabela_type[[6]] %>% 
  clean_names()
gen6 <- tabela_type[[7]] %>% 
  clean_names()
gen7 <- tabela_type[[8]] %>% 
  clean_names()

# Junta todos os objetos genX para um objeto só: o dataset poketable_type
poketable_type <- bind_rows(gen1, gen2, gen3, gen4, gen5, gen6, gen7)

# Remove as colunas inúteis e renomeia "ndex" para "id"
poketable_type <- poketable_type %>% 
  select(-c(1,3, 7:12)) %>% 
  rename("id" = "ndex")

glimpse(poketable_type) # Dando uma olhada nos dados, percebemos que a variável "id" 
                        # possui o símbolo # em cada um de seus valores

poketable_type$id <- as.numeric(gsub("\\#", "", poketable_type$id)) # Removendo "#" e 
                                                                    # convertendo para numérica


# Juntando as bases pelo mesmo "id"
poketable <- left_join(poketable_stats, poketable_type, by = "id") %>% 
  select(-c("pokemon.y")) # Removendo a variável "pokemon.y"


# Base by Catch Rate ====================================================================
pagina_catchrate <- readLines(url_catchrate) # Baixa a página
tabela_catchrate <- readHTMLTable(pagina_catchrate, header = F) # Extrai as tabelas 
poketable_catchrate <- tabela_catchrate[[1]] # Converte a primeira tabela em objeto/base
poketable_catchrate <- poketable_catchrate[-c(1,2), ] # Remove as variáveis que não interessam

glimpse(poketable_catchrate) # Olhando os dados, percebemos que V1 (que deveria ser "id")
                             # está como fator. Vamos converter!

poketable_catchrate$V1 <- as.numeric(as.character(poketable_catchrate$V1)) # Convertendo

# Agora vamos juntar as bases usando o mesmo padrão de "id", só que "id" em poketable_catchrate
# tem o nome de V1. A solução é a seguinte:
poketable <- left_join(poketable, poketable_catchrate, by = c("id" = "V1")) 

# Removendo as variáveis que não importam e alterando o nome usando tanto o select()
# quando o rename(), permitindo versatilidade do código.
poketable <- poketable %>% 
  select(-c("V2", "V3"), "catchrate" = "V4") %>%
  rename("pokemon" = "pokemon.x")

# Agora, a base!
View(poketable)

## Até a próxima! =) 
