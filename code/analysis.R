# Load Packages
library(tidyverse)
library(ggplot2)

# Import datasets
NYC_HIGHSCHOOLS <- read_csv("datasets/NYC_HIGHSCHOOLS.csv")
NYC_SATSCORES <- read_csv("datasets/NYC_SATSCORES.csv")

# Edit and Select needed columns
NYC_HIGHSCHOOLS <- NYC_HIGHSCHOOLS %>% select(dbn, location)
NYC_HIGHSCHOOLS$location = substr(sub(".*NY ", "", NYC_HIGHSCHOOLS$location), start = 1, stop = 5) 
NYC_HIGHSCHOOLS <- NYC_HIGHSCHOOLS %>% rename(Zipcode = location)

NYC_SATSCORES <- NYC_SATSCORES %>% mutate(`Total Mean Score` = `Critical Reading Mean` + `Mathematics Mean` + `Writing Mean`)
NYC_SATSCORES <- NYC_SATSCORES %>% select(DBN,`School Name`,`Total Mean Score`)
NYC_SATSCORES <- NYC_SATSCORES %>% rename(dbn = DBN)

# Join two tables
NYC_SAT_DATA <- inner_join(NYC_HIGHSCHOOLS,NYC_SATSCORES,by="dbn")

# Find average score per zipcode
by_zip <- NYC_SAT_DATA %>% group_by(Zipcode) %>% summarise(mean_sat = mean(`Total Mean Score`,na.rm = TRUE))

# Create Boxplot (Labeling Outliers)
is_outlier <- function(x) {
  return(x < quantile(x, 0.25) - 1.5 * IQR(x) | x > quantile(x, 0.75) + 1.5 * IQR(x))
}
p1 <- by_zip %>% mutate(outlier = ifelse(is_outlier(mean_sat), Zipcode, as.numeric(NA))) %>%
  ggplot(aes(x=factor(0),y = mean_sat)) +
  geom_boxplot() + geom_text(aes(label = outlier), na.rm = TRUE, hjust = -0.3) +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  labs(title ="Boxplot of mean SAT score by school zipcode (NYC)", y = "Mean SAT Score") 
  
# Create Histogram
p2 <- by_zip %>% ggplot(aes(x=mean_sat)) + geom_histogram(binwidth=75, color="black", fill="white") +
  labs(title ="Histogram of mean SAT score by school zipcode (NYC)", x = "Mean SAT Score", y="Count") 

# Save plots
ggsave(filename="boxplot.pdf", plot=p1, path = "./output" )
ggsave(filename="histogram.pdf", plot=p2, path = "./output")



