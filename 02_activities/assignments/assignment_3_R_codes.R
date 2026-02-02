library(dplyr)
library(ggplot2)

df <- read.csv("~/Downloads/Licensed Dogs and Cats.csv") #Imported the dataset as df

df<- df %>%
  filter(ANIMAL_TYPE == "DOG") #I choose to focus on the dogs for this visualization

df_summary<- df %>%
  group_by(PRIMARY_BREED) %>%
  count() #summarize the dataset by primary breeds, i.e how many dogs of each breed

df_summary_top <- df_summary %>%
  ungroup() %>%
  arrange(desc(`n`)) %>%
  slice_head(n = 10)
#Because there's so many breeds, I will focus on the top 10 most "popular" breeds

plot<- ggplot(df_summary_top, aes(x = reorder(PRIMARY_BREED, n), y = n,fill = PRIMARY_BREED)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Dog Breeds in Lisenced Dogs in the city of Toronto from 2023-2026 (Jan.31st)",
    x = "Primary breed",
    y = "Number of dogs"
  ) +
  theme_minimal()+
  scale_fill_brewer(palette = "Set3") +
  theme(legend.position = "none")

ggsave("top10_breeds.png", plot =plot , width = 10, height = 5, units = "in", dpi = 300)
