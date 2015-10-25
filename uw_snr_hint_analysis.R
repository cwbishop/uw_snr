# Libraries
library(readr)
library(dplyr)
library(ggplot2)

# Load in data
hint_default = read_csv('Default_calculation_batch_HINT.csv')
hint_reversal = read_csv('Reversal_mean_calculation_batch_HINT.csv')

# Add in site codes
site_code = unlist( (hint_default %>% rowwise %>% do(site=if(.$SubID<2000){'UW'}else{'Iowa'}))$site )
hint_default = hint_default %>% mutate(site = site_code)

# Plot each variable
#   Will help us spot outliers.
ggplot(hint_default, aes(x=as.character(SubID), y=mean_SNR50, fill=site)) + geom_bar(stat='identity') + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + facet_wrap(~noise_type, ncol=1)
ggplot(hint_default, aes(x=as.character(SubID), y=mean_SNR80, fill=site)) + geom_bar(stat='identity') + theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Summarize data

