###############################################################
#                                                             #
#                   Jesus Garcia-Mancilla                     #
#                (2015) - jegama70@gmail.com                  #
#                                                             #
###############################################################

shinyServer(function(input, output) {
  
  main_df <- read.csv("clean_mturk.csv")
  df <- select(main_df, -tweet, -X)
  df <- melt(df, id.vars="n")
  tweets <- select(main_df, n, tweet)
  
  output$plot <- renderPlot({
    
    # filter the data from the tweet
    df_t1 <- df %>%
      filter(n  == input$tweet) %>%
      mutate(pos = cumsum(value) - (0.5 * value))
    df_tweet <- filter(tweets, n  == input$tweet)
    
    # print the plot
    environment<-environment()
    ggplot(df_t1, aes(x=1, y=value, fill=variable)) + 
      geom_bar(stat="identity", color='white', position = "stack") + 
      ggtitle(paste('Tweet:', df_tweet$tweet)) +
      guides(fill=guide_legend(override.aes=list(colour=NA))) +
      coord_flip() + geom_text(aes(label = value, y = pos), size = 10) +
      scale_fill_brewer(name="Clasification", palette = "Pastel2",
                          breaks = df_t1$variable,
                          labels = c("Depressed mood", "Lack of interest", "Worthlessness or Guilt",
                                     "Thoughts of death", "Neutral", "Other")) +
      theme(plot.title = element_text(size=18),
            legend.title = element_text(size=16, face="bold"),
            legend.text = element_text(size=14),
            legend.position="bottom",
            axis.ticks=element_blank(),
            axis.title=element_blank(),
            axis.text.y=element_blank(),
            axis.text.x=element_blank(),
            panel.background = element_rect(fill = "white"))
  }) # End output$plot
  
  
  
  
  output$table <- renderDataTable({
    tweets
  })
  
})