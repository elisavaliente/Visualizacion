library(shiny)
library(shinydashboard)
library(nycflights13)
library(dplyr)
library(plotly)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  resultado <- reactiveValues(
    
    flights = nycflights13::flights,
    airlines = nycflights13::airlines,
    weather = nycflights13::weather,
    flotaAviones = nycflights13::planes,
    
    # Añadimos la columna de aerolineas en vuelos con un join de dplyr y lo mismo después con la flota
    vuelos = inner_join(flights, airlines, by = "carrier"),
    
    # tenemos que hacer lo de la visibilidad y para ello tenemos que unir la de flights con la de weather
    vuelos_tiempo = inner_join(vuelos, weather, by = c("origin", "year", "month", "day", "hour")),
    
    # Mezclamos con la tabla de flota de aviones
    vuelosTodo = inner_join(vuelos_tiempo, flotaAviones, by = "tailnum")
  )
  
  output$flotaGrafica <- renderPlot({
    
    # histogramas de frecuencia de manufacturer, frecuencia de model, y frecuencia de type. 
    datosFinales <- filter(vuelosTodo, name == input$aerolinea)
    
    ggplot(datosFinales, aes(x = manufacturer))+
        geom_bar()
    })
  output$flotaGrafica2 <- renderPlot({
    
    datosFinales <- filter(vuelosTodo, name == input$aerolinea)
    ggplot(datosFinales, aes(x = type))+
        geom_bar()
    
  })
  
  output$flotaGrafica3 <- renderPlot({
    
    datosFinales <- filter(vuelosTodo, name == input$aerolinea)
    ggplot(datosFinales, aes(x = model))+
        geom_bar()
    
  })
  
  output$visibilidadGrafica <- renderUI({
    
    # podemos ver en la siguiente gráfica como afecta la visibilidad a la hora de salida 
    vuelosTodo%>%
      mutate(dep_delay_hr = dep_delay/60)%>%
      filter(visib == 10)%>%
      select(dep_delay_hr, visib)%>%
      ggplot(aes(x = visib, y = dep_delay_hr)) +
      geom_smooth() +
      xlab("Visibilidad") +
      ylab("Retraso salida") +
      ggtitle("Retraso salida por visibilidad")
  })
})
