library("targets")

#---- Settings ----
# Options
options(tidyverse.quiet = TRUE)
# Packages
tar_option_set(packages = "tidyverse")
tar_option_set(packages = "ggplot2")

#---- Workflow ----
list(
  # Get data
  tar_target(rawfilename, "BigData.csv", format = "file"),
  tar_target(MyData, read.csv2(rawfilename)),
  # Descriptive statistics
  tar_target(plot_evol, ggplot(MyData, aes(x=Days, y=Reaction, color=ID)) + geom_point() + geom_line()
  ),
  # linear model
  tar_target(m1, lm (Reaction~Days, data=MyData)),
  # Checking assumptions
  tar_target(check, performance::check_model(m1)),
  # Inferential statistics
  tar_target(lm_fit, ggplot(MyData, aes(x=Days, y=Reaction)) + geom_point() + geom_smooth(method = "lm"))
)
