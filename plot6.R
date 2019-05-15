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
motor <- grep("motor", SCC$Short.Name, ignore.case = T)
motor.scc <- as.character(SCC[motor, 1])
motor.BCLA.emission.per.year <- NEI %>%
  filter(fips %in% c("24510", "06037") & SCC %in% motor.scc) %>%
  group_by(year, fips) %>%
  summarise(emission = sum(Emissions, na.rm = TRUE))

# ploting
library(ggplot2)
png("plot6.png")
ggplot(data = motor.BCLA.emission.per.year, aes(year, emission, color = fips)) + 
  geom_point() +
  geom_line() +
  labs(title = "Total PM 2.5 emissions from motor vehicle sources \n in Baltimore City and Los Angeles County from 1999 to 2008", 
       y = "Total PM2.5 emission (tons)") +
  scale_colour_discrete(name = "County", breaks = c("24510", "06037"), label = c("Baltimore", "Los Angeles"))
dev.off()
