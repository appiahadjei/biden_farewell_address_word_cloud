# Biden Farewell Address Word Cloud

This repository contains the code for generating a word cloud from President Joe Biden's Farewell Address delivered on January 15, 2025. The word cloud visualizes the most frequently used words from the speech, helping to highlight key themes and topics discussed during the address.

---

## Project Overview

This R-based project processes the text of Biden's Farewell Address, removing stopwords and numeric characters, and then creates a word cloud that visually represents the frequency of words in the speech. The final output is saved both as an HTML widget and as a PNG image.

---

## Key Features:
- **Text Processing:** Tokenizes the speech, counts word frequencies, and removes common stopwords and numeric characters.
- **Word Cloud Generation:** Customizes the word cloud’s appearance, including color scheme and shape.
- **Export Formats:** Saves the word cloud as both an HTML interactive widget and a static PNG image.
- **Customizable Design:** Users can adjust the word cloud's color scheme, size, and shape.

---

## Requirements
To run this project, you need to install the following R libraries:

- dplyr
- wordcloud2
- webshot
- stringr
- tidytext
- htmltools
- PhantomJS is required for generating the PNG image from the HTML widget. You can install it using the following command:

```r
webshot::install_phantomjs()
```

---

## Installation
**1. Clone the Repository:**

Start by cloning the repository to your local machine:

```bash
git clone https://github.com/yourusername/biden-farewell-address-wordcloud.git
```
**2. Install the Required R Libraries:**

In R, install the required libraries:

```r
install.packages("dplyr", "wordcloud2", "webshot", "stringr", "tidytext", "htmltools"))
```
**3. Install PhantomJS:**

PhantomJS is necessary for generating a PNG image from the HTML word cloud. You can install it with:

```r
webshot::install_phantomjs()
```

---

## Usage
- **1. Prepare the Transcript:**

Download the transcript of President Biden's Farewell Address or use your own text file. Ensure the file path is correct.

- **Modify the File Path (if necessary):**

Update the file path in the R script if your text file is located elsewhere.

- **3. Run the Script:**

Execute the following R script by editing the file path and directory to generate the word cloud:

```r
# Load packages
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
```

---

## Output Files:

After running the script, you will find two files in the directory you create:

---

## Output Example
The output word cloud will visually display the most frequent words used in Biden's Farewell Address. The cloud will be designed using the color scheme of blue and red, and words will appear in a "circle" shape.
![biden_farewell_address](https://github.com/user-attachments/assets/4341ec7c-8cf5-4006-996f-6c27562733f3)

---

## License
This project is licensed under the MIT License - see the LICENSE file for details.
