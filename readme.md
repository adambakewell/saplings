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

## Examples

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

The `trim_equal_branch()` function trims a phylogeny to fit a dataset, mainly for visualisation, it also sets equal branch lengths so that it can be used in comparative analysis.

```r
# simulate a phylogeny with no branch lengths
tree<-rtree(20, br=NULL, tip.label=LETTERS[1:20])

# simulate a dataset, here with only species called the second letters from A to T
Species<-LETTERS[seq(1, 20, by=2)]
trait1<-c(1,5,3,2,NA,1,8,NA,NA,10)
trait2<-c(NA,4,2,2,1,3,NA,NA,1,2)
data<-data.frame(Species, trait1, trait2)

# use function to trim phylogeny to dataset and set equal branch lengths
new_tree<-trim_equal_branch(tree=tree, species=data$Species)

# show old tree compared to new tree
par(mfrow=c(1,2))
plot(tree) ; text('before', x=2, y=20, font=2)
plot(new_tree); text('after', x=0.5, y=10, font=2)
```

![plot comparing trees before and after the function](figures/trim_equal_branch.png)