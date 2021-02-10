#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    
    # Define the page structure and insert corresponding module here
    bs4Dash::dashboardPage(
      sidebar_collapsed = TRUE,
      enable_preloader = TRUE,
      loading_duration = 2,
      loading_background = "#333333",
      
      # Create our navigation menu that links to each of the tabs we defined
      navbar = bs4Dash::bs4DashNavbar(),
      sidebar = bs4Dash::bs4DashSidebar(
        title = tagList(img(src = "www/logo.svg")),
        src = "www/personal_logo.svg",
        url = "https://www.linkedin.com/in/devinjevian/",
        brandColor = "gray-light",
        opacity = 0.5,
        bs4Dash::bs4SidebarMenu(
          # Setting id makes input$tabs give the tabName of currently-selected tab
          id = "tabs",
          bs4Dash::bs4SidebarMenuItem(
            "Stock Screener",
            icon = "dashboard",
            tabName = "stock_screener"
          ),
          bs4Dash::bs4SidebarMenuItem(
            "Strategy Backtest",
            icon = "calendar-alt",
            tabName = "strategy_backtest"
          ),
          bs4Dash::bs4SidebarMenuItem(
            "Portfolio Builder",
            icon = "chalkboard-teacher",
            tabName = "portfolio_tracker"
          ),
          bs4Dash::bs4SidebarMenuItem(
            "Stock Correlation",
            icon = "comments",
            tabName = "stock_correlation"
          )
        )
      ),
      # Show the appropriate tab's content in the main body of our dashboard when we select it
      body = bs4Dash::bs4DashBody(
        bs4Dash::bs4TabItems(
          bs4Dash::bs4TabItem(
            "stock_screener",
            mod_stock_screener_ui("stock_screener_ui_1")
          ),
          bs4Dash::bs4TabItem(
            "strategy_backtest",
            mod_strategy_backtest_ui("strategy_backtest_ui_1")
          ),
          bs4Dash::bs4TabItem(
            "portfolio_tracker",
            mod_portfolio_tracker_ui("portfolio_tracker_ui_1")
          )
        )
      ),
      footer = bs4Dash::bs4DashFooter(tagList(
        tags$b("Author: "),
        tags$i("Devin Jevian")
      ))
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(prefix = 'www',
                    directoryPath = app_sys('app/www'))
  
  tags$head(favicon(),
            bundle_resources(path = app_sys('app/www'),
                             app_title = 'stockmonitor'))
  # Add here other external resources
  # for example, you can add shinyalert::useShinyalert() )
}
