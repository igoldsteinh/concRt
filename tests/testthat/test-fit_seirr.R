test_that("fit_seirr works", {
  long_dat <- scenario1_genecount_data %>%
    filter(seed == 1) %>%
    dplyr::select(new_time, log_gene_copies1, log_gene_copies2, log_gene_copies3) %>% pivot_longer(-new_time)

  obs <- long_dat$value
  time <- long_dat$new_time
  param_change_times <- c(7.0, 14.0, 21.0, 28.0, 35.0, 42.0, 49.0, 56.0, 63.0, 70.0, 77.0, 84.0, 91.0, 98.0, 105.0, 112.0, 119.0, 126.0)
  extra_ode_precision <- TRUE
  priors_only <- FALSE
  n_samples <- 10L
  n_chains <- 1L
  seed <- 1L

  julia <- JuliaCall::julia_setup(JULIA_HOME = "/Users/isaacgoldstein/.juliaup/bin")

  JuliaCall::julia_library("testpackage")
  JuliaCall::julia_library("Logging")
  JuliaCall::julia_command("Logging.disable_logging(Logging.Warn)")

  testing3 <- fit_seirr(obs,
                        time,
                        param_change_times,
                        extra_ode_precision,
                        priors_only,
                        n_samples,
                        n_chains,
                        seed)

  expect_equal(length(testing3), 10)
})
