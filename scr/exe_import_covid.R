# Solution to excercise "Import data":

# load packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(tibble)

state <- c("BY", "NRW", "BW")
deaths <- c(4.92, 5.32, 3.69)
cases <- c(24111, 25466, 16145)
df_covid <- data.frame(state, deaths)
tbl_covid <- tibble(state, deaths)

tbl_covid

suppressMessages(pacman::p_unload(tibble))