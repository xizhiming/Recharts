#折线图、柱状图
series_rectangular <- function(data,type,stack,yAxisIndex,itemStyle=FALSE,position='inside'){
  list_name <- colnames(data)
  colnames(data) <- NULL
  data <- as.list(data)
  if(length(type)==1){type <- rep(type,length(data))}
  if(length(yAxisIndex)==1){yAxisIndex <- rep(yAxisIndex,length(data))}
  if(length(stack)==0){
    stack <- rep('',length(data))
  }else if(length(stack)==1){
    stack <- rep(stack,length(data))
    }
  for(i in seq(length(data))){
    data[[i]] <- list(name=unbox(list_name[i]),type=unbox(type[i]),
                      stack=unbox(stack[i]),
                      yAxisIndex=unbox(yAxisIndex[i]),
                      data=data[[i]],
                      itemStyle=list(normal=list(label=list(show=unbox(itemStyle),position=unbox(position),formatter=unbox('{c}')))))
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
  data=list(list(type=unbox('pie'),radius=unbox('65%'),data=data))
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
series_funnel <- function(data,type='funnel', sort='descending',gap=3,width='92%',x=0,y=0){
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
#散点图
# data <- data.frame(a=c(100,89,110,90,150),b=c(0.1,0.2,0.15,0.3,0.4),c=c("a","b","c","d","e"))
series_scatter <- function(data,mapType){
  data <- as.matrix(data)
  colnames(data) <- NULL
  new_data <- list()
  for(i in 1:nrow(data)){
    new_data[[i]] <- data[i,]
  }
  new_data <- list(list(type=unbox(mapType),data=new_data))
  return(new_data)
}
