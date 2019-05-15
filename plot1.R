# Downloading
if(!file.exists("./data")) {dir.create("data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "./data/pm25.zip")

# unzip
unzip("./data/pm25.zip", exdir = "./data")

# loading
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# preparing data
library(dplyr)
emission.per.year <- NEI %>%
  group_by(year) %>%
  summarise(emission = sum(Emissions, na.rm = T))

# ploting
png("plot1.png")
plot(emission.per.year, type = "l", ylab = "Total PM2.5 emission (tons)")
points(emission.per.year, pch = 19)
title(main = "Total PM2.5 emission decreased from 1999 to 2008")
dev.off()