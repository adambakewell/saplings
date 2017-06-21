phylo_barplot<-function(model, ylim, ...){
	df<-as.data.frame(unique(model$fitted))
	df$X<-NA
	for(i in 1:nrow(df)){
		xvar=model$varNames[2]
		levels=levels(model$data$data[,xvar])
		for(x in 1:length(levels)){
			sp.in.lev<-rownames(model$data$data)[which(model$data$data[,xvar]==levels[x])]
			if(rownames(df)[i] %in% sp.in.lev){ df$X[i]<-levels[x]}
		}
	}
	rownames(df)<-df$X
	df<-df[order(rownames(df)),]
	if(missing(ylim)){
	plot<-barplot(df[,1], beside=T, space=0.25, ylim=c(0, 1.2*max(unique(model$fitted))+max(model$sterr)), ...)
	for(j in 1:length(unique(model$fitted))){
		arrows(x0=plot[j], x1=plot[j], y0=df[j,1]-model$sterr[j], y1=df[j,1]+model$sterr[j], angle=90, code=3)
	}
}
	else {
	plot<-barplot(df[,1], beside=T, space=0.25, ylim=ylim, ...)
	for(t in 1:length(unique(model$fitted))){
		arrows(x0=plot[t], x1=plot[t], y0=df[t,1]-model$sterr[t], y1=df[t,1]+model$sterr[t], angle=90, code=3)
	}
}
}

?barplot