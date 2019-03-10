# server.R

shinyServer(function(input, output) {
  
  # map
  output$map <- renderLeaflet({
    return(build_map(input$city_select_box, input$cuisine_check_box))
  })
  
})