make_trait_matrix<-function(traits, ...){
if(length(traits)>5){warning("trait_overlap currently supports maximum five traits, please contact Adam Bakewell using ab1348@york.ac.uk or via GitHub if you require more")} else{
	hold<-matrix(ncol=2, nrow=(2^length(traits)-1))
	for (j in 1:length(traits)){
		mat<-combn(traits, j)
		for(i in 1:ncol(mat)){
			if(j==1){
				hold[i,1]<-mat[1,i]
			} else if(j==2){
				hold[length(traits)+i,1]<-paste(mat[1,i], mat[2,i], sep="&")
			} else if(j==3){
				hold[if(length(traits)==3){6+i} else if(length(traits)==4){10+i} else if (length(traits==5)){15+i},1]<-paste(mat[1,i],mat[2,i], mat[3,i], sep="&")
			} else if(j==4){
				hold[if(length(traits)==4){14+i} else if (length(traits==5)){25+i},1]<-paste(mat[1,i],mat[2,i], mat[3,i], mat[4,i], sep="&")
			} else if(j==5){
				hold[30+i,1]<-paste(mat[1,i],mat[2,i], mat[3,i], mat[4,i], mat[5,i], sep="&")
			}
		}
	}
	return(hold)
	}
}

trait_overlap<-function(traits, data, ...){
	trait_matrix<-make_trait_matrix(traits)
	rows<-nrow(trait_matrix)
	suppressWarnings(trait_matrix[rows,2]<-nrow(na.omit(data[which(colnames(data)==traits)])))
	if(length(traits)==1){
		print(trait_matrix)
		} else if (length(traits)==2){
			trait_matrix[1,2]<-length(na.omit(data[,traits[1]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[2,2]<-length(na.omit(data[,traits[2]]))-as.numeric(trait_matrix[rows,2])
			print(trait_matrix)
		}
}

# use strsplit and the which(colnames(data)==traits) stuff to force it to select the right answers?
