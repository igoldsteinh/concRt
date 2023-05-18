## code to prepare `my_pkg_data` dataset goes here

# we should put the actual simulation code here
# we will skip it for now
scenario1_genecount_data <- read_csv(here::here("data", "scenario1_fitted_genecount_obsdata.csv"))

usethis::use_data(scenario1_genecount_data, overwrite = TRUE)
