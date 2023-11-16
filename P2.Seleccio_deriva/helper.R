# Al paquet "learnPopGen", la funció "plot.genetic.drift()" produeix
# més d'un gràfic amb l'opció "show = 'fixed'", i allarga el document
# innecessàriament. En aquest script re-definisc la funció per afegir
# l'opció "show = 'fixedLast'", que permet mostrar un únic gràfic de
# les proporcions de poblacions on s'han fixat els al·lels "a" o "A".

plot.genetic.drift<-function(x,...){
	if(hasArg(show)) show<-list(...)$show
	else show<-"p"
	if(hasArg(pause)) pause<-list(...)$pause
	else pause<-0.05
	if(show=="p"){
		if(hasArg(colors)) colors<-list(...)$colors
		else colors<-rep("black",ncol(x))
		if(hasArg(lwd)) lwd<-list(...)$lwd
		else lwd<-1
		if(hasArg(type)) type<-list(...)$type
		else type<-"l"
		plot(1:nrow(x),x[,1],type=type,col=colors[1],
			lwd=lwd,main="frequency of A",xlab="time",
			ylab="p",ylim=c(0,1))
		if(attr(x,"p0")<=0.5) text(paste("N =",attr(x,"Ne"),
			sep=" "),x=0,y=1,pos=4)
		else text(paste("N =",attr(x,"Ne"),sep=" "),x=0,y=0,
			pos=4)
		for(i in 2:ncol(x)) lines(1:nrow(x),x[,i],col=colors[i],
			lwd=lwd,type=type)
	} else if(show=="genotypes"){
		AA<-unclass(x)^2
		Aa<-2*unclass(x)*(1-unclass(x))
		aa<-(1-unclass(x))^2
		for(i in 1:nrow(x)){
			X<-cbind(aa[i,],Aa[i,],AA[i,])
			colnames(X)<-c("aa","Aa","AA")
			barplot(X,ylim=c(0,1),main="genotype frequencies",beside=TRUE)
			Sys.sleep(pause)
		}
	} else if(show=="fixed"){
		for(i in 1:nrow(x)){
			fixedA<-mean(x[i,]==1)
			fixeda<-mean(x[i,]==0)
			barplot(c(fixeda,fixedA),ylim=c(0,1),names.arg=c("a","A"),
				main="populations fixed",ylab="frequency")
			Sys.sleep(pause)
		}
    } else if(show=="fixedLast"){
        fixedA <- mean(x[nrow(x), ] == 1)
        fixeda <- mean(x[nrow(x), ] == 0)
        barplot(c(fixeda, fixedA), ylim = c(0, 1), names.arg = c('a', 'A'),
                main = 'populations fixed', ylab = 'frequency')
	} else if(show=="heterozygosity"){
		if(hasArg(lwd)) lwd<-list(...)$lwd
		else lwd<-1
		if(hasArg(type)) type<-list(...)$type
		else type<-"l"
		plot(1:nrow(x),2*attr(x,"p0")*(1-attr(x,"p0"))*(1-1/(2*attr(x,"Ne")))^(0:(nrow(x)-1)),
			lwd=2,col="red",main="heterozygosity",xlab="time",ylab="f(Aa)",
			ylim=c(0,0.6))
		lines(1:nrow(x),rowMeans(2*x*(1-x)),lwd=lwd,type=type)
	}
}