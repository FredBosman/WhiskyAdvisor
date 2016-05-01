library(shiny)

Advise <- function(Body, Sweetness, Smoky, Medicinal, Tobacco, Honey, 
                   Spicy, Winey, Nutty, Malty, Fruity, Floral) {
  ## Load data fiel
  WhiskyData <- read.csv("whiskies.txt")
  
  ## create taste profile
  TasteProfile <- c(Body,Sweetness,Smoky,Medicinal,Tobacco,Honey,Spicy,Winey,Nutty,Malty,Fruity,Floral)
  
  ## calculate distance per taste and total distance
  Distance <- abs(WhiskyData[,3:14] - TasteProfile)
  TotalDistance <-  transform(Distance, sum=rowSums(Distance))
  
  ## combine
  WhiskyData2 <- transform(WhiskyData, Distance = TotalDistance$sum)
  
  ## select top 3 order by distance
  WhiskySelection <- head(WhiskyData2[with(WhiskyData2, order(Distance)), ],3)
  
  ## add your profile
  WhiskySelection$Distillery <- as.character(WhiskySelection$Distillery)
  WhiskySelection$Postcode <- as.character(WhiskySelection$Postcode)
  WhiskySelection <- rbind(yours = c(99,"Your Choice", TasteProfile,"",0,0,0),WhiskySelection)
  WhiskySelection$Distillery <- as.factor(WhiskySelection$Distillery)
  WhiskySelection$Postcode <- as.factor(WhiskySelection$Postcode)

  ## output
  WhiskySelection
}

Star.Plot <- function(WhiskySelection) {
  # draw star diagram
  sloc <- stars( WhiskySelection[,3:14], len=0.20,  scale=FALSE, cex = 1.5, draw.segments =TRUE,
                 col.segments = "#E6BE8A",
                 main = "Whisky Profiles", key.labels = colnames(WhiskySelection[,3:14]),
                 labels = as.vector(WhiskySelection$Distillery))      
  # add labels
  smap <- Map(
    function(x,y) stars(
      matrix(1,ncol=12,nrow=2),key.loc = c(x,y), 
      key.labels = colnames(WhiskySelection[,3:14]), add=TRUE, lty=3, cex=0.7, len=0.8
    ),
    sloc$Var1, sloc$Var2
  )
}

shinyServer(
  function(input, output){
    
    observeEvent(input$goButton, {
   
      Selection <- Advise(input$Body,input$Sweetness,input$Smoky,input$Medicinal,
                          input$Tobacco,input$Honey,input$Spicy,input$Winey,
                          input$Nutty,input$Malty,input$Fruity,input$Floral)
  
      output$Whisky1 <- renderPrint({as.character(Selection[2,2])}) 
      output$Distance1 <- renderText({Selection[2,18]})
      output$Whisky2 <- renderPrint({as.character(Selection[3,2])}) 
      output$Distance2 <- renderText({Selection[3,18]}) 
      output$Whisky3 <- renderPrint({as.character(Selection[4,2])}) 
      output$Distance3 <- renderText({Selection[4,18]}) 

      output$StarPlot <- renderPlot({Star.Plot(Selection)},
                                    width = 750, height = 750)
    
    })
  }
)