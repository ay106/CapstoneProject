#libraries and packages
library(dplyr)
library(ggplot2)
library(patchwork)
library(gridExtra)


#loading full data
setwd("C:/Users/ashle/OneDrive/School/Capstone/")

clinical_trials <- read.csv('final_CT.csv')
publications <- read.csv('final_Pub.csv')
patents <- read.csv('final_Patent.csv')
grants <- read.csv('final_Grant.csv')
asci_names <- read.csv('1995_2010_details.csv')

#cleans ct, patents, and grant df's
clean_by_year <- function(dataframe) {
  interval_trials1995 <- dataframe[dataframe$asci_year == "1995",]
  interval_trials2010 <- dataframe[dataframe$asci_year == "2010",]

  filterA <- subset(interval_trials1995, year >= 1996 & year <= 2005)
  filterB <- subset(interval_trials2010, year >= 2011 & year <= 2020)
  
  filterB_aligned <- filterB[names(filterA)]
  
  cleaned <- rbind(filterA, filterB_aligned)
  
  return(cleaned)
}

#cleans publications
clean_by_year2 <- function(dataframe) {
  interval_trials1995 <- dataframe[dataframe$asci_year == "1995",]
  interval_trials2010 <- dataframe[dataframe$asci_year == "2010",]
  
  filterA <- subset(interval_trials1995, publication_year >= 1996 & publication_year <= 2005)
  filterB <- subset(interval_trials2010, publication_year >= 2011 & publication_year <= 2020)
  
  filterB_aligned <- filterB[names(filterA)]
  
  cleaned <- rbind(filterA, filterB_aligned)
  
  return(cleaned)
}

cleaned_cts <- clean_by_year(clinical_trials)
cleaned_grants <- clean_by_year(grants)
cleaned_patents <- clean_by_year(patents)
cleaned_pubs <- clean_by_year2(publications) #USES DIFFERENT FUNCTION

print(colnames(cleaned_grants))
#constructing sums of grants;isolate funding_usd, grant_number, person, year, asci-year
selected_columns <- cleaned_grants[, c("funding_usd", "grant_number", "Person", "year", "asci_year")]
selected_df <- data.frame(selected_columns)
selected_df <- subset(selected_df, !is.na(funding_usd))
sum_table <- aggregate(selected_df$funding_usd, by=list(Person=selected_df$Person), FUN=sum)
colnames(sum_table) <- c("Var1", "Total_Funding_USD")



#creating a dataframe with asci_year, person name, counts of each, must isolate year interval
construct_df <- function(dataframe) {
  name_counts <- table(dataframe$Person)
  name_counts_df <- as.data.frame(name_counts)
  
  return(name_counts_df)
}

pub_counts <- construct_df(cleaned_pubs)
ct_counts <- construct_df(cleaned_cts)
grants_counts <- construct_df(cleaned_grants)
patents_counts <- construct_df(cleaned_patents)
selected_df <- data.frame(selected_columns)
asci_years <- asci_names[, c("full_name", "year")]
colnames(asci_years) <- c("Var1", "year")

# Merge data frames one by one
merged_df <- merge(pub_counts, ct_counts, by = "Var1", all = TRUE)
merged_df <- merge(merged_df, grants_counts, by = "Var1", all = TRUE)
merged_df <- merge(merged_df, sum_table, by = "Var1", all = TRUE)
merged_df <- merge(merged_df, patents_counts, by = "Var1", all = TRUE)
merged_df <- merge(merged_df, asci_years, by = "Var1", all = TRUE)

colnames(merged_df) <- c("Person", "Count_Pubs", "Count_CT", "Count_Grants","Grant_Sums", "Count_Patents", "asci_year")
merged_df <- mutate_all(merged_df, ~replace(., is.na(.), 0))

print(merged_df)

merged_1995 <- subset(merged_df, asci_year == 1995)
merged_2010 <- subset(merged_df, asci_year == 2010)

# multiple linear Regression Model
model <- lm(Count_CT ~  Count_Pubs + Count_Patents + Grant_Sums, data = merged_df)
summary(model)

plot(model$fitted.values, model$residuals,
     xlab = "Fitted Values",
     ylab = "Residuals",
     main = "Residuals vs. Fitted Values Plot")


write.csv(merged_df, file = "Counts_Variables.csv", row.names = FALSE)

