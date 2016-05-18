library(shinydashboard)
library(Recharts)
body <- dashboardBody(
  fluidRow(
    column(6,EplotOutput("data_line_bar_1")),
    column(6,EplotOutput("data_line_bar_2"))
  ),
  fluidRow(
    column(6,EplotOutput("data_pie")),
    column(6,EplotOutput("data_funnel"))
  ),
  fluidRow(
    column(6,EplotOutput("data_map_china")),
    column(6,EplotOutput("data_map_BJ"))
  )
)
shinyUI(
  dashboardPage(
    dashboardHeader(title="百度Echart测试"),
    dashboardSidebar(disable = TRUE),
    body
  )
)