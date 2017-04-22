tips_with_traits<-function(traits, data, tree, ptype='names', names.col='Species', abs.col='black', pres.col='red', ...) {
	ft_data<-data[,c(names.col,traits)]
	ft_data<-na.omit(ft_data)
	ft_species<-ft_data[,1]
	colvec<-rep(abs.col, length(tree$tip.label))
	for(i in 1:length(tree$tip.label)) {
		if(tree$tip.label[i] %in% ft_species)
		{colvec[i]<-pres.col}
	}
	if(ptype=='names'){
		plot(tree, tip.color=colvec, ...)
	} else if(ptype=='tips') {
		plot(tree, show.tip.label=FALSE, ...)
		tiplabels(pch=16, col=colvec, ...)
	} else print('Error: incorrect type of plot requested! Viable options are names, which colours the names of the species on the tree, or tips, which adds a coloured circle on the end of the tips with traits')
}
