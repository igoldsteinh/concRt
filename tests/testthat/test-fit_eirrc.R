test_that("fit_eirrc works", {
  long_dat <- scenario1_genecount_data %>%
    filter(seed == 1) %>%
    dplyr::select(new_time, log_gene_copies1, log_gene_copies2, log_gene_copies3) %>% pivot_longer(-new_time)

  obs <- long_dat$value
  time <- long_dat$new_time
  priors_only <- FALSE
  n_samples <- 10L
  n_chains <- 1L
  seed <- 1L

  JuliaCall::julia_library("testpackage")
  JuliaCall::julia_library("Logging")
  JuliaCall::julia_command("Logging.disable_logging(Logging.Warn)")

  testing3 <- fit_eirrc(obs, time, priors_only, n_samples, n_chains, seed)

  expect_equal(length(testing3), 10)
})
