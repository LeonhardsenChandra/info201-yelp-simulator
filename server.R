# server.R

shinyServer(function(input, output) {

  # map
  output$map <- renderLeaflet({
    return(build_map(input$city_select_box, input$cuisine_check_box))
  })

  # word cloud
  output$wordcloud <- renderPlot({
    return(build_wordcloud(input$cuisine_select_menu2))
  })

  # chart
  output$chart <- renderDT({
    return(build_chart(input$city_select_menu, input$cuisine_select_menu))
  })

  # plot
  output$plot <- renderPlotly({
    return(build_plot(input$cuisine_select_menu3))
  })
})
