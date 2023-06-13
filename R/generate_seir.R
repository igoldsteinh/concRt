#' generate_seir
#'
#' @param samples
#' @param data_cases
#' @param obstimes
#' @param param_change_times
#' @param extra_ode_precision
#' @param seed
#' @param fit_abs_tol
#' @param fit_rel_tol
#' @param popsize
#' @param active_pop
#' @param gamma_sd
#' @param gamma_mean
#' @param nu_sd
#' @param nu_mean
#' @param rho_case_sd
#' @param rho_case_mean
#' @param phi_sd
#' @param phi_mean
#' @param sigma_R0_sd
#' @param sigma_R0_mean
#' @param S_SEI_sd
#' @param S_SEI_mean
#' @param I_EI_sd
#' @param I_EI_mean
#' @param r0_init_sd
#' @param r0_init_mean
#'
#' @return
#' @export
#'
#' @examples
generate_seir <- function(samples,
                          data_cases,
                          obstimes,
                          param_change_times,
                          extra_ode_precision,
                          seed = 1,
                          fit_abs_tol = 1e-9,
                          fit_rel_tol = 1e-6,
                          popsize = 100000L,
                          active_pop = 90196L,
                          gamma_sd = 0.2,
                          gamma_mean =log(7/4),
                          nu_sd = 0.2,
                          nu_mean = log(7/7),
                          rho_case_sd =  0.4,
                          rho_case_mean = -1.386294,
                          phi_sd = 0.2,
                          phi_mean = log(50),
                          sigma_R0_sd = 0.2,
                          sigma_R0_mean = log(0.1),
                          S_SEI_sd = 0.05,
                          S_SEI_mean = 4.83091,
                          I_EI_sd = 0.05,
                          I_EI_mean = 0.7762621,
                          r0_init_sd = 0.1,
                          r0_init_mean = log(0.88)) {
  JuliaCall::julia_call("generate_pp_and_gq_seir",
                        samples,
                        data_cases,
                        obstimes,
                        param_change_times,
                        extra_ode_precision,
                        seed,
                        fit_abs_tol,
                        fit_rel_tol,
                        popsize,
                        active_pop,
                        gamma_sd,
                        gamma_mean,
                        nu_sd,
                        nu_mean,
                        rho_case_sd,
                        rho_case_mean,
                        phi_sd,
                        phi_mean,
                        sigma_R0_sd,
                        sigma_R0_mean,
                        S_SEI_sd,
                        S_SEI_mean,
                        I_EI_sd,
                        I_EI_mean,
                        r0_init_sd,
                        r0_init_mean)

}
