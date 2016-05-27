#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
Eplot <- function(data,type,width=NULL,height=NULL,
                  visualMap_show=FALSE,visualMap_min=0,visualMap_max,mapType
){
  x <- list()
  if(type%in%c("line","bar")){
    tooltip.formatter <- unbox("{b}:{c}")
  }else if(type=="pie"){
    tooltip.formatter <- unbox("{b}:{c}({d}%)")
  }else if(type=="funnel"){
    tooltip.formatter <- unbox("{b}:{c}%")
  }else if(type=="map"){
    tooltip.formatter <- unbox("{b}:{c}")
  }
  x$tooltip <- list(show=unbox(TRUE),trigger=unbox('item'),formatter=tooltip.formatter)

  if(type%in%c("line","bar")){
    x$legend <- list(data=colnames(data),
                     orient=unbox('horizontal'),x=unbox('center'),y=unbox('top'))
    x$toolbox <- list(show=unbox("true"),
                      orient=unbox("vertical"),
                      feature=list(
                        restore=list(show=unbox("true")),
                        magicType=list(show=unbox("true"),type=c('line', 'bar')),
                        saveAsImage=list(show=unbox("true"))
                      ))
    x$xAxis <- list(list(type=unbox("category"),
                         boundaryGap=unbox('false'),
                         position=unbox("bottom"),
                         data=row.names(data))
    )
    x$yAxis <- list(list(type=unbox("value"),position=unbox("left")))
    x$series <- series_rectangular(data,type=type)
  }else if(type=="pie"){
    x$series <- series_pie(data)
  }else if(type=="funnel"){
    x$series <- series_funnel(data)
  }else if(type=="map"){
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
EplotOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'Eplot', width, height, package = 'Recharts')
}

#' @rdname Eplot-shiny
#' @export
renderEplot <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, EplotOutput, env, quoted = TRUE)
}
