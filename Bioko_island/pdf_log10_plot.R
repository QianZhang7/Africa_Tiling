logXpop_pdf.new = function(H, color, title){
  H_value = values(H)
  H_value <- H_value[!is.na(H_value)]
  sH = sort(H_value)
  log10sH = log(sH,10)
  plot(density(unique(log10sH), weights = table(log10sH)/length(log10sH)),type ="l", col = color, main = title, xlab = 'population counts', ylab = 'cdf', ylim = c(0,1.1), xaxt='n')
}
logXpop_pdf = function(H, color){
  H_value = values(H)
  H_value <- H_value[!is.na(H_value)]
  sH = sort(H_value)
  log10sH = log(sH,10)
  lines(density(unique(log10sH), weights = table(log10sH)/length(log10sH)), type ="l", col = "orange", xaxt='n')
}

par(mfrow = c(2,2))

logXpop_pdf.new(raster_mcdi_100, color = "red", title = "Pdf for 100m grids")
logXpop_pdf(world_100_2010,color = "orange")
ticks <- seq(0, 4, by=1)
labels <- sapply(ticks, function(i) as.expression(bquote(10^ .(i))))
axis(1, at=c(0, 1,2,3,4), labels=labels)


legend(2,1,c("mcdi:100m", "WorldPOP:100m"), col = c("red", "orange"), lty = 1, cex = 0.5)


logXpop_pdf.new(mcdi_200_2010, color = "red", title = "Pdf for 200m grids(aggregated)")
logXpop_pdf(world_200_2010,color = "orange")
ticks <- seq(0, 4, by=1)
labels <- sapply(ticks, function(i) as.expression(bquote(10^ .(i))))
axis(1, at=c(0, 1,2,3,4), labels=labels)


legend(2,1,c("mcdi:100m", "WorldPOP:100m"), col = c("red", "orange"), lty = 1, cex = 0.5)


logXpop_pdf.new(mcdi_500_2010, color = "red", title = "Pdf for 500m grids(aggregated)")
logXpop_pdf(world_500_2010,color = "orange")
ticks <- seq(0, 4, by=1)
labels <- sapply(ticks, function(i) as.expression(bquote(10^ .(i))))
axis(1, at=c(0, 1,2,3,4), labels=labels)


legend(2,1,c("mcdi:100m", "WorldPOP:100m"), col = c("red", "orange"), lty = 1, cex = 0.5)


