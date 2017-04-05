
library("shiny")
library("googlesheets")
library("hms")
library("leaflet")

ui <- shinyUI(fluidPage(
  titlePanel("Crime Map"),
  # sidebarLayout(
  #   sidebarPanel(
  #   ),
      
  #  mainPanel(
       leafletOutput("map")
  #  )
  #)
))

server <- shinyServer(function(input, output) {
  gs <- gs_key("1qWnZmZH0oCznYD8GZRNVMCe4QQ8aYJcNiJA5U6SqHns")
  df <- gs_read(gs)
  df$Date <- as.Date(df$Date, format="%m/%d/%Y")
  df$Time_f <- as.character(as.hms(df$Time, "%H"))
  df$popup <- paste0('<a href="', df$URL, '">', df$`Location Description`,
                     '</a></br>',
                     "Location: ", df$Location, "</br>",
                     "Crime: ", df$Crime, "</br>",
                     "Date: ", df$Date, "</br>")
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(lng = df$lon, lat = df$lat, popup=df$popup)
  })
})

shinyApp(ui = ui, server = server)

