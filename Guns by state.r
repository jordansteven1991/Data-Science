library(plotly)
gunData <- read.csv(file="U:\\gun stats.csv", header = TRUE, sep = ",")

plot_ly( x = gunData$State,
         y = gunData$Firearm.Deaths,
        name = "Firearm Death By State",
        type = "bar")
