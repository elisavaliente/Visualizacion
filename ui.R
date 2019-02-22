library(shiny)
library(shinydashboard)
library(MASS)
library(ggplot2)
library(nycflights13)
library(dplyr)
library(plotly)


shinyUI(
  dashboardPage(skin = "black",
                dashboardHeader(title = "Shiny Final Elisa"), 
                dashboardSidebar(
                  sidebarMenu(
                    menuItem("Vuelos", tabName = "vuelos", icon = icon("modelo")),
                    menuItem("Flota", tabName = "flota", icon = icon("modelo"))
                  )
                ),
                dashboardBody(
                  tabItems(
                    tabItem(tabName = "vuelos",
                            fluidRow(
                              box(title = "Visibilidad", solidHeader = TRUE, status = "primary", 
                                  sliderInput("visibility", "Choose visibility", min = 1.00, max = 10.00, value = 8.00),
                                  actionButton("visibi", "Clic"),
                                  plotOutput("visibilidadGrafica")))),
                    tabItem(tabName = "flota",
                            fluidRow(
                              box(width = 4, title = "Manufacturer", solidHeader = TRUE, status = "primary",
                                  plotOutput("flotaGrafica")),
                              box(width = 4, title = "Type of the plane", solidHeader = TRUE, status = "primary",
                                  plotOutput("flotaGrafica2")),
                              box(width = 4, title = "Modelo", solidHeader = TRUE, status = "primary",
                                  plotOutput("flotaGrafica3")),
                              box(width = 4, title = "Aerolínea", solidHeader = TRUE, status = "primary",
                                  selectInput("aerolinea", "Choose the airline",
                                              choices = c("Endeavor Air Inc.", "American Airlines Inc.", "Alaska Airlines Inc.", "JetBlue Airways", "Delta Air Lines Inc.", "ExpressJet Airlines Inc.",  "Frontier Airlines Inc.", "AirTran Airways Corporation", "Hawaiian Airlines Inc.", "Envoy Air",  "SkyWest Airlines Inc.", "United Air Lines Inc.", "US Airways Inc.", "Virgin America", "Southwest Airlines Co.",  "Mesa Airlines Inc.")))
                            )
                    )
                  )
                )
  )
)
