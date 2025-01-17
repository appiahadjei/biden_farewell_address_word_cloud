# Load packages
library(tidyverse)
library(dplyr)
library(wordcloud2)
library(webshot)
library(stringr)
library(tidytext)
library(htmltools)

# Install PhantomJS for webshot
webshot::install_phantomjs()

# Check file
if (!file.exists("C:/Users/user/Documents/Kwaku/biden_farewell_address/biden_farewell_address.txt")) {
  stop("Text file not found. Please check the file path.")
}

# Import file
text <- readLines("C:/Users/user/Documents/Kwaku/biden_farewell_address/biden_farewell_address.txt")

text_df <- data.frame(text = text)

# Count, Sort, and Remove numbers
preprocessed_data <- text_df %>%
  unnest_tokens(word,text) %>%
  count(word,sort = T) %>%
  anti_join(stop_words) %>%
  mutate(word = str_remove_all(word, "[:digit:]")) %>%
  filter(word !="")

# Words Color
col <- c("blue", "red")

# Create Word Cloud
word_cloud <- wordcloud2(preprocessed_data, backgroundColor = "white",
                         color = rep_len(col, nrow(preprocessed_data)),
                         shape = "circle", size = 1.2)

# Confirm Directory
if (!dir.exists("Kwaku/biden_farewell_address")) {
  dir.create("Kwaku/biden_farewell_address", recursive = TRUE)
}

# Save Widget
htmlwidgets::saveWidget(word_cloud,
                        "Kwaku/biden_farewell_address/biden_farewell_address.html",
                        selfcontained = F)

# Save Webshot in Directory
webshot::webshot("Kwaku/biden_farewell_address/biden_farewell_address.html",
                 "Kwaku/biden_farewell_address/biden_farewell_address.png",
                 delay = 15, vwidth = 1400, vheight = 1400)