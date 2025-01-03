### Importing of recquired libraries for the visualization and interpretation.
library(dplyr)
library(shiny)
library(tidyr)
library(tidyverse)
library(leaps)
library(knitr)
library(ggplot2)
library("reshape2")
library(caret)
library(class)
library(psych)
library(tree)
library(rpart)
library(rattle)
library(randomForest)
library(readxl)
library(moments)
library(FactoMineR)
library(glmnet)
library(corrplot)
library(rsample)
library(psych)
library("gridExtra")
library(reshape2)
library(plotly)
library(gridExtra)
install.packages("GGally")
library(GGally)

### Importing the dataset from the current directory.
phi_data = read.csv("/Users/vishaypaka/Desktop/MASTERS FILE/SEM-3/AIT-664/Final Project/phishing_features_train.csv")

### PREPROCESSING OF THE DATASET
table(is.na(phi_data))

str(phi_data)

summary(phi_data)

table(phi_data$redirects)

table(phi_data$not_indexed_by_google)

# Replace -1 with 1 in not_indexed_by_google column
phi_data$not_indexed_by_google[phi_data$not_indexed_by_google == -1] <- 1

table(phi_data$issuer)

table(is.na(phi_data$issuer))

# Replacing the issuer recored having null values to unknown
phi_data$issuer <- gsub("^\\s*$", "unknown", phi_data$issuer)

# Replace NA values with "unknown"
phi_data$issuer[is.na(phi_data$issuer)] <- "unknown"

# Now, check if there are any NA values left
table(is.na(phi_data$issuer))

# Mapping table of abbreviations to full forms
issuer_mapping <- c("ACCVCA-120" = "Apple Public Server ECC CA 12 - G1",
                    "AT" = "Atos TrustedRoot Server-CA 2019",
                    "AU" = "Australia",
                    "BE" = "Belgium",
                    "BM" = "Bermuda",
                    "BR" = "Brazil",
                    "CH" = "Switzerland",
                    "CN" = "China",
                    "CZ" = "Czech Republic",
                    "DE" = "Germany",
                    "ES" = "Spain",
                    "FI" = "Finland",
                    "FR" = "France",
                    "GB" = "United Kingdom",
                    "GR" = "Greece",
                    "HK" = "Hong Kong",
                    "HU" = "Hungary",
                    "IN" = "India",
                    "IT" = "Italy",
                    "JP" = "Japan",
                    "LU" = "Luxembourg",
                    "LV" = "Latvia",
                    "MA" = "Morocco",
                    "NL" = "Netherlands",
                    "NO" = "Norway",
                    "PL" = "Poland",
                    "PT" = "Portugal",
                    "RO" = "Romania",
                    "SG" = "Singapore",
                    "SK" = "Slovakia",
                    "TR" = "Turkey",
                    "TW" = "Taiwan",
                    "unknown" = "Unknown",
                    "US" = "United States",
                    "UY" = "Uruguay")

# Updating issuer column in phi_data using mapping table
phi_data$issuer <- issuer_mapping[phi_data$issuer]

table(phi_data$certificate_age)

# As the certificate age cannot be negative, converting the negative values to positive
phi_data$certificate_age <- abs(phi_data$certificate_age)

table(phi_data$email_submission)

table(phi_data$request_url_percentage)

table(phi_data$mouseover_changes)

table(phi_data$right_click_disabled)

table(phi_data$popup_window_has_text_field)

table(phi_data$use_iframe)

table(phi_data$has_suspicious_port)

table(phi_data$external_favicons)

table(phi_data$TTL)

# Replace -1 with 0 in TTL column
phi_data$TTL[phi_data$TTL == -1] <- 0

table(phi_data$ip_address_count)

# Replace -1 with 0 in ip_address_count column
phi_data$ip_address_count[phi_data$ip_address_count == -1] <- 0

table(phi_data$TXT_record)

# Replace -1 with 1 in TXT_record column
phi_data$TXT_record[phi_data$TXT_record == -1] <- 1

table(phi_data$check_sfh)

table(phi_data$count_domain_occurrences)

table(phi_data$domain_registration_length)

# Replace -1 with 1 in domain_registration_length column
phi_data$domain_registration_length[phi_data$domain_registration_length == -1] <- 1

table(phi_data$abnormal_url)

table(phi_data$page_rank_decimal)

table(phi_data$age_of_domain)

# Replace -1 with 1 in age_of_domain column
phi_data$age_of_domain[phi_data$age_of_domain == -1] <- 1

table(phi_data$is_malicious)

# Calculating the mean of non-missing values in 'page_rank_decimal'
mean_page_rank <- mean(phi_data$page_rank_decimal, na.rm = TRUE)

# Impute missing values with the mean
phi_data$page_rank_decimal[is.na(phi_data$page_rank_decimal)] <- mean_page_rank

# Replace NA values with "unknown"
phi_data$issuer[is.na(phi_data$issuer)] <- "unknown"

# Printing the missing values of the dataset after cleaning
missing_values <- sapply(phi_data, function(x) sum(is.na(x)))
print(missing_values)

###==========================PLOT - 1 ======================================

# Correlation plot.
numeric_cols <- phi_data %>% select_if(is.numeric)
cor_mat <- cor(numeric_cols)
corrplot(cor_mat, method = "color", type = "upper", tl.col = "black", tl.srt = 45)

### EDAAAA====================PLOT - 2 =====================================

# Convert 'is_malicious' to factor
palette_ro <- c("yellow", "#FC4E07")
phi_data$is_malicious <- factor(phi_data$is_malicious, levels = c(0, 1), labels = c("0 (legitimate)", "1 (Malicious)"))

# Melt the data
df1 <- melt(phi_data[,c(5, 10, 11, 17, 26)], id.var = "is_malicious")

# Plot using ggplot
ggplot(data = df1, aes(x = is_malicious, y = value)) + 
  geom_boxplot(aes(fill = is_malicious)) +
  scale_fill_manual(values = palette_ro,
                    name = "Is Malicious") +
  facet_wrap(~ variable, scales = "free")

###=========================PLOT - 3 =====================================

# Melt the data
df2 <- melt(phi_data[,c(19, 27, 26)], id.var = "is_malicious")

# Plot using ggplot
ggplot(data = df2, aes(x = is_malicious, y = value)) + 
  geom_boxplot(aes(fill = is_malicious)) +
  scale_fill_manual(values = palette_ro,
                    name = "Is Malicious") +
  facet_wrap(~ variable, scales = "free")


# No proper box plots
# Melt the data
df3 <- melt(phi_data[,c(2, 8, 9, 18, 26)], id.var = "is_malicious")

# Plot using ggplot
ggplot(data = df3, aes(x = is_malicious, y = value)) + 
  geom_boxplot(aes(fill = is_malicious)) +
  scale_fill_manual(values = palette_ro,
                    name = "Is Malicious") +
  facet_wrap(~ variable, scales = "free")

# No proper box plots
# Melt the data
df4 <- melt(phi_data[,c(22, 23, 25, 26)], id.var = "is_malicious")

# Plot using ggplot
ggplot(data = df4, aes(x = is_malicious, y = value)) + 
  geom_boxplot(aes(fill = is_malicious)) +
  scale_fill_manual(values = palette_ro,
                    name = "Is Malicious") +
  facet_wrap(~ variable, scales = "free")

###========================PLOT - 4 ==============================

# Create bar plots
p11 <- ggplot(data = phi_data, aes(x = factor(not_indexed_by_google))) + 
  geom_bar(position = 'dodge', aes(fill = factor(is_malicious)), color = 'black') +
  scale_fill_manual(values = c(palette_ro[2], palette_ro[7]),
                    name = "Is Malicious",
                    labels = c("0 (legitimate)", "1 (Malicious)")) +
  labs(
    title = 'Not Indexed by Google with Is Malicious',
    x = 'Not Indexed by Google'
  ) + 
  scale_y_continuous(trans = 'log10') +  # Set y-axis to log scale
  scale_x_discrete(labels = c("0", "1"), expand = c(0, 0))  # Set x-axis labels without expansion

p22 <- ggplot(data = phi_data, aes(x = factor(email_submission))) + 
  geom_bar(position = 'dodge', aes(fill = factor(is_malicious)), color = 'black') +
  scale_fill_manual(values = c(palette_ro[2], palette_ro[7]),
                    name = "Is Malicious",
                    labels = c("0 (legitimate)", "1 (Malicious)")) +
  labs(
    title = 'Email Submission with Is Malicious',
    x = 'Email Submission'
  ) + 
  scale_y_continuous(trans = 'log10') +  # Set y-axis to log scale
  scale_x_discrete(labels = c("0", "1"), expand = c(0, 0))  # Set x-axis labels without expansion

p33 <- ggplot(data = phi_data, aes(x = factor(request_url_percentage))) + 
  geom_bar(position = 'dodge', aes(fill = factor(is_malicious)), color = 'black') +
  scale_fill_manual(values = c(palette_ro[2], palette_ro[7]),
                    name = "Is Malicious",
                    labels = c("0 (legitimate)", "1 (Malicious)")) +
  labs(
    title = 'Request URL Percentage with Is Malicious',
    x = 'Request URL Percentage'
  ) + 
  scale_y_continuous(trans = 'log10') +  # Set y-axis to log scale
  scale_x_discrete(labels = c("0", "1"), expand = c(0, 0))  # Set x-axis labels without expansion

p44 <- ggplot(data = phi_data, aes(x = factor(mouseover_changes))) + 
  geom_bar(position = 'dodge', aes(fill = factor(is_malicious)), color = 'black') +
  scale_fill_manual(values = c(palette_ro[2], palette_ro[7]),
                    name = "Is Malicious",
                    labels = c("0 (legitimate)", "1 (Malicious)")) +
  labs(
    title = 'Mouseover Changes with Is Malicious',
    x = 'Mouseover Changes'
  ) + 
  scale_y_continuous(trans = 'log10') +  # Set y-axis to log scale
  scale_x_discrete(labels = c("0", "1"), expand = c(0, 0))  # Set x-axis labels without expansion

p55 <- ggplot(data = phi_data, aes(x = factor(right_click_disabled))) + 
  geom_bar(position = 'dodge', aes(fill = factor(is_malicious)), color = 'black') +
  scale_fill_manual(values = c(palette_ro[2], palette_ro[7]),
                    name = "Is Malicious",
                    labels = c("0 (legitimate)", "1 (Malicious)")) +
  labs(
    title = 'Right Click Disabled with Is Malicious',
    x = 'Right Click Disabled'
  ) + 
  scale_y_continuous(trans = 'log10') +  # Set y-axis to log scale
  scale_x_discrete(labels = c("0", "1"), expand = c(0, 0))  # Set x-axis labels without expansion

p66 <- ggplot(data = phi_data, aes(x = factor(popup_window_has_text_field))) + 
  geom_bar(position = 'dodge', aes(fill = factor(is_malicious)), color = 'black') +
  scale_fill_manual(values = c(palette_ro[2], palette_ro[7]),
                    name = "Is Malicious",
                    labels = c("0 (legitimate)", "1 (Malicious)")) +
  labs(
    title = 'Popup Window has Text Field with Is Malicious',
    x = 'Popup Window has Text Field'
  ) + 
  scale_y_continuous(trans = 'log10') +  # Set y-axis to log scale
  scale_x_discrete(labels = c("0", "1"), expand = c(0, 0))  # Set x-axis labels without expansion

# Plotting
grid.arrange(p11, p22, p33, p44, p55, p66, nrow = 3, ncol = 2)

###==============================PLOT - 5 =========================================================================

# Create bar plots
p1 <- ggplot(data = phi_data, aes(x = factor(use_iframe))) + 
  geom_bar(position = 'dodge', aes(fill = factor(is_malicious)), color = 'black') +
  scale_fill_manual(values = c(palette_ro[2], palette_ro[7]),
                    name = "Is Malicious",
                    labels = c("0 (legitimate)", "1 (Malicious)")) +
  labs(
    title = 'Use Iframe with Is Malicious',
    x = 'Use Iframe'
  ) + 
  scale_y_continuous(trans = 'log10') +  # Set y-axis to log scale
  scale_x_discrete(labels = c("0", "1"), expand = c(0, 0))  # Set x-axis labels without expansion

p2 <- ggplot(data = phi_data, aes(x = factor(has_suspicious_port))) + 
  geom_bar(position = 'dodge', aes(fill = factor(is_malicious)), color = 'black') +
  scale_fill_manual(values = c(palette_ro[2], palette_ro[7]),
                    name = "Is Malicious",
                    labels = c("0 (legitimate)", "1 (Malicious)")) +
  labs(
    title = 'Has Suspicious Port with Is Malicious',
    x = 'Has Suspicious Port'
  ) + 
  scale_y_continuous(trans = 'log10') +  # Set y-axis to log scale
  scale_x_discrete(labels = c("0", "1"), expand = c(0, 0))  # Set x-axis labels without expansion

p3 <- ggplot(data = phi_data, aes(x = factor(abnormal_url))) + 
  geom_bar(position = 'dodge', aes(fill = factor(is_malicious)), color = 'black') +
  scale_fill_manual(values = c(palette_ro[2], palette_ro[7]),
                    name = "Is Malicious",
                    labels = c("0 (legitimate)", "1 (Malicious)")) +
  labs(
    title = 'Abnormal URL with Is Malicious',
    x = 'Abnormal URL'
  ) + 
  scale_y_continuous(trans = 'log10') +  # Set y-axis to log scale
  scale_x_discrete(labels = c("0", "1"), expand = c(0, 0))  # Set x-axis labels without expansion


# Plotting
grid.arrange(p1, p2, p3, nrow = 3, ncol = 2)

###===========================PLOT - 6 ============================================

# Creating the bar plot for issuers against target variable
plot_ly(phi_data, x = ~issuer, color = ~factor(is_malicious), colors = c("#440154FF", "#FDE725FF")) %>%
  add_histogram(histnorm = 'count', position = 'dodge') %>%
  layout(
    title = 'Bar graph of Malicious websites with their Issuers',
    xaxis = list(title = 'Issuer', tickangle = 90, side = 'bottom'),
    yaxis = list(title = 'Count', type = 'log'),
    legend = list(title = 'is_malicious'),
    barmode = 'group'
  )


###================================PLOT - 7 ================================================

# Define color palette
palette_ro <- c("yellow", "#FC4E07")

# Plotting Certificate age distribution
p1 <- ggplot(phi_data, aes(x = certificate_age)) + 
  geom_histogram(aes(y = ..density..), binwidth = 5, fill = palette_ro[1], color = "black") +
  geom_density(adjust = 0.8, fill = "cyan", color = "black", alpha = 0.25) +
  geom_vline(xintercept = median(phi_data$certificate_age), linetype = "longdash", colour = "blue") +
  labs(x = "Certificate Age",
       y = "Density",
       title = "Certificate Age Distribution")

# Plotting a relationship between certificate age and target variable
p2 <- ggplot(phi_data, aes(x = certificate_age, fill = is_malicious)) +
  geom_density(alpha = 0.64) +
  scale_fill_manual(values = c(palette_ro[2], palette_ro[7]),
                    name = "Is Malicious",
                    labels = c("0 (Legitimate)", "1 (Malicious)")) +
  geom_vline(xintercept = median(phi_data$certificate_age), linetype = "longdash", colour = "red") +
  labs(x = "Certificate Age",
       y = "Density",
       title = "Relationship between Certificate Age and Malicious Websites")

# Arrange plots in a grid
grid.arrange(p1, p2, nrow = 2)


###================================PLOT - 8 ================================================

# Plotting a  relationship between script percentage and target variable
ggplot(phi_data, aes(x = script_percentage, fill = is_malicious)) +
  geom_density(alpha = 0.64) +
  scale_fill_manual(values = c(palette_ro[2], palette_ro[7]),
                    name = "Is Malicious",
                    labels = c("0 (Legitimate)", "1 (Malicious)")) +
  geom_vline(xintercept = median(phi_data$script_percentage), linetype = "longdash", colour = "red") +
  labs(x = "Script Percentage",
       y = "Density",
       title = "Relationship between Script Percentage and Malicious Websites")

###================================PLOT - 9 ================================================

# Plotting a relationship between page rank decimal and target variable
ggplot(phi_data, aes(x = page_rank_decimal, fill = is_malicious)) +
  geom_density(alpha = 0.64) +
  scale_fill_manual(values = c(palette_ro[2], palette_ro[7]),
                    name = "Is Malicious",
                    labels = c("0 (Legitimate)", "1 (Malicious)")) +
  geom_vline(xintercept = median(phi_data$page_rank_decimal), linetype = "longdash", colour = "red") +
  labs(x = "Page Rank Decimal",
       y = "Density",
       title = "Relationship between Page Rank Decimal and Malicious Websites")


###================================PLOT - 10 ================================================

# Calculate average certificate age per issuer
average_certificate_age_per_issuer <- phi_data %>% group_by(issuer) %>%
  summarise(average_certificate_age = mean(certificate_age, na.rm = TRUE))

# Reset index and rename columns
average_certificate_age_df <- average_certificate_age_per_issuer %>%
  rename(issuer = issuer) %>%
  rename(average_certificate_age = average_certificate_age)

# Sort the data frame by average_certificate_age in descending order
average_certificate_age_df <- average_certificate_age_df[order(-average_certificate_age_df$average_certificate_age), ]

# Bar plot
ggplot(average_certificate_age_df, aes(x = average_certificate_age, y = issuer)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Average Certificate Age by Issuer",
       x = "Average Certificate Age",
       y = "Issuer") +
  theme_minimal()

###======================================================================================

## Now this cleaned dataset is exported and done the predictive modeling in Jupyter Notebook

# Export as CSV
write.csv(phi_data, file = '/Users/vishaypaka/Desktop/MASTERS FILE/SEM-3/AIT-664/Final Project/phishing_features_cleaned_data.csv', row.names = FALSE)
