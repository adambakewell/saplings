# trim tree and set branch lengths = 1

trim_equal_branch<-function(tree, species) {
	matches<-match(tree$tip.label, species, nomatch=0)
	trimmed_tree<-drop.tip(tree, subset(tree$tip.label, matches==0))
	trimmed_tree$edge.length<-rep(1, nrow(trimmed_tree$edge))
	return(trimmed_tree)
}
