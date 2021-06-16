library(tidyverse)

col_names <- c("ID", "md5sum")
long <- tibble(Genome = c("human_g1k_v37_decoy", "Homo_sapiens_assembly19", "Homo_sapiens_assembly38", "GRCh38_no_alt_analysis_set", "ucsc.hg19"),
        Version = c("hg19", "hg19", "hg38", "hg38", "hg19")) %>%
    group_by(Genome, Version) %>%
    summarize(read_tsv(str_glue("data/{Genome}.tsv"), col_names=col_names)) %>%
    mutate(ID = str_remove(ID, "^chr"), ID = ifelse(ID == "M", "MT", ID))

write_csv(long, "results/genome_md5sum_long.csv")

long %>%
    filter(Version == "hg19") %>%
    pivot_wider(id_cols = ID, names_from = Genome, values_from = md5sum) %>%
    write_csv("results/genome_md5sum_wide.hg19.csv")

long %>%
    filter(Version == "hg38") %>%
    pivot_wider(id_cols = ID, names_from = Genome, values_from = md5sum) %>%
    write_csv("results/genome_md5sum_wide.hg38.csv")
