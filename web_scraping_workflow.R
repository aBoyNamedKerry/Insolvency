## Web scraping workflow
## Kerry Cella
## Date: 2020-03-23

source("R/scrape_gazette.R")
source("R/insolvency_ts_plot.R")
source("R/parse_insolvency.R")
source("R/parse_bankruptcy.R")
library(tidyverse)

test_list<- scrape_gazette(start = 3533990, end = 3540000)

idf <- parse_insolvency(test_list)

bdf <- parse_bankruptcy(test_list)


#graph data
insolvency_ts_plot(idf, date_col = Date)

insolvency_ts_plot(bdf, date_col = Date)

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
          paste0("./outputs/", Sys.Date(),"_", 3520000,
                 "to", 3540000,"_Gazette_Insolvencies.csv"),
          row.names = FALSE)

#wrtie oout list data from scraping
saveRDS(test_list,
        paste0("./outputs/", Sys.Date(),"_", 3520000,
                 "to", 3540000,"_Gazette_Insolvencies.rds"))


## Read in the data from previously:

prev_data <- data.table::fread("./outputs/2020-03-24_3525836to3535836_Gazette_Insolvencies.csv")


insolvency_ts_plot(df = prev_data, date_col = Date)


#test  - 100

test_list <- scrape_gazette(start = min(prev_data$notice_id) - 100, 
                            end = prev_data$notice_id )
