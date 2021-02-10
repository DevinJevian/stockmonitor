#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # List the first level callModules here
  session$onSessionEnded(stopApp)
  callModule(mod_strategy_backtest_server, "strategy_backtest_ui_1")
}
