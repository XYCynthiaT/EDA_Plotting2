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
BC.emission.per.year <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(emission = sum(Emissions, na.rm = T))

# ploting
png("plot2.png")
plot(BC.emission.per.year, type = "l", ylab = "Total PM2.5 emission (tons)")
points(BC.emission.per.year, pch = 19)
title(main = "Total PM2.5 emission changed \n in the Baltimore City from 1999 to 2008")
dev.off()
