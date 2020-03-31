parse_insolvency <- function(x, col = "Corporate Insolvency",
                             date_filter = "2020-01-01"){
require(dplyr)
  
  #filter NA results and anythign which isn't listed as coproate insolvency.
  filtered_list <- test_list[!is.na(x) & grepl(col, x)]
  
  # #turn into a data frame and add column names and date
  insolvency_df <- data.frame(matrix(unlist(filtered_list),
                                     length(filtered_list), 
                                     byrow=TRUE)) %>%
    rename(Category = X1, Notice_type = X2, Notice_desc = X3,
                  Company_name = X4, Company_number = X5, Date = X6,
                  notice_id = X7) %>%
    mutate(Date = as.Date(Date, "%d %B %Y")) %>% arrange(Date)
  
  #filter out actions and only those which state resolution for
  insolvency_df <- insolvency_df %>% 
    filter(Company_name != "Actions",
           grepl("Resolutions for",
                 Notice_type), Date >date_filter) %>%
    arrange(Date)
  
  insolvency_df
  
  
}