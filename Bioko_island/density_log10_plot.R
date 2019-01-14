
logXpop.new = function(H, color, title){
  H_value = values(H)
  H_value <- H_value[!is.na(H_value)]
  sH = sort(H_value)
  log10sH = log(sH,10)
  cdf = cumsum(sH)/sum(H_value)
  plot(log10sH, cdf, type ="l", col = color, main = title, xlab = 'population counts', ylab = 'cdf', ylim = c(0,1), xaxt='n')
}
logXpop = function(H, color){
  H_value = values(H)
  H_value <- H_value[!is.na(H_value)]
  sH = sort(H_value)
  log10sH = log(sH,10)
  cdf = cumsum(sH)/sum(H_value)
  lines(log10sH, cdf, type ="l", col = "orange", xaxt='n')
}


logXpop.new(mcdi_200_2010, color = "red", title = "Cdf for 200m grids(aggregated)")
logXpop(world_200_2010,color = "orange")
ticks <- seq(0, 3, by=1)
labels <- sapply(ticks, function(i) as.expression(bquote(10^ .(i))))
axis(1, at=c(0, 1,2,3), labels=labels)

legend(0,1,c("mcdi:100m", "WorldPOP:100m"), col = c("red", "orange"), lty = 1, cex = 0.6)
