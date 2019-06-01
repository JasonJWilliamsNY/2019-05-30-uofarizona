
# Find your working directory 
getwd()

#Set my working directoy to a specfic location
# Usually a bad idea to have this in a script
setwd("/docker-persistant/dcuser/dc_genomics_r/")


# Show session info
sessionInfo()

# round function
round(3.14)

# Find out how a function
?round()

# Find out what arguments (inputs/parameters) a function takes
args(round)

# Use the round function, change the digits argument

round(3.14159, digits = 2)

round(3.14159,2)

round()

# Getting help about an unknown function
??geom_point()

#How do I do a t test
help.search("chi square")

# Creating objects in R

a <- 1
b <- 2

human_chr_pairs <- 23
fav_gene <- "sry"
genome_url <- "ftp://ftp.ensemblgenomes.org/pub/bacteria/release-39/fasta/bacteria_5_collection/escherichia_coli_b_str_rel606/"
human_diploid <- 46

fav_gene <- "pten"

#delete an object
rm(fav_gene)

# Checking modes
chromosome_name <- 'chr02'
mode(chromosome_name)

od_600_value <- 0.47
chr_position <- '1001701'
spock <- TRUE
pilot<-"Earhart"


#Math and objects


(1 +(5**0.5))/2

#numerics objects can be operated on w math operators
human_chr_pairs *2

#putting a few functions together

round(((1+sqrt(5))/2),3)

# Creating a vector

snp_genes <- c("OXTR", "ACTN3", "AR", "OPRM1")
mode(snp_genes)
length(snp_genes)

# Check the structure of an object
str(snp_genes)

# create a few more vectors
snps <- c('rs53576', 'rs1815739', 'rs6152', 'rs1799971')
snp_chromosomes <- c('3', '11', 'X', '6')
snp_positions <- c(8762685, 66560624, 67545785, 154039662)

# get the 3rd object in a vector

snp_genes[3]

#get a range of values
snp_genes[1:3]

# get arbitrary values from a vector
snp_genes[c(1,3,4)]

# add to exsiting vector
snp_genes <- c(snp_genes, "CYP1A1", "APOA5")

# return a vector without particular values
snp_genes[-6]

snp_genes <- snp_genes[-6]

# Add a new value 
snp_genes[[7]] <- "APOA5"
snp_genes

#logical subsetting 

snp_positions[snp_positions>100000000]

# logical operation on a vector
snp_positions > 100000000
snp_positions
?which()
which(snp_positions > 100000000)

snp_marker_cutoff <- 100000000
snp_positions[snp_positions>snp_marker_cutoff]

# checks if ther are any NA values
snp_genes
is.na(snp_genes)

# if a value is present in a vector of values
c("ACTN3", "APOA5") %in% snp_genes

snp_genes
snp_genes <- c(snp_genes[c(1:5)], snp_genes[7])
snp_genes
snp_genes <- c("OXTR", "ACTN3", "AR", "OPRM1", "CYP1A1", NA, "APOA5")

(snp_genes %in% "CYP1A1")
!(snp_genes %in% "CYP1A1")
snp_genes <- snp_genes[!(snp_genes %in% "CYP1A1")]
snp_genes

# Working with tabular data

?read.csv

# reading in a file

varients <- read.csv("../r_data/combined_tidy_vcf.csv")

# get a summary of my dataset

summary(varients)

# get the structure of the dataframe

str(varients)

# create the REF objct

REF <- varients$REF
str(REF)

head(REF)

# Create a plot of REF

plot(REF)

varients[,3]

length(varients[varients$REF == "A",])

#Coercing values

snp_chromosomes
typeof(snp_chromosomes)

snp_positions_2 <- c("8762685", "66560624", "67545785", "154039662")
typeof(snp_positions_2)

snp_positions_2 <- as.numeric(snp_positions_2)
typeof(snp_positions_2)
snp_positions_2[1]

#Try to coerce a vector with chr and num
snp_chromosomes_2 <- as.numeric(snp_chromosomes)
snp_chromosomes_2

#When things go wrong
typeof(varients$sample_id)
str(varients$sample_id)
as.numeric(varients$sample_id)

# Change the mode of a single variable (column)
str(varients$REF)
varients$REF <- as.character(varients$REF)
str(varients$REF)

#writing csv file
write.csv(varients, file = "../dc_genomics_r/varients_demo.csv")














