mcdi_1k_csv <- as.data.frame(mcdi1k_centers@coords)
mcdi_1k_csv$h <- mcdi1k_centers@data$as.numeric.as.character.mcdi1k_shp.pop..
write.csv(mcdi_1k_csv,"project/Tiling/data/upload/mcdi_1k.csv", quote = F)

mcdi_100_csv <- as.data.frame(mcdi100_centers@coords)
mcdi_100_csv$h <- mcdi100_centers@data$mcdi100_shp.PEOPLE_N
write.csv(mcdi_100_csv,"project/Tiling/data/upload/mcdi_100.csv", quote = F)

worldpop_100_csv <- as.data.frame(rasterToPoints(world_100_2010))
names(worldpop_100_csv) <- c("x", "y", "h")
write.csv(worldpop_100_csv,"project/Tiling/data/upload/worldpop_100.csv", quote = F)

worldpop_1k_csv <- as.data.frame(rasterToPoints(world_1k_2010))
names(worldpop_1k_csv) <- c("x", "y", "h")
write.csv(worldpop_1k_csv,"project/Tiling/data/upload/worldpop_1k.csv", quote = F)

landscan_1k_csv <- as.data.frame(rasterToPoints(landscan))
names(landscan_1k_csv) <- c("x", "y", "h")
write.csv(landscan_1k_csv,"project/Tiling/data/upload/landscan_1k.csv", quote = F)
