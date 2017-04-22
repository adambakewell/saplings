u_in_tree<-function(tree, species){
	treesp<-tree$tip.label
	inphy<-species %in% treesp
	mm<-matrix(nrow=length(species), ncol=2)
	colnames(mm)<-c('Species', 'In Phylogeny?')
	mm[,1]<-species
	mm[,2]<-inphy
	print(mm)
}