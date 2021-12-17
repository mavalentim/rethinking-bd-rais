##Faxina de dados
library(basedosdados)
library(tidyverse)
library(glue)

basedosdados::read_sql("SELECT * 
FROM `basedosdados.br_me_rais.microdados_vinculos` 
LIMIT 1000")


#Tentando separar as bases da RAIS ao invés de puxar uma -------------

#Setando o environment -----------------

basedosdados::set_billing_id("double-voice-305816")

#Criando uma função para isso -------------
read_rais <- function(list){
  
  map(.x = list,
      ~basedosdados::read_sql(glue::glue("SELECT * 
FROM `basedosdados.br_me_rais.microdados_vinculos`
WHERE sigla_uf IN ('{.x}') and ano = 2009")
)
  ) 
}
objeto1 <- read_rais(c("MG", "ES"))


#Comparando tamanho de objetos ----------------------
objeto2 <- basedosdados::read_sql("SELECT * 
FROM `basedosdados.br_me_rais.microdados_vinculos`
WHERE sigla_uf IN ('MG', 'ES') and ano = 2009")

object_size(objeto1) 
object_size(objeto2)

library('pryr')
