#Downlodaing the packages needed
library(plotly)
library(gapminder)
library(colourpicker)
library(ggplot2)
library(shinycustomloader)
library(DT)

ui <- fluidPage(

    # App title
    titlePanel("COURSERA (DEVELOPING DATA PRODUCTS COURSE)-VISUALIZATION OF GAPMINDER DATA"),

    # Sidebar layout
    sidebarLayout(

        # Sidebar panel
        sidebarPanel(
            textInput("title", "Title", "GDP vs LIFE EXPECTANCY"),
            numericInput("size", "Point size", 1, 1),
            colourInput("color", "Point color", value = "red"),


            selectInput("continent", "Continent",
                        choices = c("All", levels(gapminder$continent))),

            sliderInput(inputId = "life", label = "LIFE EXPECTANCY",
                        min = 0, max = 100,
                        value = c(50, 60)),

            downloadButton("download_data")
        ),

        # Main panel
        mainPanel(
            tabsetPanel(type = "tabs",

                        tabPanel("Plot", withLoader(plotlyOutput("plot")) ),
                        tabPanel("Table", withLoader(DT::dataTableOutput("table")))
            )

        )
    )
)
