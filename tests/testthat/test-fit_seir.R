test_that("fit_seir works", {
  long_dat <- scenario1_case_data %>%
    dplyr::filter(seed == 1)

  data_cases <- long_dat$total_cases
  obstimes <- long_dat$new_week
  param_change_times <- obstimes[1:(length(obstimes) -1)]
  extra_ode_precision <- TRUE
  priors_only <- FALSE
  n_samples <- 10L
  n_chains <- 1L
  seed <- 1L

  julia <- JuliaCall::julia_setup(JULIA_HOME = "/Users/isaacgoldstein/.juliaup/bin")

  JuliaCall::julia_library("testpackage")
  JuliaCall::julia_library("Logging")
  JuliaCall::julia_command("Logging.disable_logging(Logging.Warn)")

  testing <- fit_seir(data_cases,
                     obstimes,
                     param_change_times,
                     extra_ode_precision,
                     priors_only,
                     n_samples,
                     n_chains,
                     seed)

  expect_equal(length(testing), 10)
})
