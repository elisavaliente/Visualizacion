library(shiny)
library(shinydashboard)
library(MASS)
library(ggplot2)

shinyUI(
  dashboardPage(skin = "black",
                dashboardHeader(title = "Shiny Final Elisa"), 
                dashboardSidebar(
                  sidebarMenu(
                    menuItem("Vuelos", tabName = "vuelos", icon = icon("image")),
                    menuItem("Flota", tabName = "flota", icon = icon("modelo"))
                  )
                ),
                dashboardBody(
                  tabItems(
                    tabItem(tabName = "vuelos",
                            fluidRow(
                              box(title = "Visibilidad", solidHeader = TRUE, status = "primary", 
                                  sliderInput("visibility", "Choose visibility", min = 1, max = 50, value = 10)))),
                    tabItem(tabName = "flota",
                            fluidRow(
                              box(title = "Graph", solidHeader = TRUE, status = "primary",
                                  selectInput("aerolinea", "Aerolínea", choices = nombres))
                    )
                  )
                )
  )
)
)