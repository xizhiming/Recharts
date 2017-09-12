#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
Eplot <- function(data,type,title=NULL,width=NULL,height=NULL,
                  tooltip.trigger='item',
                  tooltip.formatter=NULL,
                  series_rectangular_itemStyle=FALSE,
                  legend_show=NULL,
                  yAxisName='',yAxisMin=NULL,yAxisIndex=0,stack=NULL,
                  visualMap_show=FALSE,visualMap_min=0,visualMap_max,mapType
){
  x <- list()
  if(!is.null(title)){
    x$title <- list(text=title,x=unbox('center'),y=unbox('-5'))
  }
  
  x$tooltip <- list(show=unbox(TRUE),trigger=unbox(tooltip.trigger))
  # if(type%in%c("line","bar")){
  #   tooltip.formatter <- unbox("{b}:{c}")
  # }
  if(!is.null(tooltip.formatter)){
    x$tooltip$formatter <- tooltip.formatter
  }else if(type[1]=="pie"){
    x$tooltip$formatter <- unbox("{b}:{c}({d}%)")
  }else if(type[1]=="funnel"){
    x$tooltip$formatter <- unbox("{b}:{c}%")
  }else if(type[1]=="map"){
    x$tooltip$formatter <- unbox("{b}:{c}")
  }
  
  if(type[1]%in%c("line","bar")){
    x$legend <- list(data=colnames(data),
                     orient=unbox('horizontal'),x=unbox('center'),y=unbox('20'))
    if(length(legend_show)!=0){
      x$legend$selected <- list()
      for(i in seq(ncol(data))){
        if(colnames(data)[i]%in%legend_show){
          x$legend$selected[[i]] <- unbox(TRUE)
        }else{
          x$legend$selected[[i]] <- unbox(FALSE)
        }
      }
      names(x$legend$selected) <- colnames(data)
    }
    x$toolbox <- list(show=unbox(TRUE),
                      orient=unbox("vertical"),
                      feature=list(
                        restore=list(show=unbox(TRUE)),
                        magicType=list(show=unbox(TRUE),type=c('line', 'bar')),
                        saveAsImage=list(show=unbox(TRUE))
                      ))
    x$xAxis <- list(list(type=unbox("category"),
                         boundaryGap=unbox('false'),
                         position=unbox("bottom"),
                         data=row.names(data))
    )
    x$yAxis <- as.list(yAxisName)
    for(i in  seq(length(yAxisName))){
      x$yAxis[[i]] <- list(type=unbox("value"),name=unbox(yAxisName[i]))
    }
    if(!is.null(yAxisMin)){
      x$yAxis$min <- unbox(yAxisMin)
    }
    x$series <- series_rectangular(data,type=type,stack=stack,
                                   yAxisIndex=yAxisIndex,
                                   itemStyle=series_rectangular_itemStyle)
  }else if(type[1]=="pie"){
    x$series <- series_pie(data)
  }else if(type[1]=="funnel"){
    x$series <- series_funnel(data)
  }else if(type[1]=="map"){
    x$visualMap <- list(show=unbox(visualMap_show),
                        min=unbox(visualMap_min),max=unbox(visualMap_max),
                        left=unbox('left'),top=unbox('bottom'),
                        text=c("max","min"),calculable=unbox(TRUE))
    x$series <- series_map(data=data,mapType=mapType)
  }
  x <- jsonlite::toJSON(x)
  
  # create widget
  htmlwidgets::createWidget(
    name = 'Eplot',
    x,
    width = width,
    height = height,
    package = 'Recharts'
  )
}

#' Shiny bindings for Eplot
#'
#' Output and render functions for using Eplot within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a Eplot
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name Eplot-shiny
#'
#' @export
EplotOutput <- function(outputId, width = '100%', height = '500px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'Eplot', width, height, package = 'Recharts')
}

#' @rdname Eplot-shiny
#' @export
renderEplot <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, EplotOutput, env, quoted = TRUE)
}
