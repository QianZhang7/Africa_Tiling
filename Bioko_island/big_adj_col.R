#install.packages(c("spdep", 'sp', 'igraph','doMC', 'foreach'))
library(spdep)
library(sp)
library(igraph)
library(doMC)
library(foreach)
registerDoMC(cores=4)

load("project/Tiling/data/population/population_rasters.RData")
world_100_2010_shp = rasterToPolygons(world_100_2010)
world_100_2010_shp <- world_100_2010_shp[world_100_2010_shp$GNQ10v2>0,]


judge_adj <- function(first, second, shapefile){
nb <- poly2nb(shapefile[c(first,second),], queen = F)
if(!(nb == 0)[1]){
    return(data.frame(first, second, 1))
  }
}

n = length(world_100_2010_shp)
a = vector("list", length = n)
foreach(i=1:(n-1))%dopar%{
  for(j in (i+1):n){
    #a[[i]] = append(a[[i]], judge_adj(i,j,world_100_2010_shp))
    write.table(judge_adj(i,j,world_100_2010_shp), file = "~/big_adj.txt", append = T, col.names = F, row.names = F)
  }
  #a[[i]] = as.data.frame(t(matrix(a[[i]],ncol = 2)))
 #write.table(a[[i]], file = "~/big_adj.txt", append = T, col.names = F, row.names = F)
}

