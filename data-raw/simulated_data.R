## code to prepare `my_pkg_data` dataset goes here

# we should put the actual simulation code here
# we will skip it for now
# geneconc data
scenario1_genecount_data <- read_csv(here::here("data", "scenario1_fitted_genecount_obsdata.csv"))

usethis::use_data(scenario1_genecount_data, overwrite = TRUE)

# full sim data
full_simdata_address <- paste0("data/scenario", 1, "_full_genecount_obsdata.csv")

scenario1_fullsimdata <- read_csv(full_simdata_address) %>% filter(seed == 1) %>% rename("true_rt" = "Rt",
                                                                                "r0" = "R0")
usethis::use_data(scenario1_fullsimdata, overwrite = TRUE)

# case data
scenario1_case_data <- read_csv(here::here("data", "scenario1_fitted_cases_obsdata.csv"))

usethis::use_data(scenario1_case_data, overwrite = TRUE)
