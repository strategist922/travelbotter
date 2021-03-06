library(twitteR)

#gets substring of tweet up to @ symbol
getCity <- function(tweetList, numTweet){
  content <- tweetList[[numTweet]]$getText()
  # finds location of first @ symbol
  at_symbol <- str_locate(content, " @")[1]
  str_sub(content, at_symbol) <- ""
  (content)
}
#gets the ID of the last tweet by travelbotter
get_ID_last_tweet <- function(){
  # Retrieves all tweets with our name in it
  tweets <- searchTwitter("travelbotter")
  # Gets a vector showing TRUE for all tweets that we tweeted out
  ourTweets <- sapply(tweets, function(n) n$getScreenName() == "travelbotter")
  # Returns a list of only the tweets we tweeted out
  ourTweets <- tweets[ourTweets]
  # returns a list of the ids for our tweets
  IDs <- as.numeric(unlist(lapply(ourTweets, function(n) n$id)))
  last_tweet_id <- max(IDs)
  return(last_tweet_id)
}


vectorOfCities <- function(){
  
  last_tweet <- get_ID_last_tweet()
  # gets all the tweets since the last time we tweeted, which will be all
  # tweets of people tweeting at us with a city name

  tweets <- searchTwitteR("travelbotter")
  for(i in 1:length(tweets)){
    if(tweets[[i]]$screenName == "travelbotter"){
      numTweets <- i-1
      break
    }
  }
  if(numTweets == 0){
    return("No new tweets!")
  }
  vector <- vector()
  for (i in 1:numTweets){
    city <- getCity(tweets, i)
    vector[i] <- city
  }
  # return a vector of the cities that people have tweeted at us
  # NOTE: currently only functions with countries, not cities
  return(vector)
}
  
  











                        