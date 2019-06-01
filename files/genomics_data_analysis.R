library(tidyverse)

variants <- read_csv("../r_data/combined_tidy_vcf.csv")

## select()

select(variants, sample_id, REF, ALT, DP)
select(variants, -CHROM)
select(variants, ends_with("B"))
select(variants, 1, 5:8) # don't do this

## Create a data frame, that contains:
## - all the columns that contain the letter "i"
## - the column POS
## - but not the column "Indiv"
## Hint: look at the help for ?ends_with

select(variants, POS, contains("i"), -Indiv)

## filter()

filter(variants, sample_id == "SRR2584863")
filter(variants, REF %in% c("T", "G"))
filter(variants, QUAL > 100)
filter(variants, INDEL)
filter(variants, !is.na(IDV))

filter(variants, sample_id == "SRR2584863",
       QUAL > 100, INDEL, !is.na(IDV))

filter(variants, sample_id == "SRR2584863" &
       (QUAL > 100 | INDEL))

## Exercise
##
## select all the mutations that occurred between
## the position (POS) 1e6 and 2e6, that are not
## indels, and have a quality score (QUAL) > 200

filter(variants,
       POS>1E6 & POS<2E6, QUAL > 200, !INDEL)

## Pipes

# the pipe is %>% (Crtl + Shift + M)

filter(variants, sample_id == "SRR2584863")

variants %>% 
  filter(sample_id == "SRR2584863") %>% 
  select(sample_id, POS, REF, ALT, QUAL)

variants_SRR2584863 <- variants %>% 
  filter(sample_id == "SRR2584863") %>% 
  select(sample_id, POS, REF, ALT, QUAL)

## Exercise
##
## use the pipe operator to create a data frame
## with the columns sample_id, REF and ALT
## with all the mutations that are not indels,
## and have a quality score > 200
## save it in a new variable called 'point_mutations'

point_mutations <- variants %>% 
  filter(QUAL > 200, !INDEL) %>% 
  select(sample_id, REF, ALT) 


## mutate()

variants %>% 
  mutate(POLPROB = 1 - (10 ^ -(QUAL/10)))

variants_indel <- variants %>% 
  mutate(indel_size = nchar(REF) - nchar(ALT),
         mutation_type = case_when(
           indel_size < 0 ~ "insertion",
           indel_size > 0 ~ "deletion",
           indel_size == 0 ~ "point",
           TRUE ~ ""
         ))

filter(variants_indel, mutation_type == "")


## group_by()

variants_indel %>% 
  group_by(mutation_type) %>% 
  summarize(
    mean_size = abs(mean(indel_size)),
    median_size = abs(median(indel_size))
  )

## Exercise
##
## What are the largest deletion and insertion in 
## our dataset?

variants_indel %>%
  group_by(mutation_type) %>% 
  summarize(max_size = max(abs(indel_size)))


variants_indel %>%
  group_by(mutation_type) %>% 
  summarize(
    n = n()
  )

variants_indel %>% 
  count(mutation_type)

## Exercises
##
## 1. how many mutations are observed in each sample?

variants_indel %>% 
  count(sample_id)

## 2. how many of each type of mutations are observed
##    in each sample?

variants_indel %>% 
  group_by(sample_id) %>% 
  count(mutation_type)

variants_indel %>% 
  count(sample_id, mutation_type)

## make this table wide
variants_wide <- variants_indel %>% 
  count(sample_id, mutation_type) %>% 
  spread(mutation_type, n)

## make this table long again
variants_wide %>% 
  gather(mutation_type, n, -sample_id)

write_csv(variants_indel, "variants_indel.csv")

## Data visualisation

ggplot(variants_indel, aes(x = POS, y = DP)) +
  geom_point()

ggplot(variants_indel, aes(x = POS, y = DP)) +
  geom_point(alpha = .3)

ggplot(variants_indel, aes(x = POS, y = DP)) +
  geom_point(alpha = .3, position = "jitter",
             color = "peru")


ggplot(variants_indel,
       aes(x = POS, y = DP, color = sample_id)) +
  geom_point(alpha = .3, position = "jitter")


## Exercise
##
## make a boxplot that shows the quality (QUAL)
## for each type of mutation
## (geom_boxplot)

ggplot(variants_indel,
       aes(x=mutation_type, y=QUAL)) +
  geom_boxplot(
    aes(fill = mutation_type,
        color = mutation_type),
               alpha = .2) +
  geom_point(
    aes(color=mutation_type),
    position="jitter", alpha=.4) +
  scale_color_viridis_d() +
  ylim(c(0, 500))

## bar plots

ggplot(variants_indel, aes(x = sample_id)) +
  geom_bar()

variants_indel %>% 
  count(sample_id) %>% 
  ggplot(aes(x = sample_id, y = n)) +
  geom_bar(stat="identity")

variants_indel %>% 
  count(sample_id) %>% 
  ggplot(aes(x = sample_id, y = n)) +
  geom_col() +
  labs(
    x = "Sample ID",
    y = "Number of mutations",
    title = "E. coli mutations",
    subtitle = "This is only based on a subset of the data",
    caption = "this is a biased sample"
  )

## to learn more about ggplot2: https://ggplot2.tidyverse.org/ 
## http://www.cookbook-r.com/Graphs/