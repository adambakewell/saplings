make_nas<-function(data, number){
	new.data<-data
	no.na<-which(!is.na(data))
	indexes<-matrix(data=c(1:(length(data)*nrow(data))), nrow=nrow(data))
	to.change<-sample(no.na, number)
	to.change.ind<-lapply(to.change, function(x) {which(indexes==x, arr.ind=TRUE)})
	to.change.ind<-matrix(unlist(to.change.ind), ncol=2, byrow=TRUE)
	for(i in 1:nrow(to.change.ind)){
		new.data[to.change.ind[i,1],to.change.ind[i,2]]<-NA
	}
	return(new.data)
}
