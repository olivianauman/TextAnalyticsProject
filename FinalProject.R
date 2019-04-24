### Text Analytics Final Project
### Clarisse Chia, Grant Martin, Olivia Nauman, & Hunter Somers

# libraries
suppressPackageStartupMessages(library(tm))
suppressPackageStartupMessages(library(NLP))
suppressPackageStartupMessages(library(RWeka))


# read in dataset & format dataframe
df <- read.csv("yelp_cleveland_restaurants.csv", stringsAsFactors = FALSE)
names(df) <- c("Review", "Stars", "Date", "Useful", "Funny", "Cool", "Total Votes")

#vector of reviews & ratings
review <- df$Review
stars <- df$Stars

#vcorpus of reviews
docs <-VCorpus(VectorSource(reviews))
docs <-tm_map(docs,content_transformer(tolower))
docs <-tm_map(docs, removeNumbers)
docs <-tm_map(docs, removePunctuation)
docs <-tm_map(docs, removeWords,stopwords("english")) #DO WE NEED TO REMOVE OTHERS HERE?
docs <-tm_map(docs, stripWhitespace)
docs <-tm_map(docs, stemDocument)

# create DTM
dtm <-DocumentTermMatrix(docs)


