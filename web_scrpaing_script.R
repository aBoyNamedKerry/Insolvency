library(tidyverse)
library(rvest)


#read the data in:
url <-  paste("https://www.thegazette.co.uk/notice/",i)

#url <-  paste("https://www.thegazette.co.uk/notice/",3431096)

page <- read_html(url)

list_of_insolvencies <- list()
j = 0
#for(j in 1:length(3431095:3431120)){
  for(i in 3431095:3431120) {

j <- j+1
#set url 
url <-  paste("https://www.thegazette.co.uk/notice/",i)
page <- read_html(url)


#nodes <- html_nodes(page, css = ".main")

# list_of_insolvencies[[j]] <- c(gsub("\n", "", html_text(nodes[3])),
#                                gsub("\n", "", html_text(nodes[4])))

#ceatgory of notice
node_category <- html_nodes(page, css = ".category")

#type of notice
node_type <- html_nodes(page, css = ".notice-type")

#notice number
node_accessible <- html_nodes(page, css = "h2")

#company name
node_co_no <- html_nodes(page, css = "h2")

#date
node_date <- html_nodes(page, css = "time")



list_of_insolvencies[[j]] <- c(html_text(node_category[2]),
                               html_text(node_type[2]),
                               html_text(node_accessible[2]),
                               html_text(node_co_no[2]),
                               html_text(node_date[2]))

  }


purrr::map(length(3431095:3431120), ~{
  
  })

#turn into a data frame
insolvency_df <- data.frame(matrix(unlist(list_of_insolvencies), length(list_of_insolvencies), byrow=TRUE))

#filter by insolvencies
insolvency_df <-
  data.table::as.data.table(insolvency_df)[
    grepl("Corporate Insolvency", insolvency_df$X1),
  ]



## --- pulll out individual elements


url <-  paste("https://www.thegazette.co.uk/notice/",3431096) #3431096 #3431107

page <- read_html(url)

#ceatgory of notice
node_category <- html_nodes(page, css = ".category")

html_text(node_category[2])

#type of notice
node_type <- html_nodes(page, css = ".notice-type")

html_text(node_type[2])

#number
node_accessible <- html_nodes(page, css = "h2")

html_text(node_accessible[2]) 

node_property <- html_nodes(page, css = ".property")

html_text(node_property[2])

#date
node_date <- html_nodes(page, css = "time")

html_text(node_date[2]) 


#name
node_co_name <- html_nodes(page, css = "h3")

html_text(node_co_name[1]) 


#company name
node_co_no <- html_nodes(page, css = "h2")

html_text(node_co_no[2]) 

#dd attempts
node_dd <- html_nodes(page, css = "dd")

html_text(node_dd[6]) 

for (i in 1:100){
  
  print(html_text(node_dt[i])) 
  
}

co_num <-  html_text(node_dd[6]) 



stringr::parse_number(co_num)



