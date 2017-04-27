# trim tree

trim_tree<-function(tree, species, set.equal.branches=FALSE) {
	matches<-match(tree$tip.label, species, nomatch=0)
	trimmed_tree<-drop.tip(tree, subset(tree$tip.label, matches==0))
	if(set.equal.branches==TRUE){
		trimmed_tree$edge.length<-rep(1, nrow(trimmed_tree$edge))
	}
	return(trimmed_tree)
}
