# Setando o diret?rio
setwd("C:/Users/Lucas/Desktop/projeto")

# Parte 1 - Pacotes e autenticação
library(httpuv)
library(reshape2)
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

# Parte 2 - Coletando tweets e limoando os dados
tweets_data <- search_tweets('Robert Lewandowski OR Lewandowski OR Barcelona OR Barca', 
                             include_rts = FALSE, lang = 'en', n = 18000)

# Diminuindo o tamanho do df(filtrando só o que interessa)
tweets_data <- tweets_data[,1:16]
summary(tweets_data)

# Separanado apenas os textos
words_data <- tweets_data %>% 
  select(text)  %>% 
  unnest_tokens(word, text)

words_data %>% count(word, sort = TRUE)

# Filtrando as stop words
words_data <- words_data %>% 
  filter(!word %in% c('https', 't.co', 'he\'s', 'i\'m', 'it\'s'))

words_data2 <- words_data %>%
  anti_join(stop_words) %>%
  count(word, sort = TRUE)

head(words_data2, n = 10)

# Parte 3 - Análise de sentimento usando o léxico do bing
words_data2 %>%
  inner_join(get_sentiments("bing")) %>%
  count(sentiment, sort = TRUE)

# excluindo os xingamentos e fazendo uma wordcloud de palavras soltas
profanity_list <- unique(tolower(lexicon::profanity_alvarez))

words_data %>% 
  filter(!word %in% c('https', 't.co', 'he\'s', 'i\'m', 'it\'s', profanity_list)) %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("red", "blue"),
                   max.words = 30)

# Analise de sentimento de tweets completos
library(sentimentr)
tweet_sentences_data <- sentiment(get_sentences(tweets_data$text)) %>% 
  group_by(element_id) %>% 
  summarize(meanSentiment = mean(sentiment))

head(tweet_sentences_data) # essa gupo apresenta o coeficiente de sentimento de cada tweet, quanto maior o valor, mais positivo o tweet

# Parte 4 -  Dataviz
print(paste0("score do tweet mais negativo: ", min(tweet_sentences_data$meanSentiment)))
print(paste0("score do tweet mais positivo: ", max(tweet_sentences_data$meanSentiment)))
print(paste0("# de tweets negativos: ", sum(tweet_sentences_data$meanSentiment < 0)))
print(paste0("# de tweets neutros: ", sum(tweet_sentences_data$meanSentiment == 0)))
print(paste0("# de tweets positivos: ", sum(tweet_sentences_data$meanSentiment > 0)))

# Visualizando com gráfico de pizza
slices <- c(sum(tweet_sentences_data$meanSentiment < 0), sum(tweet_sentences_data$meanSentiment == 0),
            sum(tweet_sentences_data$meanSentiment > 0))
labels <- c("Tweets Negativos: ", "Tweets Neutros: ", "Tweets positivos: ")
pct <- round(slices/sum(slices)*100)
labels <- paste(labels, pct, "%", sep = "") 
pie(slices, labels = labels, col=c('#004D98', '#EDBB00', '#A50044'), 
    main="Porcentagem dos sentimentos nos tweets")
# Aproximadamente 65% dos tweets coletados sobre o Lewandowski no Barcelona foram positivos

# Analisando os sentimentos dos tweets a nivel de usuário
n_distinct(tweets_data$user_id)

#selecionando os top50 tweets favoritados
user_sentiment <- tweets_data %>% 
  select(user_id, text, favorite_count) %>% 
  arrange(desc(favorite_count)) %>% 
  slice(1:50)

head(user_sentiment)

# Agora agrupando os usuarios e visualizando os sentimentos
out <- sentiment_by(get_sentences(user_sentiment$text), 
                    list(user_sentiment$user_id))
plot(out)
# Curioso ver que a média de sentimento dos tweets do top50 favoritados é mais baixo que o esperado
# No entanto, alguns dos perfis tuitaram diversos tweets positivos também

## Para acessar o mesmo token em sessões futuras
get_token()
