# fastANI code

library("reshape2")
library("ComplexHeatmap")
library("gplots")


##### From that site ####

### get data, convert to matrix
x <- read.table("fastani_all.out")
df_clean <- x[!apply(x, 1, function(row) any(grepl("021307345.1.fna", row))), ]

matrix <- acast(df_clean, V1~V2, value.var="V3")

### define the colors within 2 zones

breaks <- seq(min(matrix, na.rm = TRUE), max(100), length.out = 100)
gradient1 = colorpanel( sum( breaks[-1]<=95 ), "#70c0a0", "white" )
gradient2 = colorpanel( sum( breaks[-1]>95 & breaks[-1]<=100), "white", "#946fd7" )

hm.colors = c(gradient1, gradient2)

heatmap.2(matrix, scale = "none", trace = "none", col = hm.colors, 
          cexRow = 0.30, cexCol = 0.30, 
          labRow = NULL, labCol = NULL)


#### Bar graph of frequency #### 
x <- read.table("fastani_all.out4")
freq <- x$V3
system("say check R")

directory <- ""
dir.create(directory)
filename <- paste0("/plot.png")
output <- paste0(directory,filename)
png(filename = output, width = 3000, height = 2000, units = "px", bg = "white", res = 250)

hist(freq, xlab = "Average Nucleotide Identity", ylab = "Frequency", breaks = 75, col = "#0275df", border = "black")
#print(hist(freq))

dev.off()
cat("Saved:", output, "\n")


