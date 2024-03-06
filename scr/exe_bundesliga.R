# In dfb.R I analyze German soccer results

# set working directory
# setwd("~/Dropbox/hsf/23-ws/dsda/scripts")

# clear environment
rm(list = ls())

# (Install and) load packagages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(
  bundesligR,
  tidyverse
  )

# Read in the data as tibble
liga <- as_tibble(bundesligR)

# --------------------------------------
# !!! ERRORS / ISSUES:
# "Borussia Moenchengladbach" is also entitled "Bor. Moenchengladbach"!
# Leverkusen is falsly entitled "SV Bayer 04 Leverkusen"
# Uerdingen has changed its name several times
# Stuttgarter Kickers are named differently 

# How often is "Bor. Moenchengladbach" in the data?
sum(liga$Team == "Bor. Moenchengladbach")

# show the entries
liga |> 
  filter(Team == "Bor. Moenchengladbach")  

# Replace "Bor. Moenchengladbach" with "Borussia Moenchengladbach"
liga <- liga |> 
  mutate(Team = ifelse(Team == "Bor. Moenchengladbach", 
                       "Borussia Moenchengladbach", 
                       Team)) |> 
  mutate(Team = ifelse(Team == "SV Bayer 04 Leverkusen", 
                       "TSV Bayer 04 Leverkusen", 
                       Team)) |> 
  mutate(Team = ifelse(Team == "FC Bayer 05 Uerdingen" 
                       | Team == "Bayer 05 Uerdingen" , 
                       "KFC Uerdingen 05", 
                       Team)) |> 
  mutate(Team = ifelse(Team == "SV Stuttgarter Kickers", 
                       "Stuttgarter Kickers", 
                       Team)) 

# ------------------------------------

# Check for the data class
class(liga)

# view data
view(liga)

# Glimpse on the data
glimpse(liga)

# first and last observations
head(liga)
tail(liga)

# summary statistics
summary(liga)

# How many teams have played in the league over the years?
table(liga$Season)

# Which teams have played Bundesliga
unique(liga$Team)

# How many teams have played Bundesliga
n_distinct(liga$Team)

# How often has each team played in the Bundesliga
table(liga$Team)

# summary of variable Season only
summary(liga$Season)

# summary of numeric of variables (Team is a character)
liga |> 
  select(Season, Position, Played, W, D, L, GF, GA, GD, Points, Pts_pre_95) |> 
  summary()

# shorter alternative
liga |> 
  select(Season, Position, Played:Pts_pre_95) |> 
  summary()

# shortest alternative
liga |> 
  select(-Team) |> 
  filter(Season == 1999 |  Season == 2010) |> 
  summary()

# Most points ever received by a team
liga |> 
  filter(Points == max(Points))

# Show only the team name
liga |> 
  filter(Points == max(Points))|> 
  select(Team) |> 
  print()

# remove the variable `Pts_pre_95` from the data
liga_post95 <- liga |> 
  select(-Pts_pre_95) 
  
# rename W, D, and L to Win, Draw, and Loss
# additionally rename GF, GA, GD to Goals_shot, Goals_received, Goal_difference 
liga_longnames <- liga |> 
  rename(Win = W, Draw = D, Loss = L) |> 
  rename(Goals_shot = GF, Goals_received = GA, Goal_difference = GD)

# Remove the variable `Pts_pre_95` from `liga` 
# additionally remove all observations before the year 1996
liga_no3point <- liga |> 
  select(-Pts_pre_95) |> 
  filter(Season >= 1996)

# Remove the objects liga_post95, liga_longnames, and liga_no3point from the environment
rm(liga_post95, liga_longnames, liga_no3point)

# Rename all variables of `liga`to lower cases and store it as `dfb`
dfb <- liga |> 
  rename_all(tolower)

# Show the winner and the runner up after 2010
# additionally show the points 
dfb |> 
  filter(season > 2010) |> 
  group_by(season) |> 
  arrange(desc(points)) %>%
  slice_head(n = 2) %>%
  select(team, points, position)

# Create a variable that counts how often a team was ranked first
dfb <- dfb |> 
  group_by(team) |> 
  mutate(meister_count = sum(position == 1))

# How often has each team played in the Bundesliga
table(liga$Team)

# Make a ranking
dfb |> 
  group_by(team) |> 
  summarise(appearances = n_distinct(season)) |> 
  arrange(desc(appearances)) |> 
  print(n = Inf)

# Add a variable to `dfb` that contains the number of appearances of a team in the league
dfb <- dfb |> 
  group_by(team) |> 
  mutate(appearances = n_distinct(season))

# create a number that indicates how often a team has played Bundesliga in a given year 
dfb <- dfb |> 
  arrange(team, season) |> 
  group_by(team) |> 
  mutate(team_in_liga_count = row_number())

# Make a ranking with the number of titles of all teams that ever won the league
dfb |> 
  filter(team_in_liga_count == 1) |> 
  filter(meister_count != 0) |> 
  arrange(desc(meister_count)) |> 
  select(meister_count, team)

# Create a numeric identifying variable for each team
dfb_teamid <- dfb |> 
  mutate(team_id = as.numeric(factor(team)))

# When a team is in the league, what is the probability that it wins the league
dfb |> 
  filter(team_in_liga_count == 1) |> 
  mutate(prob_win = meister_count/appearances) |> 
  filter(prob_win > 0) |> 
  arrange(desc(prob_win)) |> 
  select(meister_count, prob_win, team)


# make a scatterplot with points on the y-axis and position on the x-axis
ggplot(dfb, aes(x = position, y = points)) +
  geom_point()

# Make a scatterplot with points on the y-axis and position on the x-axis.
# Additionally, only consider seasons with 18 teams and
# add lines that make clear how many points you needed to be placed 
# in between rank 2 and 15.
dfb_18 <- dfb |> 
  group_by(season) |> 
  mutate(teams_in_league = n_distinct(team)) |> 
  filter(teams_in_league == 18)

h_1 <- dfb_18 |> 
  filter(position == 16) |> 
  mutate(ma = max(points)) 

max_points_rank_16 <- max(h_1$ma) +1

h_2 <- dfb_18 |> 
  filter(position == 2)  |> 
  mutate(mb = max(points))

min_points_rank_2 <- max(h_2$mb) + 1
  
dfb_18 <- dfb_18 |> 
  mutate(season_category = case_when(
    season < 1970 ~ 1,
    between(season, 1970, 1979) ~ 2,
    between(season, 1980, 1989) ~ 3,
    between(season, 1990, 1999) ~ 4,
    between(season, 2000, 2009) ~ 5,
    between(season, 2010, 2019) ~ 6,
    TRUE ~ 7  # Adjust this line based on the actual range of your data
  ))

ggplot(dfb_18, aes(x = position, y = points)) +
  geom_point() +
  labs(title = "Scatterplot of Points and Position",
       x = "Position",
       y = "Points") +
  geom_vline(xintercept = c(1.5, 15.5), linetype = "dashed", color = "red") +
  geom_hline(yintercept = max_points_rank_16, linetype = "dashed", color = "blue") +
  geom_hline(yintercept = min_points_rank_2, linetype = "dashed", color = "blue") +
  scale_y_continuous(breaks = c(min_points_rank_2, max_points_rank_16, seq(0, max(dfb_18$points), by = 5))) +
  scale_x_continuous(breaks = c(seq(0, max(dfb_18$points), by = 1))) +
  theme_classic()


# Remove all objects except liga and dfb
rm(list=setdiff(ls(), c("liga", "dfb")))

# Rank "1. FC Kaiserslautern" over time
dfb_bal <- dfb |> 
  select(season, team, position) |> 
  as_tibble() |> 
  complete(season, team) 

table(dfb_bal$team)

dfb_fck <- dfb_bal |> 
  filter(team == "1. FC Kaiserslautern") 

ggplot(dfb_fck, aes(x = season, y = position)) +
  geom_point() +
  geom_line() +
  scale_y_reverse(breaks = seq(1, 18, by = 1))




# Make the plot nice

# consider different rules for having to leave the league:
dfb_fck <- dfb_fck |> 
  mutate(godown = ifelse(season <= 1964, 14.5, NA)) |> 
  mutate(godown = ifelse(season > 1964 & season <= 1973, 16.5, godown)) |>
  mutate(godown = ifelse(season > 1973 & season <= 1980, 15.5, godown)) |>
  mutate(godown = ifelse(season > 1980 & season <= 1990, 16, godown)) |>
  mutate(godown = ifelse(season == 1991, 16.5, godown)) |>
  mutate(godown = ifelse(season > 1991 & season <= 2008, 15.5, godown)) |>
  mutate(godown = ifelse(season > 2008 , 16, godown))

  
ggplot(dfb_fck, aes(x = season)) +
  geom_point(aes(y = position)) +
  geom_line(aes(y = position)) +
  geom_point(aes(y = godown), shape = 25) +
  scale_y_reverse(breaks = seq(1, 18, by = 1)) + 
  theme_minimal() +
  theme(panel.grid.minor = element_blank()) +
  geom_hline(yintercept = 1.5, linetype = "dashed", color = "blue") 



dfb_bal <- dfb_bal |> 
  mutate(godown = ifelse(season <= 1964, 14.5, NA)) |> 
  mutate(godown = ifelse(season > 1964 & season <= 1973, 16.5, godown)) |>
  mutate(godown = ifelse(season > 1973 & season <= 1980, 15.5, godown)) |>
  mutate(godown = ifelse(season > 1980 & season <= 1990, 16, godown)) |>
  mutate(godown = ifelse(season == 1991, 16.5, godown)) |>
  mutate(godown = ifelse(season > 1991 & season <= 2008, 15.5, godown)) |>
  mutate(godown = ifelse(season > 2008 , 16, godown)) |> 
  mutate(inliga = ifelse(is.na(position), 0, 1))



rank_plot <- ggplot(dfb_bal, aes(x = season)) +
  geom_point(aes(y = position), shape = 1) +
  # geom_line(aes(y = position)) +
  geom_point(aes(y = godown), shape = 25) +
  scale_y_reverse(breaks = seq(1, 20, by = 1) , limits = c(20, 1)) + 
  xlim(1963, 2015) +
  theme(panel.grid.minor = element_blank()) +
  geom_hline(yintercept = 1.5, linetype = "dashed", color = "gray") +
  geom_point(aes(y = position), shape = 1) 

rank_plot
# !--> in 1979 is a gap! Error?
# No. Reason: two clubs shared the third place. 

rank_plot +
  facet_wrap(~team)

# Create "test" directory if it doesn't already exist
if (!dir.exists("test")) {
  dir.create("test")
}


plots <- list()
for (club in unique(dfb_bal$team)) {
  dfb_subset <- subset(dfb_bal, team == club)
  
  p <- ggplot(dfb_subset, aes(x = season)) +
    geom_point(aes(y = position), shape = 15) +
    geom_line(aes(y = position)) +
    geom_point(aes(y = godown), shape = 25) +
    scale_y_reverse(breaks = seq(1, 20, by = 1) , limits = c(20, 1)) + 
    xlim(1963, 2015) +
    theme(panel.grid.minor = element_blank()) +
    geom_hline(yintercept = 1.5, linetype = "dashed", color = "gray") +
    geom_point(aes(y = position), shape = 1) +
    labs(title = paste("Ranking History:", club))
  ggsave(filename=paste("test/r_",club,".png",sep="")) 
  plots[[club]] <- p
}

print(plots$`Meidericher SV`)
print(plots$`1. FC Koeln`)

# unload packages
pacman::p_unload(
  bundesligR,
  tidyverse
)

# Remove the "test" directory and its contents after saving all graphs
unlink("test", recursive = TRUE)
