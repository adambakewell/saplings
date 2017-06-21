# saplings

This package is just all of the functions that I’ve created and that I use on a regular basis. In my mind they speed up components of a phylogenetic comparative workflow, e.g. seeing which species are in a tree, visualising the distribution of traits, trimming datasets to phylogenies.

## Instillation

Install straight from GitHub development page

```r
install.packages("devtools")
library(devtools)

install_github("adambakewell/saplings")
library(saplings)
```

## Latest updates
* Version 0.0-4: [New function phylo_barplot()](#phylo_barplot) under development.
* Version 0.0-3: [Replaced trim_equal_branch() function with trim_tree()](#trim_tree) so that the function no longer automatically sets branch as equal.
* Version 0.0-2: [New function trait_overlap()](#trait_overlap), if you give this function a list of traits (or other variables in a data frame where rows are cases) and will return a matrix (and a Venn diagram if you want one!) of the overlap between different traits.

## Contents
* [u_in_tree()](#u_in_tree)
* [tips_with_traits()](#tips_with_traits)
* [trim_to_phy()](#trim_to_phy)
* [trim_tree()](#trim_tree)
* [trait_overlap()](#trait_overlap)
* [phylo_barplot()](#phylo_barplot) (currently under development!)

## Examples
### u_in_tree
The `u_in_tree()` function allows you to quickly see whether a species or a list of species are within the phylogeny that you are using

```r
tree<-rtree(n=10, tip.label=LETTERS[1:10])		# simulate tree
u_in_tree(tree=tree, species=c('A','B','C','X','Y','Z'))   # ask whether it contains list of species

     Species In Phylogeny?
[1,] "A"     "TRUE"       
[2,] "B"     "TRUE"       
[3,] "C"     "TRUE"       
[4,] "X"     "FALSE"      
[5,] "Y"     "FALSE"      
[6,] "Z"     "FALSE"      
```

### tips_with_traits
The `tips_with_traits()` function allows you to visualise which tips on a phylogeny contain a trait of a combination of different traits

```r
# simulate tree
tree<-rtree(n=10, tip.label=LETTERS[1:10])

# and a data frame similar to one used for comparative analyses
Species<-LETTERS[1:10]
# if you leave your column with names in as Species then tips_with_traits will automatically match 
# species names to names on the phylogeny, otherwise specify names.col="my species column name" 
# in the main command
trait1<-c(1,5,3,2,NA,1,8,NA,NA,10)
trait2<-c(NA,4,2,2,1,3,NA,NA,1,2)
data<-data.frame(Species, trait1, trait2)

tips_with_traits(traits='trait1', data=data, tree=tree)
```

![plot with one trait](figures/tips_with_traits1.png)

```r
# now an example with multiple traits, so it shows how a combination of traits going into a PGLS
# are distributed for example... instead of colouring the names you can mark the tips with dots.
tips_with_traits(traits=c('trait1', 'trait2'), data=data, tree=tree, ptype='tips', pres.col='green')
```

![plot with multiple traits](figures/tips_with_traits2.png)

### trim_to_phy
It can be easy to forget to trim your original dataset to match the phylogeny. This is important when it comes to plotting figures, as if your species aren’t in the phylogeny then they won’t be in the model! The `trim_to_phy()` function does this in one step.

```r
# simulate a data frame as before
Species<-LETTERS[1:10]										
trait1<-c(1,5,3,2,NA,1,8,NA,NA,10)
trait2<-c(NA,4,2,2,1,3,NA,NA,1,2)
data<-data.frame(Species, trait1, trait2)

# simulate a tree
tree<-rtree(10, tip.label=LETTERS[seq(1, 20, by=2)])
LETTERS[seq(1, 20, by=2)]
# tree contains species called every second letter: A, C, E, G, I, K, M, O, Q, S... Data
# frame contains species called the first 10 letters of the alpahabet, those not
# matching the phylogeny (e.g. B, D...) should be removed before plotting

# data frame before
print(data)

   Species trait1 trait2
1        A      1     NA
2        B      5      4
3        C      3      2
4        D      2      2
5        E     NA      1
6        F      1      3
7        G      8     NA
8        H     NA     NA
9        I     NA      1
10       J     10      2

# trim data frame
trimmed_data<-trim_to_phy(data=data, tree=tree)
print(trimmed_data)

  Species trait1 trait2
1       A      1     NA
3       C      3      2
5       E     NA      1
7       G      8     NA
9       I     NA      1
```

### trim_tree
The `trim_tree()` function trims a phylogeny to fit a dataset, mainly for visualisation but also required for example for ancestral state reconstruction in ape. Choosing `set.equal.branches=TRUE` will also add branch lengths of one to a phylogeny.

```r
# simulate a phylogeny with no branch lengths
tree<-rtree(20, br=NULL, tip.label=LETTERS[1:20])

# simulate a dataset, here with only species called the second letters from A to T
Species<-LETTERS[seq(1, 20, by=2)]
trait1<-c(1,5,3,2,NA,1,8,NA,NA,10)
trait2<-c(NA,4,2,2,1,3,NA,NA,1,2)
data<-data.frame(Species, trait1, trait2)

# use function to trim phylogeny to dataset and set equal branch lengths
new_tree<-trim_tree(tree=tree, species=data$Species, set.equal.branches=TRUE)

# show old tree compared to new tree
par(mfrow=c(1,2))
plot(tree) ; text('before', x=2, y=20, font=2)
plot(new_tree); text('after', x=0.5, y=10, font=2)
```

![plot comparing trees before and after the function](figures/trim_equal_branch.png)

### trait_overlap
The `trait_overlap()` function, given a list of traits that you want to see the overlap of and the data frame which they belong in, returns a matrix showing the overlap of different traits. This is useful in comparative studies when looking at the sample sizes in models with multiple predictors, but is applicable to a wide range of analyses. Choosing `plot=TRUE` will also create a venn diagram using the package `eulerr`, although as a warning using over 3 traits at a time with this can be difficult to view. Currently `trait_overlap()` supports up to five traits simultaneously.

```r
# simulate some data with missing values
trait1<-c(1,5,3,2,NA,1,8,NA,NA,10,2,5,6,NA,NA,NA)
trait2<-c(NA,4,2,2,1,3,NA,NA,1,2,NA,NA,NA,11,NA,NA)
trait3<-c(2,3,NA,4,NA,NA,8,3,9,11,NA,NA,NA,NA,12,4)
data<-data.frame(trait1, trait2, trait3)

# now run the function on the selected traits
trait_overlap(traits=c('trait1', 'trait2', 'trait3’), data=data, plot=TRUE)

     Trait Overlap          Combinations
[1,] "trait1"               "3"         
[2,] "trait2"               "1"         
[3,] "trait3"               "3"         
[4,] "trait1&trait2"        "2"         
[5,] "trait1&trait3"        "2"         
[6,] "trait2&trait3"        "1"         
[7,] "trait1&trait2&trait3" "3" 
```

![venn diagram showing overlap of traits using the trait overlap function](figures/trait_overlap.png)

### phylo_barplot
The `phylo_barplot()` function creates barplots using the output of PGLS models. Standard plots will show the mean and standard error (or deviation etc.) of the raw data, rather than the phylogenetically adjusted data. This function takes the estimates and standard deviations straight from the models and plots these instead. It can make it easier to see why relationships in the data are non-significant.

```r
data(chickwts)		# load chickwts from the selection of datasets in R. We’re going to pretend that individuals are different species just as an example
data<-as.data.frame(chickwts)

tree<-pbtree(n=71) 		# simulate a phylogeny for the chickens
data$Species<-tree$tip.label	# add column of species 'names'

comp<-comparative.data(data=data, phy=tree, names.col='Species', na.omit=F, vcv=T)		# create comparative object for PGLS

model<-pgls(weight~feed, data=comp, lambda=0.75)	# I’m fixing lambda at 0.75 so that the phylogenetic means are different from the raw means (if the ML value of lambda is not 0 then they will be in your analysis too!)
summary(model)

Call:
pgls(formula = weight ~ feed, data = comp, lambda = 0.75)

Residuals:
    Min      1Q  Median      3Q     Max 
-137.77  -31.49  -11.87   19.35   71.20 

Branch length transformations:

kappa  [Fix]  : 1.000
lambda [Fix]  : 0.750
delta  [Fix]  : 1.000

Coefficients:
              Estimate Std. Error t value  Pr(>|t|)    
(Intercept)    338.919     37.874  8.9485 6.102e-13 ***
feedhorsebean -192.695     57.936 -3.3260  0.001452 ** 
feedlinseed   -105.226     55.995 -1.8792  0.064700 .  
feedmeatmeal   -79.300     33.646 -2.3569  0.021452 *  
feedsoybean   -119.604     48.279 -2.4773  0.015846 *  
feedsunflower  -12.848     48.334 -0.2658  0.791214    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 43.3 on 65 degrees of freedom
Multiple R-squared: 0.2696,	Adjusted R-squared: 0.2134 
F-statistic: 4.798 on 5 and 65 DF,  p-value: 0.0008564 


# now we can compare the barplots for raw and phylogenetic data
par(mfrow=c(1,2))
# first raw means and standard errors
meansWeight<-tapply(data$weight, data$feed, mean)
serrsWeight<-tapply(data$weight, data$feed, function(x) sd(x)/sqrt(length(x)))

non.phy<-barplot(meansWeight, ylim=c(0,400), xlab='Feed Type', ylab='Weight', cex.lab=1.3, col='lightsteelblue')
arrows(non.phy, meansWeight, non.phy, meansWeight+serrsWeight, angle=90)
arrows(non.phy, meansWeight, non.phy, meansWeight-serrsWeight, angle=90)
mtext('(a)', font=2, adj=0, cex=1.5, padj=-1)

# now lets plot the phylogenetic version
names=c('casein','horsebean','linseed','meatmeal','soybean', 'sunflower')	# I am working on a way to get this done automatically within the function
phylo_barplot(model, ylim=c(0,400), xlab='Feed Type', ylab='Weight', cex.lab=1.3, col='lightseagreen', names.arg=names)
mtext('(b)', font=2, adj=0, cex=1.5, padj=-1)
```
Hopefully you can see that the phylogenetic verison (b) shows the uncertainty around the means, and the lower level of significance between some levels!

![comparison between raw means and standard errors and phylogenetic means and standard errors](figures/phylobar.png)
