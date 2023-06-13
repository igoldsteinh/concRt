#' generate_eir
#'
#' @param samples
#' @param data_cases
#' @param obstimes
#' @param param_change_times
#' @param priors_only
#' @param seed
#' @param gamma_sd
#' @param gamma_mean
#' @param nu_sd
#' @param nu_mean
#' @param rho_case_sd
#' @param rho_case_mean
#' @param phi_sd
#' @param phi_mean
#' @param I_init_sd
#' @param I_init_mean
#' @param E_init_sd
#' @param E_init_mean
#' @param sigma_rt_sd
#' @param sigma_rt_mean
#' @param rt_init_sd
#' @param rt_init_mean
#'
#' @return
#' @export
#'
#' @examples
generate_eir <- function(samples,
                           data_cases,
                           obstimes,
                           param_change_times,
                           priors_only,
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
             priors_only,
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
