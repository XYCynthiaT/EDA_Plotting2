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
type.BC.emission.per.year <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarise(emission = sum(Emissions, na.rm = TRUE))

# ploting
library(ggplot2)
png("plot3.png")
qplot(year, emission, data = type.BC.emission.per.year, color = type, geom = c("point", "line"))+
  ylab("Total PM2.5 emission (tons)")+
  labs(title = "Total PM2.5 emission from the four types \n of sources in the Baltimore City")
dev.off()

