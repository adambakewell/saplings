make_nas<-function(data, number, keep_n=2){	
	new.data<-data	
	no.na<-which(!is.na(data))	
	indexes<-matrix(data=c(1:(length(data)*nrow(data))), nrow=nrow(data))	
	keepers<-character()	
	for(j in 1:ncol(data)){		
			search<-no.na[no.na %in% indexes[,j]]
			keep<-sample(search, 2)
			keepers<-append(keepers, keep)
	}
	to.change<-sample(no.na[! no.na %in% keepers], number)
	to.change.ind<-lapply(to.change, function(x) {which(indexes==x, arr.ind=TRUE)})
	to.change.ind<-matrix(unlist(to.change.ind), ncol=2, byrow=TRUE)
	for(i in 1:nrow(to.change.ind)){
		rownum<-to.change.ind[i,1]
		colnum<-to.change.ind[i,2]
		new.data[rownum, colnum]<-NA
	}
	return(new.data)
}
