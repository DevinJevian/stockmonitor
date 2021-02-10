#' stock_screener UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_stock_screener_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' stock_screener Server Function
#'
#' @noRd 
mod_stock_screener_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_stock_screener_ui("stock_screener_ui_1")
    
## To be copied in the server
# callModule(mod_stock_screener_server, "stock_screener_ui_1")
 
