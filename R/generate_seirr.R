#' generate_seirr
#'
#' @param samples
#' @param data_cases
#' @param obstimes
#' @param param_change_times
#' @param extra_ode_precision
#' @param fit_abs_tol
#' @param fit_rel_tol
#' @param seed
#' @param popsize
#' @param active_pop
#' @param gamma_sd
#' @param gamma_mean
#' @param nu_sd
#' @param nu_mean
#' @param eta_sd
#' @param eta_mean
#' @param rho_gene_sd
#' @param rho_gene_mean
#' @param tau_sd
#' @param tau_mean
#' @param sigma_R0_sd
#' @param sigma_R0_mean
#' @param S_SEIR1_sd
#' @param S_SEIR1_mean
#' @param I_EIR1_sd
#' @param I_EIR1_mean
#' @param R1_ER1_sd
#' @param R1_ER1_mean
#' @param r0_init_sd
#' @param r0_init_mean
#' @param lambda_mean
#' @param lambda_sd
#' @param df_shape
#' @param df_scale
#'
#' @return
#' @export
#'
#' @examples
generate_seirr <- function(samples,
                           data_cases,
                           obstimes,
                           param_change_times,
                           extra_ode_precision,
                           seed = 1,
                           fit_abs_tol = 1e-9,
                           fit_rel_tol = 1e-6,
                           popsize = 100000L,
                           active_pop = 92271L,
                           gamma_sd = 0.2,
                           gamma_mean =log(1/4),
                           nu_sd = 0.2,
                           nu_mean = log(1/7),
                           eta_sd = 0.2,
                           eta_mean = log(1/18),
                           rho_gene_sd =  1.0,
                           rho_gene_mean = 0.0,
                           tau_sd = 1.0,
                           tau_mean = 0.0,
                           sigma_R0_sd = 0.2,
                           sigma_R0_mean = log(0.1),
                           S_SEIR1_sd = 0.05,
                           S_SEIR1_mean = 3.468354,
                           I_EIR1_sd = 0.05,
                           I_EIR1_mean = -1.548302,
                           R1_ER1_sd = 0.05,
                           R1_ER1_mean = 2.221616,
                           r0_init_sd = 0.2,
                           r0_init_mean = log(0.88),
                           lambda_mean = 5.685528,
                           lambda_sd = 2.178852,
                           df_shape = 2.0,
                           df_scale = 10.0) {
  JuliaCall::julia_call("generate_pp_and_gq_seirr",
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
                        eta_sd,
                        eta_mean,
                        rho_gene_sd,
                        rho_gene_mean,
                        tau_sd,
                        tau_mean,
                        sigma_R0_sd,
                        sigma_R0_mean,
                        S_SEIR1_sd,
                        S_SEIR1_mean,
                        I_EIR1_sd,
                        I_EIR1_mean,
                        R1_ER1_sd,
                        R1_ER1_mean,
                        r0_init_sd,
                        r0_init_mean,
                        lambda_mean,
                        lambda_sd,
                        df_shape,
                        df_scale)

}
