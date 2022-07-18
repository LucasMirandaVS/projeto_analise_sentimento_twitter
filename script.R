# Setando o diret?rio
setwd("C:/Users/Lucas/Desktop/projeto")

# Parte 1 - Pacotes e autenticação
#####
# Libraries
if (!requireNamespace("httpuv", quietly = TRUE)) {
  install.packages("httpuv")
}
library(rtweet)
library(stopwords) 
library(dplyr) 
library(tidyr) 
library(tidytext) 
library(wordcloud)
library(devtools)
library(tidyverse)      
library(stringr)
library(textdata)

# Info da API
api_Key <- 'XXXXXXXXXXXXXXXX'
api_KeySecret <- 'XXXXXXXXXXXXXXXX'
bearer_Token <- 'XXXXXXXXXXXXXXXX'
client_ID <- 'XXXXXXXXXXXXXXXX'
client_secret <- 'XXXXXXXXXXXXXXXX'

# Setando a conexão(autenticação) via web browser
token <- create_token(
  app = "App1_miranda",
  consumer_key = api_Key,
  consumer_secret = api_KeySecret)
#####

# Parte 2 - Coletando tweets e limoando os dados

tweets_data <- search_tweets('Robert Lewandowski OR Lewandowski OR Barcelona OR Barca', 
                             include_rts = FALSE, lang = 'en', n = 18000)

## Para acessar o mesmo token em sessões futuras
library(rtweet)
get_token()