## Recharts
### 安装
```
require(devtools)
require(jsonlite)
devtools::install_github("xizhiming/Recharts")
```
### 使用
#### Eplot:画图
首先需要使用`Eplot`函数创建一个图形，`Eplot`函数目前支持折线图(line)、柱状图(bar)、饼图(pie)、漏斗图(funnel)、地图(map)等五种类型的图形。  
下面我们使用用`Eplot`创建一个折现图作为例子：
```
library(Recharts)
library(jsonlite)
data_line_bar <- data.frame('最高'=c(35,45,40,35,55),
                            '中间'=c(25,35,30,25,45),
                            '最低'=c(15,25,20,15,35))
row.names(data_line_bar) <- c('3-1','3-2','3-3','3-4','3-5')
# series_rectangular_itemStyle参数为TRUE表示折现图中显示数据
Eplot(type="line",data=data_line_bar,series_rectangular_itemStyle=TRUE)
```
![折线图](http://ohujep0fg.bkt.clouddn.com/Recharges_01.png)

#### renderEplot:输出图形
如果我们是在shiny中使用Eplot，那么画好图后，我们需要再server.R中调用renderEplot将图形输出至ui端。
```
output$data_line_bar_1 <- renderEplot({
      Eplot(type="line",data=data_line_bar,series_rectangular_itemStyle=TRUE)
    })
```
#### EplotOutput:展示图形
server.R中使用renderEplot将图形输出至ui端之后，我们需要在ui.R中使用EplotOutput进行图形的展示。
```
EplotOutput("data_line_bar_1")
```
### 完整代码:shiny中使用Recharts
#### server.R
```
library(Recharts)
library(jsonlite)
shinyServer(
  function(input,output,session){
    data_line_bar <- data.frame('最高'=c(35,45,40,35,55),
                                '中间'=c(25,35,30,25,45),
                                '最低'=c(15,25,20,15,35))
    row.names(data_line_bar) <- c('3-1','3-2','3-3','3-4','3-5')
    
    data_line_bar_2 <- data.frame('最高'=c(35,45,40,35,55))
    row.names(data_line_bar_2) <- c('3-1','3-2','3-3','3-4','3-5')
    #饼图数据
    data_pie <- data.frame('直接访问'=100,
                           'SEO'=200,
                           'SEM'=180,
                           'REF'=234
    )
    #漏斗图数据
    data_funnel <- data.frame('点击'=100,
                              '下单'=50,
                              '支付'=20,
                              '收货'=19)
    #地图数据
    data_map_china <- data.frame("上海"=1200,"北京"=500)
    data_map_BJ <- data.frame("黄浦区"=120,"浦东新区"=300)
    
    # 折线图
    output$data_line_bar_1 <- renderEplot({
      Eplot(type="line",data=data_line_bar,series_rectangular_itemStyle=TRUE)
    })
    
    # 柱状图
    output$data_line_bar_2 <- renderEplot({
      Eplot(type="bar",data=data_line_bar_2)
    })
    
    # 饼图
    output$data_pie <- renderEplot({
      Eplot(type="pie",data=data_pie)
    })
    
    # 漏斗图
    output$data_funnel <- renderEplot({
      Eplot(type="funnel",data=data_funnel)
    })
    
    # 地图：中国地图
    output$data_map_china <- renderEplot({
      Eplot(type="map",data=data_map_china,
            mapType="china",visualMap_max=5000
      )
    })
    
    # 地图：上海地图
    output$data_map_BJ <- renderEplot({
      Eplot(type="map",data=data_map_BJ,
            mapType="上海",visualMap_max=150
      )
    })
  })
```
#### ui.R
```
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
```
