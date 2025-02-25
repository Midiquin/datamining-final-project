library(wordcloud2)
library(gridExtra)

#Hiphop - Setting up to combine playlists into genre
df1 <- clean_list[[1]]
df2 <- clean_list[[2]]
df3 <- clean_list[[3]]

#Pop - Setting up to combine playlists into genre
df4 <- clean_list[[4]]
df5 <- clean_list[[5]]

#Rock - Setting up to combine playlists into genre
df6 <- clean_list[[6]]
df7 <- clean_list[[7]]
df8 <- clean_list[[8]]

#Metal - Setting up to combine playlists into genre
df9 <- clean_list[[9]]
df10 <- clean_list[[10]]
df11 <- clean_list[[11]]

#Indie - Setting up to combine playlists into genre
df12 <- clean_list[[12]]
df13 <- clean_list[[13]]
df14 <- clean_list[[14]]


#Genres to choose from
Pop_s <- rbind(df4, df5)
Rock_s <- rbind(df6, df7, df8)
Hiphop_s <- rbind(df1, df2, df3)
Indie_s <- rbind(df12, df13, df14)
Metal_s <- rbind(df9, df10, df11)

#Bar plot function - emotions
bar_chart <- function(genre, title){
  
  playlist1_sentiment <- get_sentiment_data(genre)
  
  playlist1_sentiment_c <- subset(playlist1_sentiment, sentiment != "negative" & sentiment !="positive")
  
  ggplot(playlist1_sentiment_c, aes(x=sentiment, y=n, fill=sentiment)) +
    geom_col()+
    ggtitle(title)+
    xlab("Sentiment")+
    ylab("Count")+
    guides(fill = guide_legend(title = "Sentiment \nAnalysis"))+
    theme(plot.title =element_text(hjust = 0.5, vjust = 1 ,face = "bold", size = 25),
          axis.title.x = element_text( size = 16, vjust = -.75),  axis.title.y = element_text( size = 16)
          ,legend.title = element_text(size = 12, face = "bold"), axis.text.x = element_blank())
}

#Bar plot function - positive vs negative
bar_chart_p <- function(genre, title){
  
  playlist1_sentiment <- get_sentiment_data(genre)
  
  playlist1_sentiment_c <- subset(playlist1_sentiment, sentiment == "negative"| sentiment =="positive")
  
  ggplot(playlist1_sentiment_c, aes(x=sentiment, y=n, fill=sentiment)) +
    geom_col()+
    ggtitle(title)+
    xlab("Polarity")+
    ylab("Count")+
    theme(plot.title =element_text(hjust = 0.5, vjust = 1 ,face = "bold", size = 25),
          axis.title.x = element_text( size = 16),  axis.title.y = element_text( size = 16),
          legend.position = "none")
}

#Word cloud function
word_cloud <- function(genre){
  
  get_dat <- get_sentiment_data(genre)
  
  get_dat$sentiment <- NULL
  
  get_dat <- distinct(get_dat)
  
  names(get_dat)[2] <- "freq"
  
  cloud <- wordcloud2(get_dat)
  
  return(cloud)
}



#Random testing of functions
word_cloud(Indie_s)
word_cloud(Hiphop_s)
word_cloud(Pop_s)
word_cloud(Metal_s)
word_cloud(Rock_s)

Indie_sent<- bar_chart(Indie_s, "Indie")
Indie_pol<- bar_chart_p(Indie_s, "Indie")

Hiphop_sent <- bar_chart(Hiphop_s, "Hiphop")
Hiphop_pol <- bar_chart_p(Hiphop_s, "Hiphop")

Pop_sent <-bar_chart(Pop_s, "Pop")
Pop_pol<- bar_chart_p(Pop_s, "Pop")

Metal_sent<-bar_chart(Metal_s, "Metal")
Metal_pol<- bar_chart_p(Metal_s, "Metal")

Rock_sent<-bar_chart(Rock_s, "Rock")
Rock_pol<- bar_chart_p(Rock_s, "Rock")


grid.arrange(Indie_sent,Hiphop_sent, Pop_sent,Metal_sent,Rock_sent, nrow = 2 )

grid.arrange(Indie_pol,Hiphop_pol, Pop_pol,Metal_pol,Rock_pol, nrow = 2 )




