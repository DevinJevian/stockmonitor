#' strategy_backtest UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_strategy_backtest_ui <- function(id) {
  ns <- NS(id)
  
  components <- readRDS(file = "inst/app/www/company_list.rds")
  fun_list_TTR <-
    readRDS(file = "inst/app/www/function_list_TTR.rds")
  
  tagList(
    bs4Dash::bs4Card(
      width = 12,
      maximizable = TRUE,
      closable = FALSE,
      enable_sidebar = TRUE,
      sidebar_start_open = TRUE,
      sidebar_width = "100%",
      sidebar_content = bs4Dash::bs4SidebarMenu(fluidRow(
        column(
          width = 4,
          shinyWidgets::pickerInput(
            inputId = ns("picker_stock"),
            label = "Select ticker",
            inline = TRUE,
            choices = components[, 1],
            choicesOpt = list(subtext = components[, 2]),
            options = list(`live-search` = TRUE)
          ),
          shinyWidgets::pickerInput(
            inputId = ns("indicator"),
            label = "Select indicator",
            inline = TRUE,
            choices = fun_list_TTR,
            options = list(`live-search` = TRUE)
          ),
          shinyWidgets::actionBttn(
            inputId = ns("init_stock"),
            label = "Initialize Stock",
            style = "fill",
            color = "default",
            size = "sm",
            icon = icon(name = "play")
          )
        ),
        column(width = 8,
               DT::DTOutput(ns("data_table")))
      )),
      title = "Chart",
      status = "dark",
      highcharter::highchartOutput(ns("stock_chart")) %>%
        shinycssloaders::withSpinner(.)
    )
  )
}

#' strategy_backtest Server Function
#'
#' @noRd
mod_strategy_backtest_server <- function(input, output, session) {
  ns <- session$ns
  
  # use eventReactive() for input$init_stock so the visualization will wait until we choose the stock
  select_stock <- eventReactive(input$init_stock, {
    input$picker_stock
  })
  
  # use eventReactive() again with selected() so we could get the data for corresponding stock
  stock <- eventReactive(select_stock(), {
    quantmod::getSymbols(Symbols = select_stock(),
                         auto.assign = FALSE) %>% # turn off auto-assign
      zoo::na.locf() # NA padding
  })
  
  output$stock_chart <-
    highcharter::renderHighchart({
      highcharter::highchart(type = "stock") %>%
        highcharter::hc_add_series(stock()) %>%
        highcharter::hc_tooltip(valueDecimals = 2) %>%
        highcharter::hc_caption(enabled = TRUE,
                                text = "Source: Yahoo Finance") %>%
        highcharter::hc_add_theme(hc = .,
                                  hc_thm = highcharter::hc_theme_tufte())
    })
  
  output$data_table <-
    DT::renderDT({
      index <- zoo::index(stock())
      coredata <- zoo::coredata(stock())
      
      dimnames(coredata)[[2]][1] <- "Open"
      dimnames(coredata)[[2]][2] <- "High"
      dimnames(coredata)[[2]][3] <- "Low"
      dimnames(coredata)[[2]][4] <- "Close"
      dimnames(coredata)[[2]][5] <- "Volume"
      dimnames(coredata)[[2]][6] <- "Adjusted"
      
      df <- data.frame(index, coredata) %>%
        dplyr::rename(Date = index) %>%
        dplyr::arrange(dplyr::desc(Date))
      
      DT::datatable(df,
                    rownames = FALSE,
                    style = "bootstrap4")
    })
  
}

## To be copied in the UI
# mod_strategy_backtest_ui("strategy_backtest_ui_1")

## To be copied in the server
# callModule(mod_strategy_backtest_server, "strategy_backtest_ui_1")
