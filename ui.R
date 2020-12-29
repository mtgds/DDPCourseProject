#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(maps)
library(mapdata)
library(ggplot2)

world <- map_data("world")
SUDLATAM <- world[world$region == "Chile" | world$region == "Argentina" | world$region == "Brazil" | world$region == "Peru" | world$region == "Colombia" | 
            world$region == "Uruguay" | world$region == "Venezuela" | world$region == "Ecuador" | world$region == "Paraguay" | world$region == "Bolivia" | 
            world$region == "Guyana" | world$region == "French Guiana" | world$region == "Suriname",]

select_country <- c("")
select_country <- c(select_country, unique(SUDLATAM$region))

shinyUI(fluidPage(
    
    titlePanel("Country Identification"),

    sidebarLayout(
        sidebarPanel(
            "Select a country to identify,",
            selectInput("select_country", "", select_country, selected = NULL, multiple=FALSE),
            h4("Detailed Instructions"),
            "This application allows you to locate and identify on the map of South America the different countries 
            that compose it and their geographical location."
        ),
        
        mainPanel(
            h4("South American countries"),
            plotOutput("mapPlot")
        )
    )
))
