# trim dataset to phylogeny
trim_to_phy<-function(data, tree, Species='Species') {
	matches<-match(data$Species, tree$tip.label, nomatch=0)
	tree_data<-subset(data, matches!=0)
	return(tree_data)
}