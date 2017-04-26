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
		} else if (length(traits)==3){
			trait_matrix[4,2]<-nrow(na.omit(data[,traits[c(1,2)]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[5,2]<-nrow(na.omit(data[,traits[c(1,3)]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[6,2]<-nrow(na.omit(data[,traits[c(2,3)]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[1,2]<-length(na.omit(data[,traits[1]]))-as.numeric(trait_matrix[rows,2])-as.numeric(trait_matrix[4,2])-as.numeric(trait_matrix[5,2])
			trait_matrix[2,2]<-length(na.omit(data[,traits[2]]))-as.numeric(trait_matrix[rows,2])-as.numeric(trait_matrix[4,2])-as.numeric(trait_matrix[6,2])
			trait_matrix[3,2]<-length(na.omit(data[,traits[3]]))-as.numeric(trait_matrix[rows,2])-as.numeric(trait_matrix[5,2])-as.numeric(trait_matrix[6,2])
			print(trait_matrix)
		} else if (length(traits==4)){
			trait_matrix[11,2]<-nrow(na.omit(data[,traits[c(1,2,3)]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[12,2]<-nrow(na.omit(data[,traits[c(1,2,4)]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[13,2]<-nrow(na.omit(data[,traits[c(1,3,4)]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[14,2]<-nrow(na.omit(data[,traits[c(2,3,4)]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[5,2]<-nrow(na.omit(data[,traits[c(1,2)]]))-as.numeric(trait_matrix[11,2])-as.numeric(trait_matrix[12,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[6,2]<-nrow(na.omit(data[,traits[c(1,3)]]))-as.numeric(trait_matrix[11,2])-as.numeric(trait_matrix[13,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[7,2]<-nrow(na.omit(data[,traits[c(1,4)]]))-as.numeric(trait_matrix[12,2])-as.numeric(trait_matrix[13,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[8,2]<-nrow(na.omit(data[,traits[c(2,3)]]))-as.numeric(trait_matrix[11,2])-as.numeric(trait_matrix[14,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[9,2]<-nrow(na.omit(data[,traits[c(2,4)]]))-as.numeric(trait_matrix[12,2])-as.numeric(trait_matrix[14,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[10,2]<-nrow(na.omit(data[,traits[c(3,4)]]))-as.numeric(trait_matrix[13,2])-as.numeric(trait_matrix[14,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[1,2]<-length(na.omit(data[,traits[1]]))-as.numeric(trait_matrix[5,2])-as.numeric(trait_matrix[6,2])-as.numeric(trait_matrix[7,2])-as.numeric(trait_matrix[11,2])-as.numeric(trait_matrix[12,2])-as.numeric(trait_matrix[13,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[2,2]<-length(na.omit(data[,traits[2]]))-as.numeric(trait_matrix[5,2])-as.numeric(trait_matrix[8,2])-as.numeric(trait_matrix[9,2])-as.numeric(trait_matrix[11,2])-as.numeric(trait_matrix[12,2])-as.numeric(trait_matrix[14,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[3,2]<-length(na.omit(data[,traits[3]]))-as.numeric(trait_matrix[6,2])-as.numeric(trait_matrix[8,2])-as.numeric(trait_matrix[10,2])-as.numeric(trait_matrix[11,2])-as.numeric(trait_matrix[13,2])-as.numeric(trait_matrix[14,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[4,2]<-length(na.omit(data[,traits[4]]))-as.numeric(trait_matrix[7,2])-as.numeric(trait_matrix[9,2])-as.numeric(trait_matrix[10,2])-as.numeric(trait_matrix[12,2])-as.numeric(trait_matrix[13,2])-as.numeric(trait_matrix[14,2])-as.numeric(trait_matrix[rows,2])
			print(trait_matrix)
		} else if (length(traits)==5){
			trait_matrix[26,2]<-nrow(na.omit(data[,traits[c(1,2,3,4)]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[27,2]<-nrow(na.omit(data[,traits[c(1,2,3,5)]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[28,2]<-nrow(na.omit(data[,traits[c(1,2,4,5)]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[29,2]<-nrow(na.omit(data[,traits[c(1,3,4,5)]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[30,2]<-nrow(na.omit(data[,traits[c(2,3,4,5)]]))-as.numeric(trait_matrix[rows,2])
			trait_matrix[16,2]<-nrow(na.omit(data[,traits[c(1,2,3)]]))-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[17,2]<-nrow(na.omit(data[,traits[c(1,2,4)]]))-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[18,2]<-nrow(na.omit(data[,traits[c(1,2,5)]]))-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[19,2]<-nrow(na.omit(data[,traits[c(1,3,4)]]))-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[20,2]<-nrow(na.omit(data[,traits[c(1,3,5)]]))-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[21,2]<-nrow(na.omit(data[,traits[c(1,4,5)]]))-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[22,2]<-nrow(na.omit(data[,traits[c(2,3,4)]]))-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[23,2]<-nrow(na.omit(data[,traits[c(2,3,5)]]))-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[24,2]<-nrow(na.omit(data[,traits[c(2,4,5)]]))-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[25,2]<-nrow(na.omit(data[,traits[c(3,4,5)]]))-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[6,2]<-nrow(na.omit(data[,traits[c(1,2)]]))-as.numeric(trait_matrix[16,2])-as.numeric(trait_matrix[17,2])-as.numeric(trait_matrix[18,2])-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[7,2]<-nrow(na.omit(data[,traits[c(1,3)]]))-as.numeric(trait_matrix[16,2])-as.numeric(trait_matrix[19,2])-as.numeric(trait_matrix[20,2])-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[8,2]<-nrow(na.omit(data[,traits[c(1,4)]]))-as.numeric(trait_matrix[17,2])-as.numeric(trait_matrix[19,2])-as.numeric(trait_matrix[21,2])-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[9,2]<-nrow(na.omit(data[,traits[c(1,5)]]))-as.numeric(trait_matrix[18,2])-as.numeric(trait_matrix[20,2])-as.numeric(trait_matrix[21,2])-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[10,2]<-nrow(na.omit(data[,traits[c(2,3)]]))-as.numeric(trait_matrix[16,2])-as.numeric(trait_matrix[22,2])-as.numeric(trait_matrix[23,2])-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[11,2]<-nrow(na.omit(data[,traits[c(2,4)]]))-as.numeric(trait_matrix[17,2])-as.numeric(trait_matrix[22,2])-as.numeric(trait_matrix[24,2])-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[12,2]<-nrow(na.omit(data[,traits[c(2,5)]]))-as.numeric(trait_matrix[18,2])-as.numeric(trait_matrix[23,2])-as.numeric(trait_matrix[24,2])-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[13,2]<-nrow(na.omit(data[,traits[c(3,4)]]))-as.numeric(trait_matrix[19,2])-as.numeric(trait_matrix[22,2])-as.numeric(trait_matrix[25,2])-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[14,2]<-nrow(na.omit(data[,traits[c(3,5)]]))-as.numeric(trait_matrix[20,2])-as.numeric(trait_matrix[23,2])-as.numeric(trait_matrix[25,2])-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[15,2]<-nrow(na.omit(data[,traits[c(4,5)]]))-as.numeric(trait_matrix[21,2])-as.numeric(trait_matrix[24,2])-as.numeric(trait_matrix[25,2])-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[1,2]<-length(na.omit(data[traits[1]]))-as.numeric(trait_matrix[6,2])-as.numeric(trait_matrix[7,2])-as.numeric(trait_matrix[8,2])-as.numeric(trait_matrix[9,2])-as.numeric(trait_matrix[16,2])-as.numeric(trait_matrix[17,2])-as.numeric(trait_matrix[18,2])-as.numeric(trait_matrix[19,2])-as.numeric(trait_matrix[20,2])-as.numeric(trait_matrix[21,2])-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[2,2]<-length(na.omit(data[traits[2]]))-as.numeric(trait_matrix[6,2])-as.numeric(trait_matrix[10,2])-as.numeric(trait_matrix[11,2])-as.numeric(trait_matrix[12,2])-as.numeric(trait_matrix[16,2])-as.numeric(trait_matrix[17,2])-as.numeric(trait_matrix[18,2])-as.numeric(trait_matrix[22,2])-as.numeric(trait_matrix[23,2])-as.numeric(trait_matrix[24,2])-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[3,2]<-length(na.omit(data[traits[3]]))-as.numeric(trait_matrix[7,2])-as.numeric(trait_matrix[10,2])-as.numeric(trait_matrix[13,2])-as.numeric(trait_matrix[14,2])-as.numeric(trait_matrix[16,2])-as.numeric(trait_matrix[19,2])-as.numeric(trait_matrix[20,2])-as.numeric(trait_matrix[22,2])-as.numeric(trait_matrix[23,2])-as.numeric(trait_matrix[25,2])-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[4,2]<-length(na.omit(data[traits[4]]))-as.numeric(trait_matrix[8,2])-as.numeric(trait_matrix[11,2])-as.numeric(trait_matrix[13,2])-as.numeric(trait_matrix[15,2])-as.numeric(trait_matrix[17,2])-as.numeric(trait_matrix[19,2])-as.numeric(trait_matrix[21,2])-as.numeric(trait_matrix[22,2])-as.numeric(trait_matrix[24,2])-as.numeric(trait_matrix[25,2])-as.numeric(trait_matrix[26,2])-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
			trait_matrix[5,2]<-length(na.omit(data[traits[5]]))-as.numeric(trait_matrix[9,2])-as.numeric(trait_matrix[12,2])-as.numeric(trait_matrix[14,2])-as.numeric(trait_matrix[15,2])-as.numeric(trait_matrix[18,2])-as.numeric(trait_matrix[20,2])-as.numeric(trait_matrix[21,2])-as.numeric(trait_matrix[23,2])-as.numeric(trait_matrix[24,2])-as.numeric(trait_matrix[25,2])-as.numeric(trait_matrix[27,2])-as.numeric(trait_matrix[28,2])-as.numeric(trait_matrix[29,2])-as.numeric(trait_matrix[30,2])-as.numeric(trait_matrix[rows,2])
		}
}

make_trait_matrix(c('a','b','c','d','e'))

# use strsplit and the which(colnames(data)==traits) stuff to force it to select the right answers?

# test: should be A=2, B=3, C=5, AB=2, AC=1, BC=1, ABC=3
a<-round(runif(17,max=20))
b<-round(runif(17,max=20))
c<-round(runif(17,max=20))
a[9:17]<-NA
b[c(8,7,6,13:17)]<-NA
c[c(4,5,7,8,10,11,12)]<-NA
df<-data.frame(a,b,c)

trait_overlap(c('a','b','c'), df)

# test2: should be A=1, B=1, C=1, D=2, AB=3, AC=2, AD=1, BC=1, BD=1, CD=2, ABC=2, ABD=0, ACD=0, BCD=1, ABCD=2

a<-round(runif(20,max=20))
b<-round(runif(20,max=20))
c<-round(runif(20,max=20))
d<-round(runif(20,max=20))
a[c(5,12:15,17:20)]<-NA
b[c(9:11,14:16,18:20)]<-NA
c[c(6:8,11,13,16,17,19,20)]<-NA
d[c(3,4,6:10,12,16:18)]<-NA
df<-data.frame(a,b,c,d)

trait_overlap(c('a','b','c','d'), df)

# test 3: should be ascending 1-4 in the categories
a<-round(runif(76,max=20))
b<-round(runif(76,max=20))
c<-round(runif(76,max=20))
d<-round(runif(76,max=20))
e<-round(runif(76,max=20))
a[c(12,13,31:40,51:63,67:76)]<-NA
b[c(22:30,37:40,42:50,57:66,71:76)]<-NA
c[c(7:10,17:21,27:30,34:36,41,44:50,52:56,62:70,72:76)]<-NA
d[c(4:6,11,14:16,21,24:26,32,33,41:43,47:51,54:56,61,64:71,74:76)]<-NA
e[c(2,3,14:20,22,23,31,41:46,51:53,57:60,64:73)]<-NA
df<-data.frame(a,b,c,d,e)
df

traits=c('a','b','c','d')
trait_overlap(c('a','b','c','d','e'),df)
nrow(na.omit(df[,traits[c(1,2,3,4)]]))-as.numeric(1)