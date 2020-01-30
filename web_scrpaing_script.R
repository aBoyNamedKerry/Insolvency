library(tidyverse)
library(rvest)

##Not run
##read the data in:
#url <-  paste("https://www.thegazette.co.uk/notice/",3431096)
#page <- read_html(url)

#create empty list object
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
node_co_no <- html_nodes(page, css = "h3")

#date
node_date <- html_nodes(page, css = "time")



list_of_insolvencies[[j]] <- c(html_text(node_category[2]),
                               html_text(node_type[2]),
                               html_text(node_accessible[2]),
                               html_text(node_co_no[2]),
                               html_text(node_date[2]))

}

start <- 3431095
end <-  3444000

list_of_insolvencies <- purrr::map(c(start:end),
                                       possibly(~{
  
  j <- j+1
  
  
  #set url 
  url <-  paste("https://www.thegazette.co.uk/notice/",.x)
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
                                 readr::parse_number(html_text(node_dd[6])),
                                 html_text(node_date[2]))

  }, otherwise = NA_character_))






#filter NA results and anythign which isn't listed as coproate insolvency.
filtered_list <- list_of_insolvencies[!is.na(list_of_insolvencies) &
                                        grepl("Corporate Insolvency",
                                              list_of_insolvencies)]

# #turn into a data frame and add column names and date
insolvency_df <- data.frame(matrix(unlist(filtered_list),
                                   length(filtered_list), 
                                   byrow=TRUE)) %>%
  dplyr::rename(Category = X1, Notice_type = X2, Notice_desc = X3,
                Company_name = X4, Company_number = X5, Date = X6) %>%
  mutate(Date = lubridate::dmy(Date)) %>% arrange(Date)

# see diffierent notice types
table(insolvency_df$Notice_type)

#filter out actions, Only those for resolutions and date in Novemeber
insolvency_df <- insolvency_df %>% 
  filter(Company_name != "Actions",
         grepl("Resolutions for",
               Notice_type), Date >"2019-11-01")


#plot the winding up resolutions over time:
count(insolvency_df, Date) %>%
ggplot2::ggplot(data = ., aes(x = Date, y = n, group=1)) +
         geom_line()
 


# write out
write.csv(insolvency_df,
          paste0("./outputs/", Sys.Date(),"_", start,
                 "to", end,"_Gazette_Insolvencies.csv"),
          row.names = FALSE)




# #filter by insolvencies
# insolvency_df <-
#   data.table::as.data.table(insolvency_df)[
#     grepl("Insolvency", insolvency_df$X1),
#   ]



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



readr::parse_number(co_num)



