library(tm)
library(wordcloud)
filepath <- "/home/ndorphin/Drive/Work/2018VT/18 Fall/STAT 5014 Programming/11_Python/constitution.txt"
text <- readLines(filepath)
docs <- Corpus(VectorSource(text))
inspect(docs)

docs <- tm_map(docs, content_transformer(tolower)) # Convert the text to lower case
docs <- tm_map(docs, removeNumbers) # Remove numbers
docs <- tm_map(docs, removeWords, stopwords("english")) # Remove english common stopwords
docs <- tm_map(docs, removePunctuation) # Remove punctuations
docs <- tm_map(docs, stripWhitespace) # Eliminate extra white spaces

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

set.seed(2456)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
