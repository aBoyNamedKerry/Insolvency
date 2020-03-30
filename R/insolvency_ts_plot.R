insolvency_ts_plot <- function(df, date_col){
require(ggplot2)
require(dplyr)
  
  count(df, {{date_col}}) %>%
    ggplot2::ggplot(data = ., aes(x = {{date_col}}, y = n, group=1)) +
    geom_line()+
    labs(title = paste("Insolvency notices to London Gazette from",
                       min(df[[deparse(substitute(date_col))]]), "to",
                       max(df[[deparse(substitute(date_col))]])))+
    theme_bw()
  
}