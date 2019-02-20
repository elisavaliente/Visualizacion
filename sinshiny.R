library(nycflights13)
library(dplyr)
library(plotly)
library(ggplot2)
library(datacheckr)

flights <- nycflights13::flights
airlines <- nycflights13::airlines
weather <- nycflights13::weather
flotaAviones <- nycflights13::planes

# Añadimos la columna de aerolineas en vuelos con un join de dplyr y lo mismo después con la flota
vuelos <- inner_join(flights, airlines, by = "carrier")

# tenemos que hacer lo de la visibilidad y para ello tenemos que unir la de flights con la de weather
vuelos_tiempo <- inner_join(vuelos, weather, by = c("origin", "year", "month", "day", "hour"))

vuelosTodo <- inner_join(vuelos_tiempo, flotaAviones, by = "tailnum")

# agrupamos por aerolinea
gruposAerolínea <- vuelosTodo %>% 
  group_by(carrier)%>%
  summarise(flight_count = n(), 
            plane_count = n_distinct(tailnum),
            manufacturer_count = n_distinct(manufacturer),
            type_count = n_distinct(type), 
            model_count = n_distinct(model))

# histogramas de frecuencia de manufacturer, frecuencia de model, y frecuencia de type. 

ggplot(gruposAerolínea, aes(x = flight_count))+
  geom_bar()
ggplot(gruposAerolínea, aes(x = model_count))+
  geom_bar()
ggplot(gruposAerolínea, aes(x = type_count))+
  geom_bar()

# podemos ver en la siguiente gráfica como afecta la visibilidad a la hora de salida 
vuelosTodo %>%
  mutate(dep_delay_hr = dep_delay/60)%>%
  select(dep_delay_hr, visib) %>%
  ggplot(aes(x = visib, y = dep_delay_hr)) +
  geom_smooth()
  xlab("Visibilidad") +
  ylab("Retraso salida") +
  ggtitle("Retraso salida por visibilidad")
