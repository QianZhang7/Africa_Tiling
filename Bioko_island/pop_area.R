
landscan_pop_table <- as.data.frame(table(landscan_pop), rownames = F)
landscan_pop_table[,1] <- as.numeric(landscan_pop_table[,1])
landscan_pop_table[,1] <- landscan_pop_table[,1]/sum(landscan_pop_table[,1])
landscan_pop_table[,2] <- as.numeric(landscan_pop_table[,2])
landscan_pop_table[,2] <- landscan_pop_table[,2]/sum(landscan_pop_table[,2])

mcdi1k_pop_table <- as.data.frame(table(mcdi1k_shp$pop), rownames = F)
mcdi1k_pop_table[,1] <- as.numeric(mcdi1k_pop_table[,1])
mcdi1k_pop_table[,1] <- mcdi1k_pop_table[,1]/sum(mcdi1k_pop_table[,1])
mcdi1k_pop_table[,2] <- as.numeric(mcdi1k_pop_table[,2])
mcdi1k_pop_table[,2] <- mcdi1k_pop_table[,2]/sum(mcdi1k_pop_table[,2])

world1k_pop_table <- as.data.frame(table(world_1k_value), rownames = F)
world1k_pop_table[,1] <- as.numeric(world1k_pop_table[,1])
world1k_pop_table[,1] <- world1k_pop_table[,1]/sum(world1k_pop_table[,1])
world1k_pop_table[,2] <- as.numeric(world1k_pop_table[,2])
world1k_pop_table[,2] <- world1k_pop_table[,2]/sum(world1k_pop_table[,2])



plot(mcdi1k_pop_table[,2],mcdi1k_pop_table[,1], xlab = 'area', ylab = 'population proportion', main = 'MCDI vs Landscan (1km)', xlim = c(0,1), col = 'grey')
points(landscan_pop_table[,2],landscan_pop_table[,1], col = 'red')
plot(mcdi1k_pop_table[,2],mcdi1k_pop_table[,1], xlab = 'area', ylab = 'population proportion', main = 'MCDI vs WorldPOP (1km)', xlim = c(0,1), col = 'grey')
points(world1k_pop_table[,2],world1k_pop_table[,1], col = 'green')


mcdi100_pop_table <- as.data.frame(table(mcdi100_shp$PEOPLE_N), rownames = F)
mcdi100_pop_table[,1] <- as.numeric(mcdi100_pop_table[,1])
mcdi100_pop_table[,1] <- mcdi100_pop_table[,1]/sum(mcdi100_pop_table[,1])
mcdi100_pop_table[,2] <- as.numeric(mcdi100_pop_table[,2])
mcdi100_pop_table[,2] <- mcdi100_pop_table[,2]/sum(mcdi100_pop_table[,2])

world100_pop_table <- as.data.frame(table(world_100_value), rownames = F)
world100_pop_table[,1] <- as.numeric(world100_pop_table[,1])
world100_pop_table[,1] <- world100_pop_table[,1]/sum(world100_pop_table[,1])
world100_pop_table[,2] <- as.numeric(world100_pop_table[,2])
world100_pop_table[,2] <- world100_pop_table[,2]/sum(world100_pop_table[,2])


par(mfrow=c(1,2))
plot(mcdi100_pop_table[,2],mcdi100_pop_table[,1], xlab = 'area', ylab = 'population proportion', main = 'MCDI vs WorldPOP (100m)', xlim = c(0,1), col = 'grey', ylim = c(0,0.25))
points(world100_pop_table[,2],world100_pop_table[,1], col = 'green')
plot(mcdi100_pop_table[,2],mcdi100_pop_table[,1], xlab = 'area', ylab = 'population proportion', main = 'Zoom in: MCDI(100m)', xlim = c(0,1), col = 'grey')
