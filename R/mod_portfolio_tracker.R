#' portfolio_tracker UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_portfolio_tracker_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' portfolio_tracker Server Function
#'
#' @noRd 
mod_portfolio_tracker_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_portfolio_tracker_ui("portfolio_tracker_ui_1")
    
## To be copied in the server
# callModule(mod_portfolio_tracker_server, "portfolio_tracker_ui_1")
 
