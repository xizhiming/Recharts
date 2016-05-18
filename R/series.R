#折线图、柱状图
series_rectangular <- function(data,type,itemStyle=FALSE){
  list_name <- colnames(data)
  colnames(data) <- NULL
  data <- as.list(data)
  if(length(type)==1){type <- rep(type,length(data))}
  for(i in seq(length(data))){
    #加一个0是为了保证当只有一列的时候，转jason的时候可以带上[]方括号
    data[[i]] <- list(name=unbox(list_name[i]),type=unbox(type[i]),data=data[[i]],
                      itemStyle=list(normal=list(label=list(show=unbox(itemStyle),formatter=unbox('{c}')))))
  }
  return(data)
}
#饼图
series_pie <- function(data,type='pie',radius='55%'){
  list_name <- colnames(data)
  colnames(data) <- NULL
  data <- as.list(data)
  for(i in seq(length(data))){
    data[[i]] <- list(name=unbox(list_name[i]),value=data[[i]])
  }
  data=list(list(type=unbox('pie'),radius=unbox('55%'),data=data))
  return(data)
}
#地图
series_map <- function(data,mapType,itemStyle.normal=FALSE,itemStyle.emphasis=FALSE){
  list_name <- colnames(data)
  colnames(data) <- NULL
  data <- as.list(data)
  for(i in seq(length(data))){
    data[[i]] <- list(name=unbox(list_name[i]),value=data[[i]])
  }
  data <- list(list(type=unbox('map'),mapType=unbox(mapType),data=data,
                    itemStyle=list(normal=list(label=list(show=unbox(itemStyle.normal))),
                                   emphasis=list(label=list(show=unbox(itemStyle.emphasis)))
                    )))
  return(data)
}
#漏斗图
series_funnel <- function(data,type='funnel', sort='descending',gap=3,width='100%',x=0,y=0){
  list_name <- colnames(data)
  colnames(data) <- NULL
  data <- as.list(data)
  for(i in seq(length(data))){
    data[[i]] <- list(name=unbox(list_name[i]),value=data[[i]])
  }
  data <- list(list(data=data,type=unbox(type),sort=unbox(sort),gap=unbox(gap),
                    width=unbox(width),x=unbox(x),y=unbox(y),
                    itemStyle=list(normal=list(label=list(show=unbox(TRUE),position=unbox('inside'))))
  ))
  return(data)
}