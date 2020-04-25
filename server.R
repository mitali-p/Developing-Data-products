library(plotly)
library(colourpicker)
library(ggplot2)
library(gapminder)
library(shinycustomloader)
library(DT)

server <- function(input, output) {
    data1 <- reactive({
        data <- gapminder
        data <- subset(
            data,
            lifeExp >= input$life[1] & lifeExp <= input$life[2]
        )
        if (input$continent != "All") {
            data <- subset(
                data,
                continent == input$continent
            )
        }
        data
    })

    output$table <- DT::renderDataTable({
        data <- data1()
        data
    })

    output$download_data <- downloadHandler(
        filename = function() {
            paste("gapminder", Sys.Date(), ".csv", sep="")
        },
        content = function(file) {
            write.csv(data1(), file)
        }
    )


    output$plot <- renderPlotly({

        ggplotly({
            data <- data1()

            plot_of_gapminder <- ggplot(data, aes(gdpPercap, lifeExp)) +
                geom_point(size = input$size, col = input$color) +
                scale_x_log10() +
                ggtitle(input$title)

            plot_of_gapminder
        })
    })
}
