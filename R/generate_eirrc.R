#' generate_eirrc
#'
#'Generate correctly scaled posterior samples, predictive distributions, and dataframe of un-scaled samples from Turing object.
#'The model must be reconstructed, so many parameters are re-used from fit_eirrc. If there is no description, check fit_eirrc for parameter explanation.
#' @param samples a Turing chains object generated from fitting a Turing model
#' @param obs
#' @param time
#' @param seed
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
#' @param I_init_sd
#' @param I_init_mean
#' @param R1_init_sd
#' @param R1_init_mean
#' @param E_init_sd
#' @param E_init_mean
#' @param lambda_mean
#' @param lambda_sd
#' @param df_shape
#' @param df_scale
#' @param sigma_rt_sd
#' @param sigma_rt_mean
#' @param rt_init_sd
#' @param rt_init_mean
#'
#' @return list of length 3, first element is predictive distribution, second is scaled samples, third is unscaled samples
#' @export
#'
#' @examples
generate_eirrc <- function(samples,
                           obs,
                           time,
                           seed,
                           gamma_sd = 0.2,
                           gamma_mean =log(1/4),
                           nu_sd = 0.2,
                           nu_mean = log(1/7),
                           eta_sd = 0.2,
                           eta_mean = log(1/18),
                           rho_gene_sd = 1.0,
                           rho_gene_mean = 0.0,
                           tau_sd = 1.0,
                           tau_mean = 0.0,
                           I_init_sd = 0.05,
                           I_init_mean = 489.0,
                           R1_init_sd = 0.05,
                           R1_init_mean = 2075.0,
                           E_init_sd = 0.05,
                           E_init_mean = 225.0,
                           lambda_mean = 5.685528,
                           lambda_sd = 2.178852,
                           df_shape = 2.0,
                           df_scale = 10.0,
                           sigma_rt_sd = 0.2,
                           sigma_rt_mean = log(0.1),
                           rt_init_sd = 0.1,
                           rt_init_mean = log(0.88)) {
  JuliaCall::julia_call("generate_pp_and_gq_eirrc",
             samples,
             obs,
             time,
             seed,
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
             I_init_sd,
             I_init_mean,
             R1_init_sd,
             R1_init_mean,
             E_init_sd,
             E_init_mean,
             lambda_mean,
             lambda_sd,
             df_shape,
             df_scale,
             sigma_rt_sd,
             sigma_rt_mean,
             rt_init_sd,
             rt_init_mean)

}
