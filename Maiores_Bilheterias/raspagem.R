# =======================================================================================
# miR - Raspagem de dados da Web com rvest
# Autor: Mateus Pestana 
# Data: 26/04/2019
# =======================================================================================


# 1º passo: Instalar o Pacman! ==========================================================
install.packages("pacman")


# 2º passo: carregar os pacotes que serão utilizados ====================================
pacman::p_load("tidyverse", "rvest", "janitor")

# URL ===================================================================================
url_filmes <- "https://pt.wikipedia.org/wiki/Lista_de_filmes_de_maior_bilheteria"

# Baixnado a página e extraindo as tabelas ==============================================
pagina_filmes <- read_html(url_filmes)
tabela_filmes <- html_table(pagina_filmes)

# Convertendo a tabela certa em um banco de dados =======================================
datafilmes <- tabela_filmes[[1]]

# Limpando os nomes das variáveis e removendo a última, de links de referência ==========
datafilmes <- datafilmes %>% 
  clean_names() %>% 
  select(-c(6)) 

# Checando o banco ======================================================================
glimpse(datafilmes)

# Convertendo as variáveis ==============================================================
datafilmes$bilheteria_us <- as.numeric(
  as.character(
    str_replace_all( # Essa função, do pacote "stringr" permite a substituição de caracteres
      datafilmes$bilheteria_us, "\\s", "" # o \\s avisa que é um espaço em branco em RegEx
    )
  )
)

datafilmes$distribuidor <- as.factor(
  as.character(
    datafilmes$distribuidor
  )
)

datafilmes$ano <- as.factor(
  as.integer(
    datafilmes$ano
  )
)

# Fazendo um sumário dos dados ==========================================================
summary(datafilmes)

# Retirando a notação científica ========================================================
options(scipen = 999)

# Salvando o objeto como um arquivo .RData ==============================================
save(datafilmes, file = "datafilmes.RData")



