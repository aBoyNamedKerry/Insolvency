scrape_gazette <- function(start, end){
require(rvest)  
require(dplyr)

  j <- 0 # set counter for list
  list_of_insolvencies <- list() # empty list to add to
  
  list_of_insolvencies <-
    purrr::map(c(start:end),
               possibly(~{
                 j <- j+1
                 #set url 
                 url <-  paste0("https://www.thegazette.co.uk/notice/",.x)
                 page <- read_html(url)
                 
                 #ceatgory of notice
                 node_category <- html_nodes(page, css = ".category")
                 
                 #type of notice
                 node_type <- html_nodes(page, css = ".notice-type")
                 
                 #notice number
                 node_accessible <- html_nodes(page, css = "h2")
                 
                 #name
                 node_co_name <- html_nodes(page, css = "h3")
                 
                 #company number
                 node_dd <- html_nodes(page, css = "dd")
                 
                 
                 
                 #date
                 node_date <- html_nodes(page, css = "time")
                 
                 list_of_insolvencies[[j]] <- c(html_text(node_category[2]),
                                                html_text(node_type[2]),
                                                html_text(node_accessible[2]),
                                                html_text(node_co_name[1]),
                                                #readr::parse_number(html_text(node_dd[6])),
                                                str_extract(node_dd[6], pattern = "[[:digit:]]+" ),
                                                html_text(node_date[[1]]),
                                                .x)
                 
               }, otherwise = NA))
  
                 
                 
                                      
                                      
  list_of_insolvencies
  
  
}
