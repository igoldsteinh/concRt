#' generate_eir
#'
#'#' Call `generate_pp_and_gq_eir` in julia to transform output of `fit_eir` to useable dataframes
#'
#' Default priors are for scenario 1, and assume the model is being fit to a daily time scale
#'
#' @param samples output from `fit_eir`
#' @param data_cases vector: observed cases
#' @param obstimes vector: times cases are observed
#' @param param_change_times vector: times reproduction number is allowed to change
#' @param seed integer: random seed
#' @param gamma_sd float64: standard deviation for normal prior of log gamma
#' @param gamma_mean float64: mean for normal prior of log gamma
#' @param nu_sd float64: standard deviation for normal prior of log nu
#' @param nu_mean float64: mean for normal prior of log nu
#' @param rho_case_sd float64: standard devation for normal prior of log rho
#' @param rho_case_mean float64: mean for normal prior of log rho
#' @param phi_sd float64: standard deviation for normal prior of log phi
#' @param phi_mean float64: mean for normal prior of log phi
#' @param I_init_sd float64: standard deviation for normal prior of I_init
#' @param I_init_mean float64: mean for normal prior of I_init
#' @param E_init_sd float64: standard deviation for normal prior of E_init
#' @param E_init_mean float64: mean for normal prior of E_init
#' @param sigma_rt_sd float64: standard deviation for normal prior on log sigma rt
#' @param sigma_rt_mean float64: mean for normal prior on log sigma rt
#' @param rt_init_sd float64: standard deviation for normal prior on log rt_init
#' @param rt_init_mean float64: mean for normal prior on log rt_init
#'
#' @return List of three dataframes, posterior predictive, scaled posterior, and un-scaled posterior
#' @export
#'
#' @examples
generate_eir <- function(samples,
                           data_cases,
                           obstimes,
                           param_change_times,
                           seed = 1,
                           gamma_sd = 0.2,
                           gamma_mean =log(1/4),
                           nu_sd = 0.2,
                           nu_mean = log(1/7),
                           rho_case_sd = 1.0,
                           rho_case_mean = 0.0,
                           phi_sd = 0.2,
                           phi_mean = log(50),
                           I_init_sd = 0.05,
                           I_init_mean = 489.0,
                           E_init_sd = 0.05,
                           E_init_mean = 225.0,
                           sigma_rt_sd = 0.2,
                           sigma_rt_mean = log(0.1),
                           rt_init_sd = 0.1,
                           rt_init_mean = log(0.88)) {
  JuliaCall::julia_call("generate_pp_and_gq_eir",
             samples,
             data_cases,
             obstimes,
             param_change_times,
             seed,
             gamma_sd,
             gamma_mean,
             nu_sd,
             nu_mean,
             rho_case_sd,
             rho_case_mean,
             phi_sd,
             phi_mean,
             I_init_sd,
             I_init_mean,
             E_init_sd,
             E_init_mean,
             sigma_rt_sd,
             sigma_rt_mean,
             rt_init_sd,
             rt_init_mean)

}
