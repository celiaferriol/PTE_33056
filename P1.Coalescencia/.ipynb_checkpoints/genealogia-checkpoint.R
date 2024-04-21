genealogia <- function(p, mostra, LWD = 4, plot.all = TRUE){
   stopifnot(class(p) == 'coalescent.plot')
   N    <- dim(p$parent)[2] # nombre d'individus
   ngen <- dim(p$parent)[1]
   stopifnot(length(mostra) <= N)
   mostra <- sort(mostra)
   if (plot.all) {
      plot(p, mar = c(0, 4.1, 0, 0), sleep = 0)
   } else {
      plot(p, mar = c(0, 4.1, 0, 0), sleep = 0, colors = 'white')
   }
   points(mostra, rep(ngen, length(mostra)), cex = 25/max(N, ngen), pch = 16)
   segments(mostra,
            rep(ngen, length(mostra)),
            p$parent[ngen, mostra],
            rep(ngen - 1, length(mostra)),
            lwd = LWD)
   for (i in (ngen-1):1) {
      mostra <- unique(p$parent[i + 1, mostra])
      j <- length(mostra)
      segments(mostra,
               rep(i, j),
               p$parent[i, mostra],
               rep(i-1, j),
               lwd = LWD)
   }
}

mrca <- function(p, mostra) {
   stopifnot(class(p) == 'coalescent.plot')
   N    <- dim(p$parent)[2] # nombre d'individus
   ngen <- dim(p$parent)[1]
   stopifnot(length(mostra) <= N)
   mostra <- sort(mostra)
   generacio <- ngen
   while (generacio > 0 & length(mostra) > 1) {
      mostra <- unique(p$parent[generacio, mostra])
      generacio <- generacio - 1
   }
   if (length(mostra) == 1) {
      MRCA <- ngen - generacio
   } else {
      MRCA <- NA
   }
   return(MRCA)
}
