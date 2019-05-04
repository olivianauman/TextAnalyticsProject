### Text Analytics Final Project
### Clarisse Chia, Grant Martin, Olivia Nauman, & Hunter Somers

rm(list=ls())

# libraries
suppressPackageStartupMessages(library(tm))
suppressPackageStartupMessages(library(NLP))
suppressPackageStartupMessages(library(RWeka))


#read in dataset & format dataframe
df <- read.csv("yelp_cleveland_restaurants.csv", stringsAsFactors = FALSE)
names(df) <- c("Review", "Stars", "Date", "Useful", "Funny", "Cool", "Total Votes")

############################################################################################################################

#### Assinging Labels ####

#assigning labels based on count of useful votes
#df <- mutate(df, Label = ifelse(df$Useful >= 2, "useful", "not_useful"))
#table(unlist(df$Label))

#assigning labels based on percent of total useful votes
#df <- mutate(df, Label = ifelse(df$Useful/df$`Total Votes` >= 0.5, "useful", "not_useful"))
#table(unlist(df$Label))

#assigning labels based on total votes count
#df <- mutate(df, Label = ifelse(df$`Total Votes` >= 10, "useful", "not_useful"))
#table(unlist(df$Label))

#assigning labels based on total votes count and a percentage of useful votes to total votes
df <- mutate(df, Label = ifelse(df$`Total Votes` >= 5 & df$Useful/df$`Total Votes` >= 0.3, "useful", "not_useful"))
table(unlist(df$Label))

############################################################################################################################

#vector of reviews & ratings
reviews <- df$Review
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


