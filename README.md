# Analisando o sentimento de tweets
Neste projeto, coletei tweets pela API do twitter e realizei uma análise exploratória. Para isso utilizei os pacotes httpuv, reshape2, rtweet, stopwords, dplyr, tidyr, tidytext, wordcloud, stringr e textdata.

O objeto de pesquisa do projeto foi o anúncio do atacante Robert Lewandowski pelo FC Barcelona. Usando o pacote rtweet, coletei tweets que mencionassem o nome de Lewandowski ou do Barcelona, a fim de entender melhor o que os usuários do twitter achavam do anúncio do melhor do mundo de 2020. Os tweets foram coletados no dia do anúncio da contratação nas redes sociais do clube catalão.

Para simplificar a pesquisa, optei por excluir os retweets da coleta. Também optei por coletar apenas tweets em inglês, pois dessa forma pude usar o léxico do Bing para análise de sentimento em texto. Esse léxico já tem catalogadas as palavras mais comuns do idioma inglês, com seu devido score (positivo ou negativo), assim como as stopwords (palavras que devem ser ignoradas) mais comuns.

Num primeiro momento, foquei em visualizar quais eram as palavras positivas e negativas mais frequentas através de um wordcloud. O mais interessante dessa etapa foi perceber que existe uma preocupação com as finanças do Barcelona, representado pela palavra "debt" (dívida). Isso ocorre pois recentemente os catalães declararam uma dívida superior à 1 bilhão de Euros, e ainda assim gastaram cerca de 45 milhões de euros na contratação do atacante polonês de 34 anos.

![Rplot2](https://user-images.githubusercontent.com/77032413/180491817-27975322-d3be-4c0b-a33c-a50a9d2ff481.png)

Em seguida, foquei na quantidade de tweets por sentimento, a fim de saber se o sentimento geral da amostra era positivo ou negativo. Para isso fiz uso de um gráfico de pizza. O resultado não me surpreendeu, a maior parte dos tweets representava sentimentos positivos sobre Lewandowski chegando ao Barcelona (sentimento que eu compartilho).

![pizza](https://user-images.githubusercontent.com/77032413/180492772-d30d080d-aaef-4089-8e24-387c80370d6c.png)

Por útlimo, resolvi analisar os setimentos dos tweets por usuário. Com isso, queria averiguar como os usuários se sentiam individualmente sobre o jogador e seu anúncio. Fazer uma análise desse tipo para milhares de usuários diferentes não seria muito prático do ponto de vista visual, então optei por filtrar a amostra para o top50 tweets favoritados na rede. Dessa forma, cheguei a uma resposta mais completa sobre os sentimentos dos usuários através de um scatterplot. O curioso desse resultado foi ver que apesar de no geral os tweets da amostra serem mais positivos, a média do top50 ficou abaixo do esperado.  

![scatter](https://user-images.githubusercontent.com/77032413/180493444-8f795a73-bbae-4676-bf76-4c9e8aacf671.png)

# Conclusão
O objetivo deste projeto era praticar a coleta de tweets usando a API do twitter com a biblioteca rtweet e realizar uma análise exploratória dos dados coletados através das bibliotecas wordcloud, tidyr e stringr. No geral, os resultados estiveram dentro do esperado. Pessoalmente, eu achei a contratação um acontecimento muito empolgante para a temporada do Barcelona. O código completo com minhas anotações está no arquivo script.R!
