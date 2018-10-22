large_id <- which(com_cluster == 1920)
urban_ele <- as.numeric(unlist(group_information[large_id]))
urban_poly <- shp_15[urban_ele,]
urban_poly$urban <- rep(NA, 1920)

for (i in 1:1920){
  if(urban_poly$pop[i] >= 100){
    urban_poly$urban[i] <- 1
  }else{
    urban_poly$urban[i] <- 0
  }
}
