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

trait_overlap<-function(traits, data, plot=FALSE,...){
	trait_matrix<-make_trait_matrix(traits)
	rows<-nrow(trait_matrix)
	if(length(traits)==1){
		} else if (length(traits)==2){
			lastrow<-trait_matrix[3,2]<-nrow(na.omit(data[,traits[c(1,2)]]))
			trait_matrix[1,2]<-length(na.omit(data[,traits[1]]))-lastrow
			trait_matrix[2,2]<-length(na.omit(data[,traits[2]]))-lastrow
		} else if (length(traits)==3){
			lastrow<-trait_matrix[7,2]<-nrow(na.omit(data[,traits[c(1,2,3)]]))
			ab<-trait_matrix[4,2]<-nrow(na.omit(data[,traits[c(1,2)]]))-lastrow
			ac<-trait_matrix[5,2]<-nrow(na.omit(data[,traits[c(1,3)]]))-lastrow
			bc<-trait_matrix[6,2]<-nrow(na.omit(data[,traits[c(2,3)]]))-lastrow
			trait_matrix[1,2]<-length(na.omit(data[,traits[1]]))-lastrow-ab-ac
			trait_matrix[2,2]<-length(na.omit(data[,traits[2]]))-lastrow-ab-ac
			trait_matrix[3,2]<-length(na.omit(data[,traits[3]]))-lastrow-ac-bc
		} else if (length(traits)==4){
			lastrow<-trait_matrix[15,2]<-nrow(na.omit(data[,traits[c(1,2,3,4)]]))
			abc<-trait_matrix[11,2]<-nrow(na.omit(data[,traits[c(1,2,3)]]))-lastrow
			abd<-trait_matrix[12,2]<-nrow(na.omit(data[,traits[c(1,2,4)]]))-lastrow
			acd<-trait_matrix[13,2]<-nrow(na.omit(data[,traits[c(1,3,4)]]))-lastrow
			bcd<-trait_matrix[14,2]<-nrow(na.omit(data[,traits[c(2,3,4)]]))-lastrow
			ab<-trait_matrix[5,2]<-nrow(na.omit(data[,traits[c(1,2)]]))-abc-abd-lastrow
			ac<-trait_matrix[6,2]<-nrow(na.omit(data[,traits[c(1,3)]]))-abc-acd-lastrow
			ad<-trait_matrix[7,2]<-nrow(na.omit(data[,traits[c(1,4)]]))-abd-acd-lastrow
			bc<-trait_matrix[8,2]<-nrow(na.omit(data[,traits[c(2,3)]]))-abc-bcd-lastrow
			bd<-trait_matrix[9,2]<-nrow(na.omit(data[,traits[c(2,4)]]))-abd-bcd-lastrow
			cd<-trait_matrix[10,2]<-nrow(na.omit(data[,traits[c(3,4)]]))-acd-bcd-lastrow
			trait_matrix[1,2]<-length(na.omit(data[,traits[1]]))-ab-ac-ad-abc-abd-acd-lastrow
			trait_matrix[2,2]<-length(na.omit(data[,traits[2]]))-ab-bc-bd-abc-abd-bcd-lastrow
			trait_matrix[3,2]<-length(na.omit(data[,traits[3]]))-ac-bc-cd-abc-acd-bcd-lastrow
			trait_matrix[4,2]<-length(na.omit(data[,traits[4]]))-ad-bd-cd-abd-acd-bcd-lastrow
		} else if (length(traits)==5){
			lastrow<-trait_matrix[31,2]<-nrow(na.omit(data[,traits[c(1,2,3,4,5)]]))
			abcd<-trait_matrix[26,2]<-nrow(na.omit(data[,traits[c(1,2,3,4)]]))-lastrow
			abce<-trait_matrix[27,2]<-nrow(na.omit(data[,traits[c(1,2,3,5)]]))-lastrow
			abde<-trait_matrix[28,2]<-nrow(na.omit(data[,traits[c(1,2,4,5)]]))-lastrow
			acde<-trait_matrix[29,2]<-nrow(na.omit(data[,traits[c(1,3,4,5)]]))-lastrow
			bcde<-trait_matrix[30,2]<-nrow(na.omit(data[,traits[c(2,3,4,5)]]))-lastrow
			abc<-trait_matrix[16,2]<-nrow(na.omit(data[,traits[c(1,2,3)]]))-abcd-abce-lastrow
			abd<-trait_matrix[17,2]<-nrow(na.omit(data[,traits[c(1,2,4)]]))-abcd-abde-lastrow
			abe<-trait_matrix[18,2]<-nrow(na.omit(data[,traits[c(1,2,5)]]))-abce-abde-lastrow
			acd<-trait_matrix[19,2]<-nrow(na.omit(data[,traits[c(1,3,4)]]))-abcd-acde-lastrow
			ace<-trait_matrix[20,2]<-nrow(na.omit(data[,traits[c(1,3,5)]]))-abce-acde-lastrow
			ade<-trait_matrix[21,2]<-nrow(na.omit(data[,traits[c(1,4,5)]]))-abde-acde-lastrow
			bcd<-trait_matrix[22,2]<-nrow(na.omit(data[,traits[c(2,3,4)]]))-abcd-bcde-lastrow
			bce<-trait_matrix[23,2]<-nrow(na.omit(data[,traits[c(2,3,5)]]))-abce-bcde-lastrow
			bde<-trait_matrix[24,2]<-nrow(na.omit(data[,traits[c(2,4,5)]]))-abde-bcde-lastrow
			cde<-trait_matrix[25,2]<-nrow(na.omit(data[,traits[c(3,4,5)]]))-acde-bcde-lastrow
			ab<-trait_matrix[6,2]<-nrow(na.omit(data[,traits[c(1,2)]]))-abcd-abce-abde-abc-abd-abe-lastrow
			ac<-trait_matrix[7,2]<-nrow(na.omit(data[,traits[c(1,3)]]))-abcd-abce-acde-abc-acd-ace-lastrow
			ad<-trait_matrix[8,2]<-nrow(na.omit(data[,traits[c(1,4)]]))-abcd-abde-acde-abd-acd-ade-lastrow
			ae<-trait_matrix[9,2]<-nrow(na.omit(data[,traits[c(1,5)]]))-abce-abde-acde-abe-ace-ade-lastrow
			bc<-trait_matrix[10,2]<-nrow(na.omit(data[,traits[c(2,3)]]))-abcd-abce-bcde-abc-bcd-bce-lastrow
			bd<-trait_matrix[11,2]<-nrow(na.omit(data[,traits[c(2,4)]]))-abcd-abde-bcde-abd-bcd-bde-lastrow
			be<-trait_matrix[12,2]<-nrow(na.omit(data[,traits[c(2,5)]]))-abce-abde-bcde-abe-bce-bde-lastrow
			cd<-trait_matrix[13,2]<-nrow(na.omit(data[,traits[c(3,4)]]))-abcd-acde-bcde-acd-bcd-cde-lastrow
			ce<-trait_matrix[14,2]<-nrow(na.omit(data[,traits[c(3,5)]]))-abce-acde-bcde-ace-bce-cde-lastrow
			de<-trait_matrix[15,2]<-nrow(na.omit(data[,traits[c(4,5)]]))-abde-acde-bcde-ade-bde-cde-lastrow
			trait_matrix[1,2]<-length(na.omit(data[,traits[1]]))-abcd-abce-abde-acde-abc-abd-abe-acd-ace-ade-ab-ac-ad-ae-lastrow
			trait_matrix[2,2]<-length(na.omit(data[,traits[2]]))-abcd-abce-abde-bcde-abc-abd-abe-bcd-bce-bde-ab-bc-bd-be-lastrow
			trait_matrix[3,2]<-length(na.omit(data[,traits[3]]))-abcd-abce-acde-bcde-abc-acd-ace-bcd-bce-cde-ac-bc-cd-ce-lastrow
			trait_matrix[4,2]<-length(na.omit(data[,traits[4]]))-abcd-abde-acde-bcde-abd-acd-ade-bcd-bde-cde-ad-bd-cd-de-lastrow
			trait_matrix[5,2]<-length(na.omit(data[,traits[5]]))-abce-abde-acde-bcde-abe-ace-ade-bce-bde-cde-ae-be-ce-de-lastrow
		}
		colnames(trait_matrix)<-c('Trait Overlap','Combinations')
		if(plot==TRUE){
			venn<-venn_overlap(trait_matrix)
			plot(venn)
		}
		return(trait_matrix)
}

venn_overlap<-function(trait_matrix, ...){
	if(nrow(trait_matrix)==1){
		warning('Cannot plot overlap of one trait! See matrix for number of traits in this category.')
	}else if(nrow(trait_matrix)==3){
		venn<-euler(combinations=c("A"=as.numeric(trait_matrix[1,2]), "B"=as.numeric(trait_matrix[2,2]), "A&B"=as.numeric(trait_matrix[3,2])))
		plot(venn, counts=TRUE, fill=gg_colour_hue(2), fill_opacity=0.6, labels=c(trait_matrix[1:2,1]))
	} else if(nrow(trait_matrix)==7){
		venn<-euler(combinations=c("A"=as.numeric(trait_matrix[1,2]), "B"=as.numeric(trait_matrix[2,2]), "C"=as.numeric(trait_matrix[3,2]), "A&B"=as.numeric(trait_matrix[4,2]), "A&C"=as.numeric(trait_matrix[5,2]), "B&C"=as.numeric(trait_matrix[6,2]), "A&B&C"=as.numeric(trait_matrix[7,2])))
		plot(venn, counts=TRUE, fill=gg_colour_hue(3), fill_opacity=0.6, labels=c(trait_matrix[1:3],1))
	} else if(nrow(trait_matrix)==15){
		venn<-euler(combinations=c("A"=as.numeric(trait_matrix[1,2]), "B"=as.numeric(trait_matrix[2,2]), "C"=as.numeric(trait_matrix[3,2]), "D"=as.numeric(trait_matrix[4,2]), "A&B"=as.numeric(trait_matrix[5,2]), "A&C"=as.numeric(trait_matrix[6,2]), "A&D"=as.numeric(trait_matrix[7,2]), "B&C"=as.numeric(trait_matrix[8,2]), "B&D"=as.numeric(trait_matrix[9,2]), "C&D"=as.numeric(trait_matrix[10,2]), "A&B&C"=as.numeric(trait_matrix[11,2]), "A&B&D"=as.numeric(trait_matrix[12,2]), "A&C&D"=as.numeric(trait_matrix[13,2]), "B&C&D"=as.numeric(trait_matrix[14,2]), "A&B&C&D"=as.numeric(trait_matrix[15,2])))
		plot(venn, counts=TRUE, fill=gg_colour_hue(4), fill_opactiy=0.6, labels=c(trait_matrix[1:4,1]))
	} else if(nrow(trait_matrix)==31){
		venn<-euler(combinations=c("A"=as.numeric(trait_matrix[1,2]), "B"=as.numeric(trait_matrix[2,2]), "C"=as.numeric(trait_matrix[3,2]), "D"=as.numeric(trait_matrix[4,2]), "E"=as.numeric(trait_matrix[5,2]), "A&B"=as.numeric(trait_matrix[6,2]), "A&C"=as.numeric(trait_matrix[7,2]), "A&D"=as.numeric(trait_matrix[8,2]), "A&E"=as.numeric(trait_matrix[9,2]), "B&C"=as.numeric(trait_matrix[10,2]), "B&D"=as.numeric(trait_matrix[11,2]), "B&E"=as.numeric(trait_matrix[12,2]), "C&D"=as.numeric(trait_matrix[13,2]), "C&E"=as.numeric(trait_matrix[14,2]), "D&E"=as.numeric(trait_matrix[15,2]), "A&B&C"=as.numeric(trait_matrix[16,2]), "A&B&D"=as.numeric(trait_matrix[17,2]), "A&B&E"=as.numeric(trait_matrix[18,2]), "A&C&D"=as.numeric(trait_matrix[19,2]), "A&C&E"=as.numeric(trait_matrix[20,2]), "A&D&E"=as.numeric(trait_matrix[21,2]), "B&C&D"=as.numeric(trait_matrix[22,2]), "B&C&E"=as.numeric(trait_matrix[23,2]), "B&D&E"=as.numeric(trait_matrix[24,2]), "C&D&E"=as.numeric(trait_matrix[25,2]), "A&B&C&D"=as.numeric(trait_matrix[26,2]), "A&B&C&E"=as.numeric(trait_matrix[27,2]), "A&B&D&E"=as.numeric(trait_matrix[28,2]), "A&C&D&E"=as.numeric(trait_matrix[29,2]), "B&C&D&E"=as.numeric(trait_matrix[30,2]), "A&B&C&D&E"=as.numeric(trait_matrix[31,2])))
		plot(venn, counts=TRUE, fill=gg_colour_hue(5), fill_opacity=0.6, labels=c(trait_matrix[1:5,1]))
	}
}