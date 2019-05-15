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
coalComb <- grep("Coal", SCC$EI.Sector, ignore.case = T)
coal.scc <- as.character(SCC[coalComb, 1])
coal.emission.per.year <- NEI %>%
  filter(SCC %in% coal.scc) %>%
  group_by(year) %>%
  summarise(emission = sum(Emissions, na.rm = TRUE))

# ploting
library(ggplot2)
png("plot4.png")
qplot(year, emission, data = coal.emission.per.year, geom = c("point", "line"))+
  ylab("Total PM2.5 emission (tons)") +
  labs(title = "Total PM 2.5 emissions from coal combustion-related sources \n decreased from 1999 to 2008")
dev.off()

