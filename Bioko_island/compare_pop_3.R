

#########################################
world_100_value <- values(world_100_2010)
#world_pop_bioko <- world_pop_bioko[!is.na(world_pop_bioko)]
world_100_value[is.na(world_100_value)] <- 0

world_1k_value <- values(world_1k_2010)
#world_pop_bioko <- world_pop_bioko[!is.na(world_pop_bioko)]
world_1k_value[is.na(world_1k_value)] <- 0

landscan_pop <- values(landscan)
#landscan_pop <- landscan_pop[!is.na(landscan_pop)]
landscan_pop[is.na(landscan_pop)] <- 0
mcdi100_pop_cdf = append(mcdi100_shp$PEOPLE_N,rep(0, (length(world_100_value)-length(mcdi100_shp$PEOPLE_N))))
mcdi1k_pop_cdf = append(mcdi1k_shp$pop,rep(0, (length(world_1k_value)-length(mcdi1k_shp$pop))))

areaXpop.new = function(H, color, title){
  sH = sort(H)
  area = c(1:length(H))/length(H)
  cdf = cumsum(sH)/sum(H)
  plot(area, cdf, type ="l", col = color, main = title, xlab = 'area', ylab = 'cdf', xlim = c(0,1), ylim = c(0,1))
}
areaXpop = function(H, color){
  sH = sort(H)
  area = c(1:length(H))/length(H)
  cdf = cumsum(sH)/sum(H)
  lines(area, cdf, type ="l", col = color)
}


par(mfrow = c(1,1))
areaXpop.new(landscan_pop, color = "red", title = "Cdf plots")
areaXpop(world_pop_bioko_1km,color = "orange")
areaXpop(world_pop_bioko, color = "green")
areaXpop(mcdi100_pop_cdf, color = "blue")
areaXpop(mcdi1k_pop_cdf, color = "black")

legend(0,1,c("Landscan:1km", "WorldPOP:1km", "WorldPOP:100m", "MCDI:100m", "MCDI:1km"), col = c("red", "orange","green","blue", 'black'), lty = 1, cex = 0.6)
