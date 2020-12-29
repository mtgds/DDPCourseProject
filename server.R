#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(maps)
library(mapdata)

shinyServer (function(input, output){
    
    world <- map_data("world")
    SUDLATAM <- world[world$region == "Chile" | world$region == "Argentina" | world$region == "Brazil" | world$region == "Peru" | world$region == "Colombia" | 
                world$region == "Uruguay" | world$region == "Venezuela" | world$region == "Ecuador" | world$region == "Paraguay" | world$region == "Bolivia" | 
                world$region == "Guyana" | world$region == "French Guiana" | world$region == "Suriname",]
    
    select_country <- reactive({
        subset(SUDLATAM, SUDLATAM$region %in% input$select_country)
    })
    
    output$mapPlot <- renderPlot({
        ggplot(data = SUDLATAM) + 
            geom_polygon(aes(x = long, y = lat, group = group), fill = "light yellow", color = "black") + 
            coord_fixed(1.1) + 
            guides(fill=FALSE) + 
            geom_polygon(data=select_country(), aes(x = long, y = lat, group = group), fill = "red")

    })
    
})