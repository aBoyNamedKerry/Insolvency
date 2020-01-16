library(tidyverse)
library(rvest)


list_of_insolvencies <- list()
j = 0
#for(j in 1:length(3431095:3431120)){
  for(i in 3431095:3431120) {

j <- j+1
#set url 

url <-  paste("https://www.thegazette.co.uk/notice/",i)

#url <-  paste("https://www.thegazette.co.uk/notice/",3431096)

page <- read_html(url)

nodes <- html_nodes(page, css = ".main")

list_of_insolvencies[[j]] <- html_text(nodes[3])

}#}
