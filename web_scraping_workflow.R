## Web scraping workflow
## Kerry Cella
## Date: 2020-03-23

source("R/scrape_gazette.R")
source("R/insolvency_ts_plot.R")
library(tidyverse)

test_list<- scrape_gazette(start = 3530836, end = 3535836)


#filter NA results and anythign which isn't listed as coproate insolvency.
filtered_list <- test_list[!is.na(test_list) &
                                        grepl("Corporate Insolvency",
                                              test_list)]

# #turn into a data frame and add column names and date
insolvency_df <- data.frame(matrix(unlist(filtered_list),
                                   length(filtered_list), 
                                   byrow=TRUE)) %>%
  dplyr::rename(Category = X1, Notice_type = X2, Notice_desc = X3,
                Company_name = X4, Company_number = X5, Date = X6,
                notice_id = X7) %>%
  mutate(Date = as.Date(Date, "%d %B %Y")) %>% arrange(Date)


insolvency_df <- insolvency_df %>% 
  filter(Company_name != "Actions",
         grepl("Resolutions for",
               Notice_type), Date >"2019-11-01") %>%
  arrange(Date)


#graph data
count(insolvency_df, Date) %>%
  ggplot2::ggplot(data = ., aes(x = Date, y = n, group=1)) +
  geom_line()+
  labs(title = paste("Insolvency notices to London Gazette from",
                     min(insolvency_df$Date), "to",
                     max(insolvency_df$Date)))+
  theme_bw()


scraped_list<- scrape_gazette(start = 3525836, end = 3530836)

#filter NA results and anythign which isn't listed as coproate insolvency.
filtered_list_scraped <- scraped_list[!is.na(scraped_list) &
                             grepl("Corporate Insolvency",
                                   scraped_list)]

# #turn into a data frame and add column names and date
insolvency_df_s <- data.frame(matrix(unlist(filtered_list_scraped),
                                   length(filtered_list_scraped), 
                                   byrow=TRUE)) %>%
  dplyr::rename(Category = X1, Notice_type = X2, Notice_desc = X3,
                Company_name = X4, Company_number = X5, Date = X6,
                notice_id = X7) %>%
  mutate(Date = as.Date(Date, "%d %B %Y")) %>% arrange(Date)

insolvency_df_s <- insolvency_df_s %>% 
  filter(Company_name != "Actions",
         grepl("Resolutions for",
               Notice_type), Date >"2019-11-01") %>%
  arrange(Date)

#graph data
count(insolvency_df_s, Date) %>%
  ggplot2::ggplot(data = ., aes(x = Date, y = n, group=1)) +
  geom_line()+
  labs(title = paste("Insolvency notices to London Gazette from",
                     min(insolvency_df$Date), "to",
                     max(insolvency_df$Date)))+
  theme_bw()


insolvency_df <- bind_rows(insolvency_df_s, insolvency_df)


#Write it out
write.csv(insolvency_df,
          paste0("./outputs/", Sys.Date(),"_", 3525836,
                 "to", 3535836,"_Gazette_Insolvencies.csv"),
          row.names = FALSE)


## Read in the data from previously:

prev_data <- data.table::fread("./outputs/2020-03-24_3525836to3535836_Gazette_Insolvencies.csv")


insolvency_ts_plot(df = prev_data, date_col = Date)


#test  - 100

test_list <- scrape_gazette(start = min(prev_data$notice_id) - 100, 
                            end = prev_data$notice_id )
