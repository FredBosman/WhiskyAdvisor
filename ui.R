library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Whisky Advisor"),
  
  sidebarPanel(
    h3("What should your whisky taste like?"),
    h4("0 = a little, 4 = a lot"),
    
    sliderInput("Body","Body", min=0, max=4, value=2, step=1),
    sliderInput("Sweetness","Sweetness", min=0, max=4, value=2, step=1),
    sliderInput("Smoky","Smoky", min=0, max=4, value=2, step=1),
    sliderInput("Medicinal","Medicinal", min=0, max=4, value=2, step=1),
    sliderInput("Tobacco","Tobacco", min=0, max=4, value=2, step=1),
    sliderInput("Honey","Honey", min=0, max=4, value=2, step=1),
    sliderInput("Spicy","Spicy", min=0, max=4, value=2, step=1),
    sliderInput("Winey","Winey", min=0, max=4, value=2, step=1),
    sliderInput("Nutty","Nutty", min=0, max=4, value=2, step=1),
    sliderInput("Malty","Malty", min=0, max=4, value=2, step=1),
    sliderInput("Fruity","Fruity", min=0, max=4, value=2, step=1),
    sliderInput("Floral","Floral", min=0, max=4, value=2, step=1),
    actionButton("goButton", "Advise!")
  ),
  
  mainPanel(
    h3("Our suggestion"),
    verbatimTextOutput("Whisky1"),
    p("at a distance of "),
    verbatimTextOutput("Distance1"),
    h4("Alternatives"),
    verbatimTextOutput("Whisky2"),
    p("at a distance of "),
    verbatimTextOutput("Distance2"),
    p("and"),
    verbatimTextOutput("Whisky3"),
    p("at a distance of "),
    verbatimTextOutput("Distance3"),
    
    plotOutput("StarPlot")
  )
))

