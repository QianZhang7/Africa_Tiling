#install.packages(c("spdep", 'sp', 'igraph','doMC', 'foreach'))
library(spdep)
library(sp)
library(igraph)
library(doMC)
library(foreach)
library(raster)
library(data.table)
#registerDoMC(cores=500)

load("~/denominators/population_rasters.RData")
world_100_2010_shp = rasterToPolygons(world_100_2010)
world_100_2010_shp <- world_100_2010_shp[world_100_2010_shp$GNQ10v2>0,]
args <- commandArgs(TRUE)

judge_adj <- function(first, second, shapefile){
nb <- poly2nb(shapefile[c(first,second),], queen = F)
if(!(nb == 0)[1]){
    return(data.frame(first, second, 1))
  }
}
#n = 10
n = length(world_100_2010_shp)
#a = vector("list", length = n)
start = as.numeric(args[1])
for(j in (start+1):n){
    write.table(judge_adj(start,j,world_100_2010_shp), file = paste("/ihme/homes/qianzh/denominators/results/big_adj_", start, sep = ''),append = T,quote = F, col.names = F, row.names = F)
  }

