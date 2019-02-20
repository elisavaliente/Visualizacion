library(nycflights13)
library(dplyr)
library(plotly)
library(ggplot2)

flights <- nycflights13::flights
airlines <- nycflights13::airlines
weather <- nycflights13::weather
flotaAviones <- nycflights13::planes

# Añadimos la columna de aerolineas en vuelos con un join de dplyr y lo mismo después con la flota
vuelos <- right_join(flights, airlines, by = "carrier")
vuelos_flota <- right_join(vuelos, flotaAviones, by = "tailnum")

# agrupamos por aerolinea
vuelos_flota %>% 
  group_by("name")%>%
  summarise(
  manuacturer1 = count(manufacturer),
  model1 = count(model),
  type1 = count(type)
)

# histogramas de frecuencia de manufacturer, frecuencia de model, y frecuencia de type. 

ggplot(vuelos_flota, aes(x = manufacturer))+
  geom_bar()
ggplot(vuelos_flota, aes(x = model))+
  geom_bar()
ggplot(vuelos_flota, aes(x = type))+
  geom_bar()
