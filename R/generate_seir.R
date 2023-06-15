#' generate_seir
#'
#' Call `generate_pp_and_gq_seir` in Julia to transform output from `fit_seir` to useable dataframes
#'
#' Default priors are for scenario 1 and assume model is fit to a weekly time scale.
#'
#' @param samples output from `fit_seir`
#' @param data_cases vector: observed cases
#' @param obstimes vector: times cases are observed
#' @param param_change_times vector: times reproduction number is allowed to change
#' @param extra_ode_precision boolean: if TRUE, uses custom ode precisions, otherwise uses DifferentialEquations.jl default values
#' @param seed integer: random seed
#' @param fit_abs_tol float64: if `extra_ode_precision` TRUE, absolute tolerance for model fitting
#' @param fit_rel_tol float64: if `extra_ode_precision` TRUE, relative tolerance for model fitting
#' @param popsize integer: population size
#' @param active_pop intger: population size - initial size of R compartment
#' @param gamma_sd float64: standard deviation for normal prior of log gamma
#' @param gamma_mean float64: mean for normal prior of log gamma
#' @param nu_sd float64: standard deviation for normal prior of log nu
#' @param nu_mean float64: mean for normal prior of log nu
#' @param rho_case_sd float64: standard devation for normal prior of log rho
#' @param rho_case_mean float64: mean for normal prior of log rho
#' @param phi_sd float64: standard deviation for normal prior of log phi
#' @param phi_mean float64: mean for normal prior of log phi
#' @param sigma_R0_sd flaot64: standard deviation for normal prior of log sigma R0
#' @param sigma_R0_mean float64: mean for normal prior of log sigma R0
#' @param S_SEI_sd float64: standard deviation for normal prior of logit fraction of active pop initially in S
#' @param S_SEI_mean flaot64: mean for normal prior of logit fraction of active pop initially in S
#' @param I_EI_sd float64: standard deviation for normal prior of logit fraction of the E and I compartments initially in I
#' @param I_EI_mean float64: mean for normal prior of logit fraction of the E and I compartments initially in I
#' @param r0_init_sd float64: standard deviation for normal prior of log R0
#' @param r0_init_mean float64: mean for normal prior of log R0
#'
#' @return List of three dataframes, posterior predictive, scaled posterior, and un-scaled posterior
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
