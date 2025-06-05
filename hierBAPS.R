# hierBAPS 
library(msa)
library(rhierbaps)
library(ape)
library(ggtree)
library(phytools)
library(ggplot2)
library(pals) 


### For when need to initially save hierBAPS result #### 
# Loading data
snp.matrix <- load_fasta("/Users/alex/R-files/hierBAPS/output.fasta")
# Changed max.depth to 1 (from 2), this would take a lot time
hb.results <- hierBAPS(snp.matrix, max.depth = 1, n.pops = 20, quiet = TRUE)
head(hb.results$partition.df)

# Saves file, for next time 
write.csv(hb.results$partition.df, file = "hierbaps_partition.csv", col.names = TRUE, row.names = FALSE)
save_lml_logs(hb.results, file.path(tempdir(), "hierbaps_logML.txt"))


#### Start ####
# To be used for next time
mesa = read.csv("hierbaps_partition.csv")

# Read tree file 
t <- read.tree(file = "GTRsupport.raxml.support2")

# Show circular, with branch lengths 
gg <- ggtree(t,layout="circular")
gg <- gg%<+%mesa
gg <- gg+geom_tippoint(aes(color=factor(`level.1`))) #this is the column name in the saved csv file 
gg

# Not scaled branch lengths
gg <- ggtree(t, layout = "circular", branch.length = "none")
gg <- gg %<+% mesa
gg <- gg + geom_tippoint(aes(color = factor(`level.1`)))
gg <- gg + theme(legend.position = "right")
gg


# With legend 
gg <- ggtree(t, layout = "circular", branch.length = "none")
gg <- gg %<+% mesa
gg <- gg + geom_tippoint(aes(color = factor(`level.1`)), size=3)
gg <- gg + theme(legend.position = "right")
labels <- paste("Cluster", 1:14)

gg <- gg + scale_color_manual(
  values=parula(14),
  labels = labels,
  name = "Cluster Groups"
)
gg <- gg + scale_color_manual(
  values=
  labels = labels,
  name = "Cluster Groups"
)


